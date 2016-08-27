// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

if (_activated) then
{
	[1, "unitSpawner", "init"] call EE_Scripts_fnc_debug;

	_units = _logic getVariable ["Units",""];
	if ( _units == "") then
	{
		[4, "unitSpawner", "No units configured"] call EE_Scripts_fnc_debug;
	}else{
		[1, "unitSpawner", format["Units to spawn: %1", _units]] call EE_Scripts_fnc_debug;
	};
	_logic setVariable ["Units", _units, true];
	_count = _logic getVariable ["Count", 1];
	[1, "unitSpawner", format["Number of units: %1", _count]] call EE_Scripts_fnc_debug;
	_logic setVariable ["Count", _count, true];
	_respawn = _logic getVariable ["Respawn", 0];
	[1, "unitSpawner", format["Time to respawn: %1", _respawn]] call EE_Scripts_fnc_debug;
	_logic setVariable ["Respawn", _respawn, true];

	_box = ["unitSpawner", _logic, "CargoNet_01_box_F"] call EE_SCripts_fnc_spawnBox;

  [_logic, _units, _count, _respawn, _box] call EE_Scripts_fnc_us_createActions;
};

true
