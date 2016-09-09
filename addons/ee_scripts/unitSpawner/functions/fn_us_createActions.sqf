params ["_logic","_gou"];
_box = _logic getVariable "Box";
_curCount = _box getVariable "CurCount";
_units = _logic getVariable "Units";
_count = _logic getVariable "Count";
_respawn = _logic getVariable "Respawn";
_curUnits = _logic getVariable "CurUnits";
_skill = _logic getVariable "Skill";

private ["_debug", "_module"];
if (_gou isEqualTo "unit") then {
  _debug = EE_Scripts_us_debug;
  _module = "unitSpawner";
}else{
  _debug = EE_Scripts_gs_debug;
  _module = "groupSpawner";
};

_box remoteExec ["removeAllActions", [0,-2] select isDedicated];
sleep 1;

_nextRespawn = _logic getVariable "NextRespawn";
if (_nextRespawn == 0) then
{
  if ((count _curUnits) > 0) then
  {
    [_box, [format ["!!! DELETE ALL UNITS !!!"], {[_this select 3 select 0, _this select 3 select 1] call EE_Scripts_fnc_us_deleteUnits}, [_logic, _gou], 1.7, false, false]] remoteExec ["addAction", [0,-2] select isDedicated, _box];
    sleep 0.2;
  };
}else{
  [_box, [format ["NEXT RESPAWN IN: %1 Minutes", _nextRespawn], "", [], 1.5, false, false]] remoteExec ["addAction", [0,-2] select isDedicated, _box];
  sleep 0.2;
};

if (_gou isEqualTo "unit") then {
  [_box, [format ["AVAILABLE: (%1/%2)", _curCount, _count], "", [], 1.6, false, false]] remoteExec ["addAction", [0,-2] select isDedicated, _box];
  sleep 0.2;
};
[_box, [format ["SKILL: %1", _skill], "", [], 1.6, false, false]] remoteExec ["addAction", [0,-2] select isDedicated, _box];
sleep 0.2;

_units = _units splitString " ,;";
["DEBUG", _module, format["Units that can be spawned: %1", _units], _debug] spawn EE_Scripts_fnc_debug;
{
  _displayName = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
  ["DEBUG", _module, format["Add Action: %1", _displayName], _debug] spawn EE_Scripts_fnc_debug;
  [_box, [format ["Spawn: %1", _displayName], {[_this select 3 select 0, _this select 3 select 1, _this select 1, _this select 3 select 2] spawn EE_Scripts_fnc_us_spawnUnit},[_logic, _x, _gou],1.4,false,false,"","[_target] call EE_Scripts_fnc_us_respawnsLeft"]] remoteExec ["addAction", [0,-2] select isDedicated, _box];
  sleep 0.2;
} forEach _units;
true
