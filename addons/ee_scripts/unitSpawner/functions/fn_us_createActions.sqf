params ["_logic"];
_units = _logic getVariable "Units";
_count = _logic getVariable "Count";
_respawn = _logic getVariable "Respawn";
_box = _logic getVariable "Box";

_curCount = _box getVariable "CurCount";
if (isNil{_curCount}) then {
  _curCount = _count;
  _box setVariable ["CurCount", _curCount, true];
};

_nextRespawn = _logic getVariable ["NextRespawn",0];
if (_nextRespawn == 0) then {
  _nextRespawn = "-";
};
removeAllActions _box;
/*_box addAction [format ["AVAILABLE: (%1/%2)",_curCount,_count], "",[],1.6,false,false];*/
[_box, [format ["AVAILABLE: (%1/%2)",_curCount,_count], "",[],1.6,false,false]] remoteExec ["addAction", -2, _box];
/*_box addAction [format ["NEXT RESPAWN: %1",_nextRespawn], "",[],1.5,false,false];*/
[_box, [format ["NEXT RESPAWN: %1",_nextRespawn], "",[],1.5,false,false]] remoteExec ["addAction", -2, _box];
/*_box addAction [format ["!!! DELETE ALL UNITS !!!"], "[_this select 3] call EE_Scripts_fnc_us_deleteUnits",_logic,1.7,false,false];*/
[_box, [format ["!!! DELETE ALL UNITS !!!"], {[_this select 3] call EE_Scripts_fnc_us_deleteUnits},_logic,1.7,false,false]] remoteExec ["addAction", -2, _box];
_units = _units splitString ",;";
if (EE_Scripts_us_debug) then {systemChat format["Units that can be spawned: %1", _units]};
{
    _displayName = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
    if (EE_Scripts_us_debug) then {systemChat format["Add Action: %1", _displayName]};
    /*_box addAction [format ["Spawn: %1", _displayName], "[_this select 3 select 0, _this select 3 select 1, _this select 1] call EE_Scripts_fnc_us_spawnUnit",[_logic, _x],1.4,false,false,"","[_target] call EE_Scripts_fnc_us_respawnsLeft"];*/
    [_box, [format ["Spawn: %1", _displayName], {[_this select 3 select 0, _this select 3 select 1, _this select 1] call EE_Scripts_fnc_us_spawnUnit},[_logic, _x],1.4,false,false,"","[_target] call EE_Scripts_fnc_us_respawnsLeft"]] remoteExec ["addAction", -2, _box];
} forEach _units;
