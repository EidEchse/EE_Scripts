if (isServer) then {
  params ["_logic"];
  _count = _logic getVariable "Count";
  _box = _logic getVariable "Box";
  _units = _logic getVariable "Units";
  _skill = _logic getVariable "Skill";
  _curUnits = _box getVariable "CurUnits";
  _cfgs = _logic getVariable "Cfgs";
  _type = _logic getVariable "Type";

  _logic setVariable ["DeleteUnits", true];
  {
    _unitArray = _x;
    {
      deleteVehicle _x;
    } forEach _unitArray;
  } forEach _curUnits;

  _box setVariable ["CurUnits", [], true];
  _box setVariable ["NextRespawn", 0, true];
  _box setVariable ["CurCount", _count, true];
  _title = "<t color='#ffffff' size='1.2' align='center'>BOX INFORMATION</t><br />";
  _curCount = "<t color='#ffffff' size='1.0' align='left'>Available: " + (str _count) + "/" + (str _count) + "</t><br />";
  _skillText = "<t color='#ffffff' size='1.0' align='left'>Skill: " + (str _skill) + "</t><br />";
  _location = nearestLocation [position _box, ""];
  _locationText = "<t color='#ffffff' size='1.0' align='left'>Location: " + (className _location) + "</t><br />";

  _unitsTitel = "<t color='#ffffff' size='1.0' align='center'>Units:</t><br />";
  _unitText = "";
  {
    private "_displayName";
    if (_type == "group") then {
      _displayName = getText (_x >> "name");
    }else{
      _displayName = getText (_x >> "displayName");
    };
    _unitText = _unitText + "<t color='#ffffff' size='1.0' align='center'>" + _displayName + "</t><br />";
  } forEach _cfgs;
  _text = _title + _curCount + _skillText + _locationText + _unitsTitel + _unitText;
  (parseText _text) remoteExec ["hint", [0,-2] select isDedicated];

  _logic remoteExec ["EE_Scripts_fnc_us_createActions", [0,-2] select isDedicated, true];
};
true
