params ["_logic","_vehicle"];

_locked = locked _vehicle;
_action = _logic getVariable "LockAction";
if (!isNil{_action}) then {
  _vehicle removeAction _action;
};

if (_locked >= 2) then {
  _action = _vehicle addAction ["Lock vehicle", "[_this select 3 select 0, _this select 3 select 1] call EE_Scripts_fnc_vs_toggleLock", [_logic, _vehicle],1.5,false];
  _vehicle lock 0;
}else{
  _action = _vehicle addAction ["Unlock vehicle", "[_this select 3 select 0, _this select 3 select 1] call EE_Scripts_fnc_vs_toggleLock", [_logic, _vehicle],1.5,false,false];
  _vehicle lock 2;
};
_logic setVariable ["LockAction", _action, true];
true
