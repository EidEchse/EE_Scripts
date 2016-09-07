params ["_logic", "_unitName", "_caller"];
_box = _logic getVariable "Box";
_curCount = _box getVariable "CurCount";
_curUnits = _logic getVariable ["CurUnits",[]];
_skill = _logic getVariable "Skill";

_unitName createUnit [ position _box, group _caller, "EE_Scripts_newUnit = this"];
_unit = EE_Scripts_newUnit;
_unit setVariable ["ALIVE_profileIgnore", true];
_unit setskill _skill;
_box setVariable ["CurCount", _curCount - 1, true];
_logic setVariable ["CurUnits", _curUnits + [_unit], true];

_logic setVariable ["DeleteUnits", false, true];
[_logic] spawn EE_Scripts_fnc_us_createActions;
[_logic, _unit] spawn EE_Scripts_fnc_us_watchUnit;
true
