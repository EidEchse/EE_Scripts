if (isServer) then {
  params ["_logic"];
  _count = _logic getVariable "Count";
  _box = _logic getVariable "Box";
  _units = _logic getVariable "Units";
  _skill = _logic getVariable "Skill";
  _curUnits = _box getVariable "CurUnits";

  _logic setVariable ["DeleteUnits", true];
  {
      deleteVehicle _x;
  } forEach _curUnits;

  _box setVariable ["CurUnits", [], true];
  _box setVariable ["NextRespawn", 0, true];
  _box setVariable ["CurCount", _count, true];
  _title = "<t color='#ffffff' size='1.2' shadowColor='#CCCCCC' align='center'>BOX INFORMATION</t><br />";
  _curCount = "<t color='#ffffff' size='1.0' shadowColor='#CCCCCC' align='left'>Available: " + (str _count) + "</t><br />";
  _skillText = "<t color='#ffffff' size='1.0' shadowColor='#CCCCCC' align='left'>Skill: " + (str _skill) + "</t><br />";
  _unitsText = "<t color='#ffffff' size='1.0' shadowColor='#CCCCCC' align='center'>Units:</t><br />";
  _text = _title + _curCount + _skillText + _unitsText;
  _units = _units splitString " ,;";
  {
    _text = _text + "<t color='#ffffff' size='1.0' shadowColor='#CCCCCC' align='center'>" + getText (configfile >> "CfgVehicles" >> _x >> "displayName") + "</t><br />";
  } forEach _units;
  (parseText _text) remoteExec ["hint", [0,-2] select isDedicated];

  [_logic] call EE_Scripts_fnc_us_createActions;
};
true
