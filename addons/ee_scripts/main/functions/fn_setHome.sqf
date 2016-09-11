if (isServer) then {
  params ["_logic"];
  _vehicle = _logic getVariable "Vehicle";
  _vehicleName = _logic getVariable "Name";

  if (!isNil "_vehicle") then {
    _logic setVariable ["Home", (position _vehicle)];
    _logic setVariable ["HomeDir", (getDir _vehicle)];

    _cfg = (configfile >> "cfgVehicles" >> _vehicleName);
    _displayName = getText (_cfg >> "displayName");
    _image = getText (_cfg >> "picture");
    _location = nearestLocation [position _vehicle, ""];

    _title = "<t color='#ffffff' size='1.2' align='center'>" + _displayName + "</t><br />";
    _picture = "<img size='4' image='" + _image + "' align='center'/><br />";
    _positionText = "<t color='#ffffff' size='1.0' align='center'>new spawn positon:</t><br />";
    _position = "<t color='#ffffff' size='1.0' align='center'>" + (className _location) + "</t>";

    _text = _title + _picture + _positionText + _position;
    (parseText _text) remoteExec ["hint", [0,-2] select isDedicated];
  };
};
true
