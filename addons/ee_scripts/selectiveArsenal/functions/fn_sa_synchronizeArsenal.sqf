params ["_arsenal"];
_backpacks = _arsenal call BIS_fnc_getVirtualBackpackCargo;
_items = _arsenal call BIS_fnc_getVirtualItemCargo;
_magazines = _arsenal call BIS_fnc_getVirtualMagazineCargo;
_weapons = _arsenal call BIS_fnc_getVirtualWeaponCargo;
{
  [ _x, [_backpacks], true] call BIS_fnc_addVirtualBackpackCargo;
  [0, "selectiveArsenal", format ["%1 add backpacks %2", _x, _backpacks], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
  [ _x, [_items], true] call BIS_fnc_addVirtualItemCargo;
  [0, "selectiveArsenal", format ["%1 add items %2", _x, _items], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
  [ _x, [_magazines], true] call BIS_fnc_addVirtualMagazineCargo;
  [0, "selectiveArsenal", format ["%1 add magazines %2", _x, _magazines], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
  [ _x, [_weapons], true] call BIS_fnc_addVirtualWeaponCargo;
  [0, "selectiveArsenal", format ["%1 add weapons %2", _x, _weapons], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
} forEach EE_Scripts_sa_Arsenal;
[{hint "Selectiv Arsenal synchronized!";},"BIS_fnc_spawn",true,true] call BIS_fnc_MP;
true
