params ["_level","_module","_message","_debugLevel"];

if (isNil {_debugLevel}) then { _debugLevel = "WARNING"};

_debug = [_level, _debugLevel];
for [{_i = 0}, {_i <= 1}, {_i=_i+1}] do
{
  switch (_debug select _i) do
  {
      case ("DEBUG"):
      {
          _debug set [_i, 4];
      };
      case ("INFORMATION"):
      {
          _debug set [_i, 3];
      };
      case ("WARNING"):
      {
          _debug set [_i, 2];
      };
      case ("ERROR"):
      {
          _debug set [_i, 1];
      };
      default
      {
          _debug set [_i, 0];
      };
  };
};

if (_debug select 0 <= _debug select 1) then
{
  if (_level isEqualTo "ERROR") then {
    (format ["%1 | %2 | %3", _level, _module, _message]) remoteExec ["hintC", [0,-2] select isDedicated];
  }else{
    (format ["%1 | %2 | %3", _level, _module, _message]) remoteExec ["systemChat", [0,-2] select isDedicated];
  };
};
