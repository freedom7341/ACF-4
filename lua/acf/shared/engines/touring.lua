
-- Touring car engines for Avtomat events 2021

ACF.RegisterEngineClass("TOUR", {
	Name = "Touring Engine",
})

do -- Touring I4
	ACF.RegisterEngine("1.6-I4T", "TOUR", {
		Name		 = "1.6L I4T Petrol",
		Description	 = "1.6L turbocharged touring car engine",
		Model		 = "models/engines/inline4s.mdl",
		Sound		 = "acf_engines/i4_petrol20_2.WAV",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 82,
		Torque		 = 310,
		FlywheelMass = 0.041,
		RPM = {
			Idle	= 1100,
			PeakMin	= 4000,
			PeakMax	= 7000,
			Limit	= 8800,
		},
		Preview = {
			FOV = 100,
		},
	})

	ACF.RegisterEngine("2.5-I4T", "TOUR", {
		Name		 = "2.5L I4T Petrol",
		Description	 = "2.5L turbocharged touring car engine",
		Model		 = "models/engines/inline4s.mdl",
		Sound		 = "acf_engines/i4_petrol20_2.WAV",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 129,
		Torque		 = 396,
		FlywheelMass = 0.1,
		RPM = {
			Idle	= 1100,
			PeakMin	= 3700,
			PeakMax	= 6620,
			Limit	= 7500,
		},
		Preview = {
			FOV = 100,
		},
	})

	ACF.RegisterEngine("2.5-I4", "TOUR", {
		Name		 = "2.5L I4 Petrol",
		Description	 = "2.5L I4 touring car engine",
		Model		 = "models/engines/inline4s.mdl",
		Sound		 = "acf_engines/i4_petrol20_2.WAV",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 97,
		Torque		 = 284,
		FlywheelMass = 0.1,
		RPM = {
			Idle	= 900,
			PeakMin	= 3500,
			PeakMax	= 6000,
			Limit	= 7200,
		},
		Preview = {
			FOV = 100,
		},
	})
end

do -- Touring B4
	ACF.RegisterEngine("2.5-B4T", "TOUR", {
		Name		 = "2.5L B4T Petrol",
		Description	 = "2.5L turbocharged B4 touring car engine",
		Model		 = "models/engines/b4small.mdl",
		Sound		 = "acf_base/engines/b4_petrolmedium.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 119,
		Torque		 = 396,
		FlywheelMass = 0.09,
		RPM = {
			Idle	= 1000,
			PeakMin	= 3800,
			PeakMax	= 6620,
			Limit	= 8000,
		},
		Preview = {
			FOV = 100,
		},
	})

	ACF.RegisterEngine("2.5-B4", "TOUR", {
		Name		 = "2.5L B4 Petrol",
		Description	 = "2.5L B4 touring car engine",
		Model		 = "models/engines/b4small.mdl",
		Sound		 = "acf_base/engines/b4_petrolmedium.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 90,
		Torque		 = 285,
		FlywheelMass = 0.09,
		RPM = {
			Idle	= 940,
			PeakMin	= 3600,
			PeakMax	= 6000,
			Limit	= 8000,
		},
		Preview = {
			FOV = 100,
		},
	})
end

do -- Touring V6
	ACF.RegisterEngine("2.5L-V6", "TOUR", {
		Name		 = "2.5L V6 Petrol",
		Description	 = "Touring car 300hp class engine",
		Model		 = "models/engines/v6small.mdl",
		Sound		 = "acf_base/engines/v6_petrolsmall.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 150,
		Torque		 = 295,
		FlywheelMass = 0.075,
		RPM = {
			Idle	= 1000,
			PeakMin	= 3600,
			PeakMax	= 5800,
			Limit	= 7500,
		},
		Preview = {
			FOV = 100,
		},
	})

	ACF.RegisterEngine("2.5L-V6T", "TOUR", {
		Name		 = "2.5L V6T Petrol",
		Description	 = "2.5L turbocharged V6 touring car engine",
		Model		 = "models/engines/v6small.mdl",
		Sound		 = "acf_base/engines/v6_petrolsmall.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 180,
		Torque		 = 404,
		FlywheelMass = 0.075,
		RPM = {
			Idle	= 1250,
			PeakMin	= 4500,
			PeakMax	= 6500,
			Limit	= 7200,
		},
		Preview = {
			FOV = 100,
		},
	})
end

do -- Touring I6
	ACF.RegisterEngine("2.5L-I6", "TOUR", {
		Name		 = "2.5L I6 Petrol",
		Description	 = "2.5L I6 touring car engine",
		Model		 = "models/engines/inline6s.mdl",
		Sound		 = "acf_base/engines/l6_petrolsmall2.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 160,
		Torque		 = 276,
		FlywheelMass = 0.065,
		RPM = {
			Idle	= 870,
			PeakMin	= 3400,
			PeakMax	= 6200,
			Limit	= 8000,
		},
		Preview = {
			FOV = 100,
		},
	})

	ACF.RegisterEngine("2.5L-I6T", "TOUR", {
		Name		 = "2.5L I6T Petrol",
		Description	 = "2.5L turbocharged I6 touring car engine",
		Model		 = "models/engines/inline6s.mdl",
		Sound		 = "acf_base/engines/l6_petrolsmall2.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 180,
		Torque		 = 386,
		FlywheelMass = 0.065,
		RPM = {
			Idle	= 1080,
			PeakMin	= 4000,
			PeakMax	= 6800,
			Limit	= 8000,
		},
		Preview = {
			FOV = 100,
		},
	})
end

do -- Touring I5
	ACF.RegisterEngine("2.5L-I5", "TOUR", {
		Name		 = "2.5L I5 Petrol",
		Description	 = "2.5L I5 touring car engine",
		Model		 = "models/engines/inline5s.mdl",
		Sound		 = "acf_base/engines/i5_petrolsmall.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 130,
		Torque		 = 285,
		FlywheelMass = 0.1,
		RPM = {
			Idle	= 900,
			PeakMin	= 3300,
			PeakMax	= 6000,
			Limit	= 7000,
		},
		Preview = {
			FOV = 100,
		},
	})

	ACF.RegisterEngine("2.5L-I5T", "TOUR", {
		Name		 = "2.5L I5T Petrol",
		Description	 = "2.5L turbocharged I5 touring car engine",
		Model		 = "models/engines/inline5s.mdl",
		Sound		 = "acf_base/engines/i5_petrolsmall.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 160,
		Torque		 = 409,
		FlywheelMass = 0.1,
		RPM = {
			Idle	= 900,
			PeakMin	= 4400,
			PeakMax	= 6420,
			Limit	= 6900,
		},
		Preview = {
			FOV = 100,
		},
	})
end

do -- Touring V8
	ACF.RegisterEngine("4.0L-V8", "TOUR", {
		Name		 = "4.0L V8 Petrol",
		Description	 = "4.0L V8 touring car engine",
		Model		 = "models/engines/v8s.mdl",
		Sound		 = "acf_base/engines/v8_petrolsmall.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 200,
		Torque		 = 396,
		TorqueCurve	 = {0.2, 0.5, 0.8, 0.9, 1, 0.7},
		FlywheelMass = 0.1,
		RPM = {
			Idle	= 900,
			PeakMin	= 4000,
			PeakMax	= 6620,
			Limit	= 8500,
		},
		Preview = {
			FOV = 100,
		},
	})
end