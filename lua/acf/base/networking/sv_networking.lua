local ACF      = ACF
local Network  = ACF.Networking
local Sender   = Network.Sender
local Receiver = Network.Receiver
local ToJSON   = util.TableToJSON
local ToTable  = util.JSONToTable
local Messages = {}
local IsQueued

util.AddNetworkString("ACF_Networking")

local function PrepareQueue(Target, Name)
	if not Messages[Target] then
		Messages[Target] = {
			[Name] = {}
		}
	elseif not Messages[Target][Name] then
		Messages[Target][Name] = {}
	end

	return Messages[Target][Name]
end

-- NOTE: Consider the overflow size
local function SendMessages()
	local All = Messages.All

	if All and next(All) then
		net.Start("ACF_Networking")
			net.WriteString(ToJSON(All))
		net.Broadcast()

		Messages.All = nil
	end

	if next(Messages) then
		for Target, Data in pairs(Messages) do
			net.Start("ACF_Networking")
				net.WriteString(ToJSON(Data))
			net.Send(Target)

			Messages[Target] = nil
		end
	end

	IsQueued = nil
end

function Network.Broadcast(Name, ...)
	if not Name then return end
	if not Sender[Name] then return end

	local Handler = Sender[Name]
	local Queue   = PrepareQueue("All", Name)

	Handler(Queue, ...)

	if not IsQueued then
		IsQueued = true

		timer.Simple(0, SendMessages)
	end
end

function Network.Send(Name, Player, ...)
	if not Name then return end
	if not Sender[Name] then return end
	if not IsValid(Player) then return end

	local Handler = Sender[Name]
	local Queue   = PrepareQueue(Player, Name)

	Handler(Queue, ...)

	if not IsQueued then
		IsQueued = true

		timer.Simple(0, SendMessages)
	end
end

net.Receive("ACF_Networking", function(_, Player)
	local Message = ToTable(net.ReadString())

	for Name, Data in pairs(Message) do
		local Handler = Receiver[Name]

		if Handler then
			Handler(Player, Data)
		end
	end
end)
