// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

_units = _logic getVariable ["Units",""];
if ( _units == "") then
{
	[3, "unitSpawner", "No units configured"] call EE_Scripts_fnc_debug;
}else{
	[0, "unitSpawner", format["Units to spawn: %1", _units]] call EE_Scripts_fnc_debug;
};
_logic setVariable ["Units", _units, true];
_count = _logic getVariable ["Count", 1];
[0, "unitSpawner", format["Number of units: %1", _count]] call EE_Scripts_fnc_debug;
_logic setVariable ["Count", _count, true];
_respawn = _logic getVariable ["Respawn", 0];
[0, "unitSpawner", format["Time to respawn: %1", _respawn]] call EE_Scripts_fnc_debug;
_logic setVariable ["Respawn", _respawn, true];
_skill = _logic getVariable ["Skill", 0.5];
if (_skill < 0) then
{
	[3, "unitSpawner", "Skill must be between 0 and 1"] call EE_Scripts_fnc_debug;
	_skill = 0;
}else{
	if (_skill > 1) then
	{
		[3, "unitSpawner", "Skill must be between 0 and 1"] call EE_Scripts_fnc_debug;
		_skill = 1;
	};
};
_logic setVariable ["Skill", _skill, true];


_nextRespawn = _logic getVariable ["NextRespawn", 0];
_logic setVariable ["NextRespawn", _nextRespawn, true];

if (_activated) then
{
	[1, "unitSpawner", "Activated"] call EE_Scripts_fnc_debug;

	_box = ["unitSpawner", _logic, "CargoNet_01_box_F"] call EE_SCripts_fnc_spawnBox;
	_box setVariable ["CurCount", _count, true];
	_logic setVariable ["CurUnits", [], true];

  [_logic] call EE_Scripts_fnc_us_createActions;
};

true
