if (isServer) then {
	// Argument 0 is module logic.
	_logic = param [0,objNull,[objNull]];
	// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
	_units = param [1,[],[[]]];
	// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
	_activated = param [2,true,[true]];

	if (isNil {EE_Scripts_vs_debug}) then {	EE_Scripts_vs_debug = "WARNING";};
	publicVariable "EE_Scripts_vs_debug";

	//Select the equipment config for the equipment type
	if ( isNil {EE_Scripts_vs_aa}) then {
		EE_Scripts_vs_aa = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "aa");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_vehicle}) then {
		EE_Scripts_vs_vehicle = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "vehicle");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_artillary}) then {
		EE_Scripts_vs_artillary = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "artillary");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_plane}) then {
		EE_Scripts_vs_plane = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "plane");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_boat}) then {
		EE_Scripts_vs_boat = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "boat");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_helicopter}) then {
		EE_Scripts_vs_helicopter = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "helicopter");
		publicVariable "EE_Scripts_us_debug";
	};

	//Select the equipment config for the equipment type
	if ( isNil {EE_Scripts_vs_respawn_aa}) then {
		EE_Scripts_vs_respawn_aa = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_aa");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_respawn_vehicle}) then {
		EE_Scripts_vs_respawn_vehicle = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_vehicle");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_respawn_artillary}) then {
		EE_Scripts_vs_respawn_artillary = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_artillary");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_respawn_plane}) then {
		EE_Scripts_vs_respawn_plane = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_plane");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_respawn_boat}) then {
		EE_Scripts_vs_respawn_boat = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_boat");
		publicVariable "EE_Scripts_us_debug";
	};
	if ( isNil {EE_Scripts_vs_respawn_helicopter}) then {
		EE_Scripts_vs_respawn_helicopter = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_helicopter");
		publicVariable "EE_Scripts_us_debug";
	};

	_type = _logic getVariable ["Type", "vehicle"];
	_logic setVariable ["Type", _type, true];
	["DEBUG", "vehicleSpawner", format["Vehicle type: %1", _type], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
	_level = _logic getVariable ["Level", 25]; //Level of the box
	_logic setVariable ["Level", _level, true];
	["DEBUG", "vehicleSpawner", format["Vehicle level: %1",_level], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
	_range = _logic getVariable ["Range", 5]; //Range for leveled Eqipment selection
	_logic setVariable ["Range", _range, true];
	["DEBUG", "vehicleSpawner", format["Vehicle range: %1",_range], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;

	if (_activated) then
	{
		["INFORMATION", "vehicleSpawner", "Activated", EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
		if ( isNil {EE_Scripts_vs_blacklist_aa}) then {
				EE_Scripts_vs_blacklist_aa = [];
				publicVariable "EE_Scripts_vs_blacklist_aa";
			};
		if ( isNil {EE_Scripts_vs_blacklist_vehicle}) then {
			EE_Scripts_vs_blacklist_vehicle = [];
			publicVariable "EE_Scripts_vs_blacklist_vehicle";
		};
		if ( isNil {EE_Scripts_vs_blacklist_artillary}) then {
			EE_Scripts_vs_blacklist_artillary = [];
			publicVariable "EE_Scripts_vs_blacklist_artillary";
		};
		if ( isNil {EE_Scripts_vs_blacklist_plane}) then {
			EE_Scripts_vs_blacklist_plane = [];
			publicVariable "EE_Scripts_vs_blacklist_plane";
		};
		if ( isNil {EE_Scripts_vs_blacklist_boat}) then {
			EE_Scripts_vs_blacklist_boat = [];
			publicVariable "EE_Scripts_vs_blacklist_boat";
		};
		if ( isNil {EE_Scripts_vs_blacklist_helicopter}) then {
			EE_Scripts_vs_blacklist_helicopter = [];
			publicVariable "EE_Scripts_vs_blacklist_helicopter";
		};

	 	[_logic] call EE_Scripts_fnc_vs_spawnVehicle;
	};
};
true
