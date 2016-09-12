if (isServer) then {
  params ["_logic", "_Cfg", "_caller"];
  _module = _logic getVariable "Module";
  _debug = _logic getVariable "Debug";

  _box = _logic getVariable "Box";
  _curCount = _box getVariable "CurCount";
  _curUnits = _box getVariable "CurUnits";
  _skill = _logic getVariable "Skill";
  _type = _logic getVariable "Type";

  if (_type == "unit") then {
    _unit = (group _caller) createUnit [configName _Cfg, position _box, [], 0, "FORM"];
  }else{

  };

  if (!isNil{_unit}) then {
    _unit setVariable ["ALIVE_profileIgnore", true];
    _unit setSkill _skill;
    _box setVariable ["CurCount", _curCount - 1, true];
    _box setVariable ["CurUnits", _curUnits + [_unit], true];
    _logic remoteExec ["EE_Scripts_fnc_us_createActions", [0,-2] select isDedicated, true];

    _logic setVariable ["DeleteUnits", false];
    [_logic, _unit] spawn EE_Scripts_fnc_us_watchUnit;
  };
};
true
