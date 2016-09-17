params ["_entryName", "_config"];
private "_return";
if (toLower(_entryName) == toLower(str (configName _config))) then {
  _return = _config;
}else{
  _configs = "true" configClasses _config;
  scopeName "main";
  {
    _result = [_entryName, _x] call EE_Scripts_fnc_getConfig;
    if (!isNil "_result") then {
      _return = _result;
      breakTo "main";
    };
  } forEach _configs;
};
if (!isNil "_return") exitWith {_return};
