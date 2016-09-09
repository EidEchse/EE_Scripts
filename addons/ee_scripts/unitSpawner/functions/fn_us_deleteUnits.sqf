params ["_logic", "_gou"];
_curUnits = _logic getVariable "CurUnits";
_count = _logic getVariable "Count";
_box = _logic getVariable "Box";

_logic setVariable ["DeleteUnits", true, true];
{
    deleteVehicle _x;
} forEach _curUnits;

_logic setVariable ["CurUnits", [], true];
_logic setVariable ["NextRespawn", 0, true];
(format["%1 new spawns now availabe", _count]) remoteExec ["hint", [0,-2] select isDedicated];
[_logic, _gou] call EE_Scripts_fnc_us_createActions;
true
