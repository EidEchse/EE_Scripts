params ["_vehicleName", "_type"];

private "_blacklist";
switch _type do {
	case "aa": {
		_blacklist = EE_Scripts_vs_blacklist_aa;
	};
	case "vehicle": {
		_blacklist = EE_Scripts_vs_blacklist_vehicle;
	};
	case "artillary": {
		_blacklist = EE_Scripts_vs_blacklist_artillary;
	};
	case "plane": {
		_blacklist = EE_Scripts_vs_blacklist_plane;
	};
	case "boat": {
		_blacklist = EE_Scripts_vs_blacklist_boat;
	};
	case "helicopter": {
		_blacklist = EE_Scripts_vs_blacklist_helicopter;
	};
};

private _return = false;
scopeName "main";
{
  if (EE_Scripts_vs_debug) then {systemChat format["Check: %1", _x]};
  if (_x == _vehicleName) then {
    if (EE_Scripts_vs_debug) then {systemChat format["%1: %2 is in blacklist!", _type, _vehicleName]};
    _return = true;
    breakTo "main";
  };
} forEach _blacklist;

_return
