params ["_level","_module","_message","_debugLevel"];

if (isNil {_debugLevel}) then
{
  _debugLevel = getNumber ( configfile >> "EE_Scripts" >> _module >> "debug");
};

if (_debugLevel <= _level) then
{
  switch (_level) do
  {
      case (0):
      {
          systemChat format ["%1 | %2 | %3", "DEBUG", _module, _message];
      };
      case (1):
      {
          systemChat format ["%1 | %2 | %3", "INFORMATION", _module, _message];
      };
      case (2):
      {
          systemChat format ["%1 | %2 | %3", "WARNING", _module, _message];
      };
      case (3):
      {
          systemChat format ["%1 | %2 | %3", "ERROR", _module, _message];
      };
      default
      {
          systemChat format ["%1 | %2 | %3", "NOT CLASSIFIED", _module, _message];
      };
  };
};
