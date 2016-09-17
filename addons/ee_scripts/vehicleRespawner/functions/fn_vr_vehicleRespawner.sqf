if (isServer) then {
	// Argument 0 is module logic.
	_logic = param [0,objNull,[objNull]];
	// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
	_units = param [1,[],[[]]];
	// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
	_activated = param [2,true,[true]];

	//Modulename for Messages
	_module = "vehicleRespawner";
	_debug = "WARNING";
	if (!isNil "EE_Scripts_vr_debug") then {
		_debug = EE_Scripts_vr_debug;
	};
	_logic setVariable ["Module", _module];
	_logic setVariable ["Debug", _debug];

	_init = _logic getVariable ["Init", ""];
	_logic setVariable ["Init", _init];

	_name = _logic getVariable ["Name", ""];
	_result = [str _name, configFile >> "CfgVehicles"] call EE_Scripts_fnc_getConfig;

	if (isNil{_result}) then {
		["ERROR", _module, "Vehiclename is unset", _debug] spawn EE_Scripts_fnc_debug;
	}else{
		_logic setVariable ["Name", _result];

		_respawn = _logic getVariable ["Respawn", 0];
		_logic setVariable ["Respawn", _respawn];

		if (_activated) then
		{
			["DEBUG", _module, "Activated", _debug] spawn EE_Scripts_fnc_debug;

			[_logic] spawn EE_Scripts_fnc_spawnVehicle;
		};
	};
};
true
