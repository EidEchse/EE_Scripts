params ["_logic"];
_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_box = _logic getVariable "Box";
_curCount = _box getVariable "CurCount";
_units = _logic getVariable "Units";
_count = _logic getVariable "Count";
_respawn = _logic getVariable "Respawn";
_nextRespawn = _box getVariable "NextRespawn";
_curUnits = _box getVariable "CurUnits";
_skill = _logic getVariable "Skill";

_netId = (netId _logic) + "removeAllActions";
_box remoteExec ["removeAllActions", [0,-2] select isDedicated, _netId];
sleep 0.5;

_addActionParams = [format ["NEXT RESPAWN IN: less than %1 Minutes", _nextRespawn], "", _logic, 1.43, false, false, "", "[_target] call EE_Scripts_fnc_us_con_nextRespawn", 5];
_netId = (netId _logic) + "addAction" + "NEXT RESPAWN IN";
[_box, _addActionParams] remoteExec ["addAction", [0,-2] select isDedicated, _netId];

_addActionParams = [format ["AVAILABLE: (%1/%2)", _curCount, _count], "", nil, 1.42, false, false, "", "true", 5];
_netId = (netId _logic) + "addAction" + "AVAILABLE";
[_box, _addActionParams] remoteExec ["addAction", [0,-2] select isDedicated, _netId];

_addActionParams = [format ["SKILL: %1", _skill], "", nil, 1.41, false, false, "", "true", 5];
_netId = (netId _logic) + "addAction" + "SKILL";
[_box, _addActionParams] remoteExec ["addAction", [0,-2] select isDedicated, _netId];

_serverFunction = {
  _netId = (netId (_this select 3)) + "EE_Scripts_fnc_sa_loadEquipment";
  (_this select 3) remoteExec ["EE_Scripts_fnc_us_deleteUnits", [0, 2] select isDedicated, _netId];
};
_addActionParams = ["!!! DELETE ALL UNITS !!!", _serverFunction, _logic, 1.4, false, false, "", "[_target] call EE_Scripts_fnc_us_con_deleteUnits", 5];
_netId = (netId _logic) + "addAction" + "!!! DELETE ALL UNITS !!!";
[_box, _addActionParams] remoteExec ["addAction", [0,-2] select isDedicated, _netId];

_units = _units splitString " ,;";
["DEBUG", _module, format["Units that can be spawned: %1", _units], _debug] spawn EE_Scripts_fnc_debug;
_counter = 0;
{
  _displayName = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
  ["DEBUG", _module, format["Add Action: %1", _displayName], _debug] spawn EE_Scripts_fnc_debug;

  _serverFunction = {
    _netId = (netId (_this select 3 select 0)) + (_this select 3 select 1) + "EE_Scripts_fnc_us_spawnUnit";
    [_this select 3 select 0, _this select 3 select 1, _this select 1] remoteExec ["EE_Scripts_fnc_us_spawnUnit", [0, 2] select isDedicated, _netId];
  };
  _addActionParams = [format ["Spawn: %1", _displayName], _serverFunction, [_logic, _x], (1.3 + (_counter/100)), false, false, "", "[_target] call EE_Scripts_fnc_us_con_spawnUnit", 5];
  _netId = (netId _logic) + "addAction" + "Spawn" + (str _counter);
  [_box, _addActionParams] remoteExec ["addAction", [0,-2] select isDedicated, _netId];
  sleep 0.1;
  _counter = _counter + 1;
} forEach _units;
true
