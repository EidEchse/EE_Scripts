if (isServer) then {
	// Argument 0 is module logic.
	_logic = param [0,objNull,[objNull]];
	// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
	_units = param [1,[],[[]]];
	// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
	_activated = param [2,true,[true]];

	//Modulename for Messages
	_module = "vehicleSpawner";
	_debug = "WARNING";
	if (!isNil "EE_Scripts_vs_debug") then {
		_debug = EE_Scripts_vs_debug;
	};
	_logic setVariable ["Module", _module];
	_logic setVariable ["Debug", _debug];

	//Select the equipment config for the equipment type
	if ( isNil "EE_Scripts_vs_aa") then {
		EE_Scripts_vs_aa = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "aa");
	};
	if ( isNil "EE_Scripts_vs_vehicle") then {
		EE_Scripts_vs_vehicle = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "vehicle");
	};
	if ( isNil "EE_Scripts_vs_artillary") then {
		EE_Scripts_vs_artillary = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "artillary");
	};
	if ( isNil "EE_Scripts_vs_plane") then {
		EE_Scripts_vs_plane = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "plane");
	};
	if ( isNil "EE_Scripts_vs_boat") then {
		EE_Scripts_vs_boat = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "boat");
	};
	if ( isNil "EE_Scripts_vs_helicopter") then {
		EE_Scripts_vs_helicopter = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "helicopter");
	};

	//Select the equipment config for the equipment type
	if ( isNil "EE_Scripts_vs_respawn_aa") then {
		EE_Scripts_vs_respawn_aa = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_aa");
	};
	if ( isNil "EE_Scripts_vs_respawn_vehicle") then {
		EE_Scripts_vs_respawn_vehicle = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_vehicle");
	};
	if ( isNil "EE_Scripts_vs_respawn_artillary") then {
		EE_Scripts_vs_respawn_artillary = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_artillary");
	};
	if ( isNil "EE_Scripts_vs_respawn_plane") then {
		EE_Scripts_vs_respawn_plane = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_plane");
	};
	if ( isNil "EE_Scripts_vs_respawn_boat") then {
		EE_Scripts_vs_respawn_boat = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_boat");
	};
	if ( isNil "EE_Scripts_vs_respawn_helicopter") then {
		EE_Scripts_vs_respawn_helicopter = getArray ( configfile >> "EE_Scripts" >> "vehicleSpawner" >> "respawn_helicopter");
	};

	_level = _logic getVariable ["Level", 25]; //Level of the box
	if (_level < 0) then
	{
		["WARNING", _module, format ["Box level %1 lower than 0", _level], _debug] spawn EE_Scripts_fnc_debug;
		_level = 0;
	};

	_type = _logic getVariable ["Type", "vehicle"]; //Type of equipment
	_logic setVariable ["Type", _type];
	["DEBUG", _module, format["Box type: %1", _type], _debug] spawn EE_Scripts_fnc_debug;
	switch (_type) do
	{
		case "aa":
		{
			if (_level > (count EE_Scripts_vs_aa - 1)) then
			{
				["WARNING", _module, format ["Box level %1 higher than item config level %2", _level, count EE_Scripts_vs_aa], _debug] spawn EE_Scripts_fnc_debug;
				_level = (count EE_Scripts_vs_aa - 1);
			};
		};
		case "vehicle":
		{
			if (_level > (count EE_Scripts_vs_respawn_vehicle - 1)) then
			{
				["WARNING", _module, format ["Box level %1 higher than item config level %2", _level, count EE_Scripts_vs_respawn_vehicle], _debug] spawn EE_Scripts_fnc_debug;
				_level = (count EE_Scripts_vs_respawn_vehicle - 1);
			};
		};
		case "artillary":
		{
			if (_level > (count EE_Scripts_vs_respawn_artillary - 1)) then
			{
				["WARNING", _module, format ["Box level %1 higher than item config level %2", _level, count EE_Scripts_vs_respawn_artillary], _debug] spawn EE_Scripts_fnc_debug;
				_level = (count EE_Scripts_vs_respawn_artillary - 1);
			};
		};
		case "plane":
		{
			if (_level > (count EE_Scripts_vs_respawn_plane - 1)) then
			{
				["WARNING", _module, format ["Box level %1 higher than item config level %2", _level, count EE_Scripts_vs_respawn_plane], _debug] spawn EE_Scripts_fnc_debug;
				_level = (count EE_Scripts_vs_respawn_plane - 1);
			};
		};
		case "boat":
		{
			if (_level > (count EE_Scripts_vs_respawn_boat - 1)) then
			{
				["WARNING", _module, format ["Box level %1 higher than item config level %2", _level, count EE_Scripts_vs_respawn_boat], _debug] spawn EE_Scripts_fnc_debug;
				_level = (count EE_Scripts_vs_respawn_boat - 1);
			};
		};
		case "helicopter":
		{
			if (_level > (count EE_Scripts_vs_respawn_helicopter - 1)) then
			{
				["WARNING", _module, format ["Box level %1 higher than item config level %2", _level, count EE_Scripts_vs_respawn_helicopter], _debug] spawn EE_Scripts_fnc_debug;
				_level = (count EE_Scripts_vs_respawn_helicopter - 1);
			};
		};
	};

	_logic setVariable ["Level", _level];
	["DEBUG", _module, format["Box level: %1", _level], _debug] spawn EE_Scripts_fnc_debug;

	_range = _logic getVariable ["Range", 5]; //Range for leveled Eqipment selection
	if ((_level - _range) < 0) then
	{
		["WARNING", _module, format["Box range %1 higher than box level %2", _range, _level], _debug] spawn EE_Scripts_fnc_debug;
	};
	_logic setVariable ["Range", _range];
	["DEBUG", _module, format["Box range: %1",_range], _debug] spawn EE_Scripts_fnc_debug;

	if (_activated) then
	{
		["INFORMATION", _module, "Activated", _debug] spawn EE_Scripts_fnc_debug;
		if ( isNil "EE_Scripts_vs_blacklist_aa") then {
				EE_Scripts_vs_blacklist_aa = [];
			};
		if ( isNil "EE_Scripts_vs_blacklist_vehicle") then {
			EE_Scripts_vs_blacklist_vehicle = [];
		};
		if ( isNil "EE_Scripts_vs_blacklist_artillary") then {
			EE_Scripts_vs_blacklist_artillary = [];
		};
		if ( isNil "EE_Scripts_vs_blacklist_plane") then {
			EE_Scripts_vs_blacklist_plane = [];
		};
		if ( isNil "EE_Scripts_vs_blacklist_boa") then {
			EE_Scripts_vs_blacklist_boat = [];
		};
		if ( isNil "EE_Scripts_vs_blacklist_helicopter") then {
			EE_Scripts_vs_blacklist_helicopter = [];
		};

	 	[_logic] call EE_Scripts_fnc_vs_spawnVehicle;
	};
};
true
