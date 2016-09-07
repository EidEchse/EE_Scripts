params ["_vehicleName", "_type"];

private "_blacklist";
switch _type do
{
	case "aa": {
		_blacklist = EE_Scripts_vs_blacklist_aa;
	};
	case "vehicle":
	{
		_blacklist = EE_Scripts_vs_blacklist_vehicle;
	};
	case "artillary":
	{
		_blacklist = EE_Scripts_vs_blacklist_artillary;
	};
	case "plane":
	{
		_blacklist = EE_Scripts_vs_blacklist_plane;
	};
	case "boat":
	{
		_blacklist = EE_Scripts_vs_blacklist_boat;
	};
	case "helicopter":
	{
		_blacklist = EE_Scripts_vs_blacklist_helicopter;
	};
};

private _return = false;
scopeName "main";
{
	["DEBUG", "vehicleSpawner",  format["Check: %1", _x], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
  if (_x == _vehicleName) then {
		["DEBUG", "vehicleSpawner", format["%1: %2 is in blacklist!", _type, _vehicleName], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
    _return = true;
    breakTo "main";
  };
} forEach _blacklist;

_return
