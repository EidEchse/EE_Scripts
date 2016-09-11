if (isServer) then {
	// Argument 0 is module logic.
	_logic = param [0,objNull,[objNull]];
	// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
	_units = param [1,[],[[]]];
	// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
	_activated = param [2,true,[true]];

	//Modulename for Messages
	_module = "umitSpawner";
	_debug = "WARNING";
	if (!isNil "EE_Scripts_us_debug") then {
		_debug = EE_Scripts_us_debug;
	};
	_logic setVariable ["Module", _module];
	_logic setVariable ["Debug", _debug];

	_units = _logic getVariable ["Units",""];
	if ( _units == "") then
	{
		["WARNING", _module, "No units configured", _debug] spawn EE_Scripts_fnc_debug;
	}else{
		["DEBUG", _module, format["Units to spawn: %1", _units], _debug] spawn EE_Scripts_fnc_debug;
	};
	_logic setVariable ["Units", _units];
	_count = _logic getVariable ["Count", 1];
	["DEBUG", _module, format["Number of units: %1", _count], _debug] spawn EE_Scripts_fnc_debug;
	_logic setVariable ["Count", _count];
	_respawn = _logic getVariable ["Respawn", 0];
	["DEBUG", _module, format["Time to respawn: %1", _respawn], _debug] spawn EE_Scripts_fnc_debug;
	_logic setVariable ["Respawn", _respawn];
	_skill = _logic getVariable ["Skill", 0.5];
	if (_skill < 0) then
	{
		[3, _module, "Skill must be between 0 and 1"] spawn EE_Scripts_fnc_debug;
		_skill = 0;
	}else{
		if (_skill > 1) then
		{
			[3, _module, "Skill must be between 0 and 1"] spawn EE_Scripts_fnc_debug;
			_skill = 1;
		};
	};
	_logic setVariable ["Skill", _skill];

	if (_activated) then
	{
		["INFORMATION", _module, "Activated", _debug] spawn EE_Scripts_fnc_debug;

		_logic setVariable ["BoxClassDefault", "CargoNet_01_box_F"];
		_box = [_logic] call EE_SCripts_fnc_spawnBox;
		_box setVariable ["CurCount", _count, true];
		_box setVariable ["CurUnits", [], true];
		_nextRespawn = _box getVariable ["NextRespawn", 0];
		_box setVariable ["NextRespawn", _nextRespawn, true];
	  [_logic] call EE_Scripts_fnc_us_createActions;
	};
};
true
