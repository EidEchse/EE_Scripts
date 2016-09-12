if (hasInterface) then {
  params ["_logic"];
  _box = _logic getVariable "Box";
  _curCount = _box getVariable "CurCount";
  _CfgUnits = _logic getVariable "CfgUnits";
  _count = _logic getVariable "Count";
  _nextRespawn = _box getVariable "NextRespawn";
  _skill = _logic getVariable "Skill";

  removeAllActions _box;
  sleep 0.25;

  _box addAction [format ["NEXT RESPAWN IN: less than %1 Minutes", _nextRespawn], "", nil, 1.43, false, false, "", "[_target] call EE_Scripts_fnc_us_con_nextRespawn", 5];
  _box addAction [format ["AVAILABLE: (%1/%2)", _curCount, _count], "", nil, 1.42, false, false, "", "true", 5];
  _box addAction [format ["SKILL: %1", _skill], "", nil, 1.41, false, false, "", "true", 5];

  _serverFunction = {
    _netId = (netId (_this select 3)) + "EE_Scripts_fnc_us_deleteUnits";
    (_this select 3) remoteExec ["EE_Scripts_fnc_us_deleteUnits", [0, 2] select isDedicated, _netId];
  };
  _box addAction ["!!! DELETE ALL UNITS !!!", _serverFunction, _logic, 1.4, false, false, "", "[_target] call EE_Scripts_fnc_us_con_deleteUnits", 5];

  _counter = 0;
  {
    _displayName = getText (_x >> "displayName");

    _serverFunction = {
      _netId = (netId (_this select 3 select 0)) + className (_this select 3 select 1) + "EE_Scripts_fnc_us_spawnUnit";
      [_this select 3 select 0, _this select 3 select 1, _this select 1] remoteExec ["EE_Scripts_fnc_us_spawnUnit", [0, 2] select isDedicated, _netId];
    };
    _box addAction [format ["Spawn: %1", _displayName], _serverFunction, [_logic, _x], (1.3 + (_counter/100)), false, false, "", "[_target] call EE_Scripts_fnc_us_con_spawnUnit", 5];
    _counter = _counter + 1;
  } forEach _CfgUnits;
};
true
