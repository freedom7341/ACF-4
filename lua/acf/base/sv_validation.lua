-- Entity validation for ACF

-- Local Vars -----------------------------------
local ACF          = ACF
local StringFind   = string.find
local TimerSimple  = timer.Simple
local Baddies	   = ACF.GlobalFilter
local MinimumArmor = ACF.MinimumArmor
local MaximumArmor = ACF.MaximumArmor

--[[ ACF Legality Check
	ALL SENTS MUST HAVE:
	ENT.ACF.PhysObj defined when spawned
	ENT.ACF.LegalMass defined when spawned
	ENT.ACF.Model defined when spawned

	ACF_CheckLegal(entity) called when finished spawning

	function ENT:Enable()
		<code>
	end

	function ENT:Disable()
		<code>
	end
]]--
local function IsLegal(Entity)
	if ACF.Gamemode == 1 then return true end -- Gamemode is set to Sandbox, legal checks don't apply

	local Phys = Entity:GetPhysicsObject()

	if Entity.ACF.PhysObj ~= Phys then
		if Phys:GetVolume() then
			Entity.ACF.PhysObj = Phys -- Updated PhysObj
		else
			Entity:Remove() -- Remove spherical trash
			return false, "Invalid physics", "" -- This shouldn't even run
		end
	end
	if Entity.ClipData and next(Entity.ClipData) then return false, "Visual Clip", "Visual clip cannot be applied to ACF entities." end -- No visclip
	if Entity.IsWeapon and not ACF.GunsCanFire then return false, "Cannot fire", "Firing disabled by the servers ACF settings." end
	if Entity.IsRack and not ACF.RacksCanFire then return false, "Cannot fire", "Firing disabled by the servers ACF settings." end

	return true
end

local function CheckLegal(Entity)
	local Legal, Reason, Description = IsLegal(Entity)

	if not Legal then -- Not legal
		if Reason ~= Entity.DisableReason then -- Only complain if the reason has changed
			local Owner = Entity:CPPIGetOwner()

			Entity.Disabled		 = true
			Entity.DisableReason = Reason
			Entity.DisableDescription = Description

			Entity:Disable() -- Let the entity know it's disabled

			if Entity.UpdateOverlay then Entity:UpdateOverlay(true) end -- Update overlay if it has one (Passes true to update overlay instantly)
			if tobool(Owner:GetInfo("acf_legalhints")) then -- Notify the owner
				local Name = Entity.WireDebugName .. " [" .. Entity:EntIndex() .. "]"

				if Reason == "Not drawn" or Reason == "Not solid" then -- Thank you garry, very cool
					timer.Simple(1.1, function() -- Remover tool sets nodraw and removes 1 second later, causing annoying alerts
						if not IsValid(Entity) then return end

						ACF.SendNotify(Owner, false, Name .. " has been disabled: " .. Description)
					end)
				else
					ACF.SendNotify(Owner, false, Name .. " has been disabled: " .. Description)
				end
			end
		end

		TimerSimple(ACF.IllegalDisableTime, function() -- Check if it's legal again in ACF.IllegalDisableTime
			if IsValid(Entity) and CheckLegal(Entity) then
				Entity.Disabled	   	 = nil
				Entity.DisableReason = nil
				Entity.DisableDescription = nil

				Entity:Enable()

				if Entity.UpdateOverlay then Entity:UpdateOverlay(true) end
			end
		end)

		return false
	end

	if ACF.Gamemode ~= 1 then
		TimerSimple(math.Rand(1, 3), function() -- Entity is legal... test again in random 1 to 3 seconds
			if IsValid(Entity) then
				CheckLegal(Entity)
			end
		end)
	end

	return true
end
local function GetEntityType(Entity)
	if Entity:IsPlayer() or Entity:IsNPC() or Entity:IsNextBot() then return "Squishy" end
	if Entity:IsVehicle() then return "Vehicle" end

	return "Prop"
end

local function UpdateArea(Entity, PhysObj)
	local Area = PhysObj:GetSurfaceArea()

	if Area then -- Normal collisions
		Area = Area * 6.45 * 0.52505066107
	elseif PhysObj:GetMesh() then -- Box collisions
		local Size = Entity:OBBMaxs() - Entity:OBBMins()

		Area = ((Size.x * Size.y) + (Size.x * Size.z) + (Size.y * Size.z)) * 6.45
	else -- Spherical collisions
		local Radius = Entity:BoundingRadius()

		Area = 4 * 3.1415 * Radius * Radius * 6.45
	end

	Entity.ACF.Area = Area

	return Area
