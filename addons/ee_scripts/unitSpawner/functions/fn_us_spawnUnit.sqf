if (isServer) then {
  params ["_logic", "_cfg", "_caller"];
  _module = _logic getVariable "Module";
  _debug = _logic getVariable "Debug";

  _box = _logic getVariable "Box";
  _curCount = _box getVariable "CurCount";
  _curUnits = _box getVariable "CurUnits";
  _skill = _logic getVariable "Skill";
  _type = _logic getVariable "Type";

  private "_units";
  if (_type == "group") then {
    private "_group";
    _side = getNumber (_cfg >> "side");
    switch (_side) do {
      case 0: {
        _group = createGroup east;
        systemChat format["Side: %1", str east];
      };
      case 1: {
        _group = createGroup west;
        systemChat format["Side: %1", str west];
      };
      case 2: {
        _group = createGroup resistance;
        systemChat format["Side: %1", str resistance];
      };
    };
    systemChat format["side: %1", _side];
    if (!isNil "_group") then {
      systemChat "Group created";
      _cfgUnits = "true" configClasses _cfg;
      {
        _unitCfg = [str getText (_x >> "vehicle"), configFile >> "CfgGroups"] call EE_Scripts_fnc_getConfig;
        systemChat format["vehicle : %1", getText (_x >> "vehicle")];
        _unit = _group createUnit [_unitCfg, (position _box) + getArray (_x >> "position"), [], 0, "FORM"];
        _units pushBack _unit;
      } forEach _cfgUnits;
      (leader _caller) hcSetGroup [_group];
    };
  }else{
    _group = group _caller;
    _unit = _group createUnit [configName _cfg, position _box, [], 0, "FORM"];
    _units pushBack _unit;
  };



  {
    _x setVariable ["ALIVE_profileIgnore", true];
    _x setSkill _skill;
  } forEach _units;

  _logic setVariable ["DeleteUnits", false];
  _box setVariable ["CurCount", _curCount - 1, true];
  _box setVariable ["CurUnits", _curUnits + [_units], true];
  _logic remoteExec ["EE_Scripts_fnc_us_createActions", [0,-2] select isDedicated, true];
  /*[_logic, _units] spawn EE_Scripts_fnc_us_watchUnit;*/
};
true
