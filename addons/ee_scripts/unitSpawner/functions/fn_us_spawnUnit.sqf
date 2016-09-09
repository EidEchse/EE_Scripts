params ["_logic", "_unitName", "_caller", "_gou"];
_box = _logic getVariable "Box";
_curCount = _box getVariable "CurCount";
_curUnits = _logic getVariable ["CurUnits",[]];
_skill = _logic getVariable "Skill";

private ["_debug", "_module"];
if (_gou isEqualTo "unit") then {
  _debug = EE_Scripts_us_debug;
  _module = "unitSpawner";
}else{
  _debug = EE_Scripts_gs_debug;
  _module = "groupSpawner";
};

_unitName createUnit [ position _box, group _caller, 'EE_Scripts_newUnit = this; publicVariable "EE_Scripts_newUnit";'];
_wait =true;
_timer = 0;
private "_unit";
while {_wait} do {
  sleep 0.1;
  if (!isNil{EE_Scripts_newUnit}) then {
    _unit = EE_Scripts_newUnit;
    EE_Scripts_newUnit = nil;
    publicVariable "EE_Scripts_newUnit";
    _wait = false;
  }else{
    if (_timer >= 50) then {
      _wait = false;
      ["ERROR", _module, "NO RESPONSE FROM SERVER. NO UNIT SPAWNED!", _debug] spawn EE_Scripts_fnc_debug;
    };
    _timer = _timer + 1;
  };
};
if (!isNil{_unit}) then {
  _unit setVariable ["ALIVE_profileIgnore", true];
  _unit setskill _skill;
  _box setVariable ["CurCount", _curCount - 1, true];
  _logic setVariable ["CurUnits", _curUnits + [_unit], true];

  _logic setVariable ["DeleteUnits", false, true];
  [_logic, _gou] call EE_Scripts_fnc_us_createActions;
  [_logic, _unit, _gou] call EE_Scripts_fnc_us_watchUnit;
};
true