end

local function UpdateThickness(Entity, PhysObj, Area, Ductility)
	local Thickness = Entity.ACF.Thickness
	local EntMods = Entity.EntityMods
	local MassMod = EntMods and EntMods.mass

	if Thickness then
		if not MassMod then
			local Mass = Area * (1 + Ductility) ^ 0.5 * Thickness * 0.00078

			if Mass ~= Entity.ACF.Mass then
				Entity.ACF.Mass = Mass

				PhysObj:SetMass(Mass)
			end

			return Thickness
		end

		Entity.ACF.Thickness = nil

		duplicator.ClearEntityModifier(Entity, "ACF_Armor")
		duplicator.StoreEntityModifier(Entity, "ACF_Armor", { Ductility = Ductility * 100 })
	end

	local Mass  = MassMod and MassMod.Mass or PhysObj:GetMass()
	local Armor = ACF_CalcArmor(Area, Ductility, Mass)

	if Mass ~= Entity.ACF.Mass then
		Entity.ACF.Mass = Mass

		PhysObj:SetMass(Mass)

		duplicator.StoreEntityModifier(Entity, "mass", { Mass = Mass })
	end

	return math.Clamp(Armor, MinimumArmor, MaximumArmor)
end

hook.Add("ACF_OnServerDataUpdate", "ACF_MaxThickness", function(_, Key, Value)
	if Key ~= "MaxThickness" then return end

	MaximumArmor = math.floor(ACF.CheckNumber(Value, ACF.MaximumArmor))
end)

-- Global Funcs ---------------------------------

function ACF.Check(Entity, ForceUpdate) -- IsValid but for ACF
	if not IsValid(Entity) then return false end

	local Class = Entity:GetClass()
	if Baddies[Class] then return false end

	local PhysObj = Entity:GetPhysicsObject()
	if not IsValid(PhysObj) then return false end

	if not Entity.ACF then
		if Entity:IsWorld() or Entity:IsWeapon() or StringFind(Class, "func_") then
			Baddies[Class] = true

			return false
		end

		ACF.Activate(Entity)
	elseif ForceUpdate or Entity.ACF.Mass ~= PhysObj:GetMass() or Entity.ACF.PhysObj ~= PhysObj then
		ACF.Activate(Entity, true)
	end

	return Entity.ACF.Type
end

function ACF.Activate(Entity, Recalc)
	--Density of steel = 7.8g cm3 so 7.8kg for a 1mx1m plate 1m thick
	local PhysObj = Entity:GetPhysicsObject()

	if not IsValid(PhysObj) then return end

	if not Entity.ACF then
		Entity.ACF = {
			Type = GetEntityType(Entity)
		}
	end

	Entity.ACF.PhysObj = PhysObj

	if Entity.ACF_Activate then
		Entity:ACF_Activate(Recalc)
		return
	end

	local Area      = UpdateArea(Entity, PhysObj)
	local Ductility = math.Clamp(Entity.ACF.Ductility or 0, -0.8, 0.8)
	local Thickness = UpdateThickness(Entity, PhysObj, Area, Ductility)
	local Health    = (Area / ACF.Threshold) * (1 + Ductility) -- Setting the threshold of the prop Area gone
	local Percent   = 1

	if Recalc and Entity.ACF.Health and Entity.ACF.MaxHealth then
		Percent = Entity.ACF.Health / Entity.ACF.MaxHealth
	end

	Entity.ACF.Health    = Health * Percent
	Entity.ACF.MaxHealth = Health
	Entity.ACF.Armour    = Thickness * (0.5 + Percent * 0.5)
	Entity.ACF.MaxArmour = Thickness * ACF.ArmorMod
	Entity.ACF.Ductility = Ductility
end

-- Globalize ------------------------------------
ACF_IsLegal    = IsLegal
ACF_CheckLegal = CheckLegal
ACF_Check      = ACF.Check
ACF_Activate   = ACF.Activate
