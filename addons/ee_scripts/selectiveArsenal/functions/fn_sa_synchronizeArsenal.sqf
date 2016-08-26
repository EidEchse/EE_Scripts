params ["_arsenal"];
_backpacks = _arsenal call BIS_fnc_getVirtualBackpackCargo;
_items = _arsenal call BIS_fnc_getVirtualItemCargo;
_magazines = _arsenal call BIS_fnc_getVirtualMagazineCargo;
_weapons = _arsenal call BIS_fnc_getVirtualWeaponCargo;
{
   [ _x, [_backpacks], true] call BIS_fnc_addVirtualBackpackCargo;
   if (EE_Scripts_sa_debug) then {systemChat format ["DEBUG: selectiveArsenal: %1 add backpacks %2",_x, _backpacks]};
   [ _x, [_items], true] call BIS_fnc_addVirtualItemCargo;
   if (EE_Scripts_sa_debug) then {systemChat format ["DEBUG: selectiveArsenal: %1 add items %2",_x, _items]};
   [ _x, [_magazines], true] call BIS_fnc_addVirtualMagazineCargo;
   if (EE_Scripts_sa_debug) then {systemChat format ["DEBUG: selectiveArsenal: %1 add magazines %2",_x, _magazines]};
   [ _x, [_weapons], true] call BIS_fnc_addVirtualWeaponCargo;
   if (EE_Scripts_sa_debug) then {systemChat format ["DEBUG: selectiveArsenal: %1 add weapons %2",_x, _weapons]};
} forEach EE_Scripts_sa_Arsenal;
hint "Selectiv Arsenal synchronized!";
true
