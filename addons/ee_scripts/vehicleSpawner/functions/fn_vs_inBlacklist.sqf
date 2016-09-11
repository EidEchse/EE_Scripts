params ["_logic", "_vehicleName"];

_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_type = _logic getVariable "Type";

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
	["DEBUG", _module,  format["Check: %1", _x], _debug] spawn EE_Scripts_fnc_debug;
  if (_x == _vehicleName) then {
		["DEBUG", _module, format["%1: %2 is in blacklist!", _type, _vehicleName], _debug] spawn EE_Scripts_fnc_debug;
    _return = true;
    breakTo "main";
  };
} forEach _blacklist;

_return
