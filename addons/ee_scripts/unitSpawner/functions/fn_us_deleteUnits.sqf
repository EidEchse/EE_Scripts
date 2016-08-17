params ["_logic"];
_curUnits = _logic getVariable "CurUnits";
_logic setVariable ["DeleteUnits", true, true];
{
    deleteVehicle _x;
} forEach _curUnits;

_count = _logic getVariable "Count";
_box = _logic getVariable "Box";

_box setVariable ["CurCount", _count, true];
_logic setVariable ["CurUnits", [], true];
systemChat format["Number of units now acailable: %1",_count];
[_logic] call EE_Scripts_fnc_us_createActions;
true
