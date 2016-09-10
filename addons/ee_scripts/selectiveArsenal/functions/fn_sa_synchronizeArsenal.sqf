params ["_arsenal"];
_backpacks = _arsenal call BIS_fnc_getVirtualBackpackCargo;
_items = _arsenal call BIS_fnc_getVirtualItemCargo;
_magazines = _arsenal call BIS_fnc_getVirtualMagazineCargo;
_weapons = _arsenal call BIS_fnc_getVirtualWeaponCargo;
if (isNil "EE_Scripts_sa_debug") then {	EE_Scripts_sa_debug = "WARNING";};
{
  [ _x, [_backpacks], true] call BIS_fnc_addVirtualBackpackCargo;
  ["DEBUG", "selectiveArsenal", format ["%1 add backpacks %2", _x, str _backpacks], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
  [ _x, [_items], true] call BIS_fnc_addVirtualItemCargo;
  ["DEBUG", "selectiveArsenal", format ["%1 add items %2", _x, str _items], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
  [ _x, [_magazines], true] call BIS_fnc_addVirtualMagazineCargo;
  ["DEBUG", "selectiveArsenal", format ["%1 add magazines %2", _x, str _magazines], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
  [ _x, [_weapons], true] call BIS_fnc_addVirtualWeaponCargo;
  ["DEBUG", "selectiveArsenal", format ["%1 add weapons %2", _x, str _weapons], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
} forEach EE_Scripts_sa_Arsenal;
"Selectiv Arsenal synchronized!" remoteExec ["hint", [0,-2] select isDedicated];
true
