params ["_entryName", "_config"];
private "_return";
if (toLower(_entryName) == toLower(str (configName _config))) then {
  _return = _config;
}else{
  _configs = "true" configClasses _config;
  scopeName "main";
  {
    if (toLower(_entryName) == toLower(str (configName _x))) then {
      _return = _x;
      breakTo "main";
    };
  } forEach _configs;

  if (isNil "_return") then {
    scopeName "sub";
    {
      _result = [_entryName, _x] call EE_Scripts_fnc_getConfig;
      if (!isNil "_result") then {
        _return = _result;
        breakTo "sub";
      };
    } forEach _configs;
  };
};
if (!isNil "_return") exitWith {_return};
