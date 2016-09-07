params ["_logic","_vehicle"];

_locked = locked _vehicle;
_action = parseNumber (_logic getVariable "LockAction");
systemChat format ["Action %1", _action];
if (!isNil{_action}) then {
  _vehicle removeAction _action;
};

if (_locked >= 2) then {
  /*_action = _vehicle addAction ["Lock vehicle", "[_this select 3 select 0, _this select 3 select 1] call EE_Scripts_fnc_vs_toggleLock", [_logic, _vehicle],1.5,false];*/
  _action = [_vehicle, ["Lock vehicle", {[_this select 3 select 0, _this select 3 select 1] call EE_Scripts_fnc_vs_toggleLock}, [_logic, _vehicle],1.5,false]] remoteExec ["addAction", [0,-2] select isDedicated, _vehicle];
  _vehicle lock 0;
}else{
  /*_action = _vehicle addAction ["Unlock vehicle", "[_this select 3 select 0, _this select 3 select 1] call EE_Scripts_fnc_vs_toggleLock", [_logic, _vehicle],1.5,false,false];*/
  _action = [_vehicle, ["Unlock vehicle", {[_this select 3 select 0, _this select 3 select 1] call EE_Scripts_fnc_vs_toggleLock}, [_logic, _vehicle],1.5,false,false]] remoteExec ["addAction", [0,-2] select isDedicated, _vehicle];
  _vehicle lock 2;
};
_logic setVariable ["LockAction", _action, true];
true
