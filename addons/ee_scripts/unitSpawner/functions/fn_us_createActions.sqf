params ["_logic"];

_box = _logic getVariable "Box";
_curCount = _box getVariable "CurCount";
_units = _logic getVariable "Units";
_count = _logic getVariable "Count";
_respawn = _logic getVariable "Respawn";
_curUnits = _logic getVariable "CurUnits";

removeAllActions _box;

_nextRespawn = _logic getVariable "NextRespawn";
if (_nextRespawn == 0) then
{
  if ((count _curUnits) > 0) then
  {
    [_box, [format ["!!! DELETE ALL UNITS !!!"], {[_this select 3] call EE_Scripts_fnc_us_deleteUnits}, _logic, 1.7, false, false]] remoteExec ["addAction", 0, _box];
  };
}else{
  [_box, [format ["NEXT RESPAWN IN: %1 Minutes", _nextRespawn], "", [], 1.5, false, false]] remoteExec ["addAction", 0, _box];
};

[_box, [format ["AVAILABLE: (%1/%2)", _curCount, _count], "", [], 1.6, false, false]] remoteExec ["addAction", 0, _box];

_units = _units splitString " ,;";
[0, "unitSpawner", format["Units that can be spawned: %1", _units], EE_Scripts_us_debug] spawn EE_Scripts_fnc_debug;
{
  _displayName = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
  [0, "unitSpawner", format["Add Action: %1", _displayName], EE_Scripts_us_debug] spawn EE_Scripts_fnc_debug;
  [_box, [format ["Spawn: %1", _displayName], {[_this select 3 select 0, _this select 3 select 1, _this select 1] call EE_Scripts_fnc_us_spawnUnit},[_logic, _x],1.4,false,false,"","[_target] call EE_Scripts_fnc_us_respawnsLeft"]] remoteExec ["addAction", 0, _box];
} forEach _units;
