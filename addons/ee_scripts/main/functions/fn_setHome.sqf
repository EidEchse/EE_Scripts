if (isServer) then {
  params ["_logic"];
  _vehicle = _logic getVariable "Vehicle";
  if (!isNil "_vehicle") then {
    _logic setVariable ["Home", (position _vehicle)];
    _logic setVariable ["HomeDir", (getDir _vehicle)];
  };
};
true
