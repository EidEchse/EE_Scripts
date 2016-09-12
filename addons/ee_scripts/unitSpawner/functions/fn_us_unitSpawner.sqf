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
	_logic setVariable ["Count", _count, true];
	_respawn = _logic getVariable ["Respawn", 0];
	["DEBUG", _module, format["Time to respawn: %1", _respawn], _debug] spawn EE_Scripts_fnc_debug;
	_logic setVariable ["Respawn", _respawn];
	_skill = _logic getVariable ["Skill", 0.5], true;
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
		_type = _logic getVariable "Type";
		_CfgUnits = [];
		_CfgGroups = [];
		_NameUnits = _units splitString " ,;";
		{
			_unitName = _x;
			if (_type == "unit") then {
				_cond = format["(configName _x == %1)", str _unitName];
				_result = _cond	configClasses (configFile >> "CfgVehicles");
				_count = count _result;
				switch (_count) do {
				    case (0): {
				      ["WARNING", _module, format["No unit config found for class name %1", _unitName], _debug] spawn EE_Scripts_fnc_debug;
				    };
						case (1): {
						  ["DEBUG", _module, format["CfgClass found for classname %1", _unitName], _debug] spawn EE_Scripts_fnc_debug;
							_CfgUnits pushBack (_result select 0);
						};
						default {
						  ["WARNING", _module, format["More than one unit config found for class name %1", _unitName], _debug] spawn EE_Scripts_fnc_debug;
						};
				};
			}else{
				scopeName "group";
				_found = false;
				private ["_cfgGroupSide", "_CfgGroupFaction", "_CfgGroupType", "_CfgGroup"];
				_CfgGroupSides = "true" configClasses (configFile >> "CfgVehicles");
				{
				  _cfgGroupSide = _x;
					_CfgGroupFactions = "true" configClasses _cfgGroupSide;
					{
					  _CfgGroupFaction = _x;
						_CfgGroupTypes = "true" configClasses _CfgGroupFaction;
						{
						  _CfgGroupType = _x;
							_CfgGroups = "true" configClasses _CfgGroupFaction;
							{
							  _CfgGroup = _x;
								if (configName _CfgGroup == _unitName) then {
									_found = true;
									breakTo "group";
								};
							} forEach _CfgGroups;
						} forEach _CfgGroupTypes;
					} forEach _CfgGroupFactions;
				} forEach _CfgGroupSides;
				if (_found) then {
					_CfgGroups pushBack [_cfgGroupSide, _CfgGroupFaction, _CfgGroupType, _CfgGroup];
				}else{
					["WARNING", _module, format["No group config found for class name %1", _unitName], _debug] spawn EE_Scripts_fnc_debug;
				};
			};
		} forEach _NameUnits;
		_logic setVariable ["BoxClassDefault", "CargoNet_01_box_F"];
		_box = [_logic] call EE_SCripts_fnc_spawnBox;
		_logic setVariable ["CfgUnits", _CfgUnits, true];
		_logic setVariable ["CfgGroups", _CfgGroups, true];
		_logic setVariable ["Box", _box, true];
		_box setVariable ["CurCount", _count, true];
		_box setVariable ["CurUnits", [], true];
		_nextRespawn = _box getVariable ["NextRespawn", 0];
		_box setVariable ["NextRespawn", _nextRespawn, true];
	  _logic remoteExec ["EE_Scripts_fnc_us_createActions", [0,-2] select isDedicated, true];
	};
};
true
