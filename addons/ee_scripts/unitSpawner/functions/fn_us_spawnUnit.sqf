if (isServer) then {
  params ["_logic", "_unitName", "_caller"];
  _module = _logic getVariable "Module";
  _debug = _logic getVariable "Debug";

  _box = _logic getVariable "Box";
  _curCount = _box getVariable "CurCount";
  _curUnits = _box getVariable "CurUnits";
  _skill = _logic getVariable "Skill";

  /*_unitName createUnit [ position _box, group _caller, "EE_Scripts_newUnit = this;"];*/
  _unit = (group _caller) createUnit [_unitName, position _box, [], 0, "FORM"];
  /*_wait = true;
  _timer = 0;
  private "_unit";
  while {_wait} do {
    sleep 0.1;
    if (!isNil "EE_Scripts_newUnit") then {
      _unit = EE_Scripts_newUnit;
      EE_Scripts_newUnit = nil;
      _wait = false;
    }else{
      if (_timer >= 50) then {
        _wait = false;
        ["ERROR", _module, "NO RESPONSE FROM SPAWN COMMAND. NO UNIT SPAWNED!", _debug] spawn EE_Scripts_fnc_debug;
      };
      _timer = _timer + 1;
    };
  };*/
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
