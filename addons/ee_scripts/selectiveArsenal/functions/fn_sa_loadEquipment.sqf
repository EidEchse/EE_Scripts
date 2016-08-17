params ["_box","_caller"];
_list = getBackpackCargo _box;
if (count _list > 0) then {
  if (EE_Scripts_sa_debug) then {systemChat format["Add Backpack: %1", _list select 0]};
  [_box, _list select 0, true] call BIS_fnc_addVirtualBackpackCargo;
};

_list = getItemCargo _box;
if (count _list > 0) then {
  if (EE_Scripts_sa_debug) then {systemChat format["Add Item: %1", _list select 0]};
  [_box, _list select 0, true] call BIS_fnc_addVirtualItemCargo;
};

_list = getWeaponCargo _box;
if (count _list > 0) then {
  if (EE_Scripts_sa_debug) then {systemChat format["Add Weapon: %1", _list select 0]};
  [_box, _list select 0, true] call BIS_fnc_addVirtualWeaponCargo;
};

_list = getMagazineCargo _box;
if (count _list > 0) then {
  if (EE_Scripts_sa_debug) then {systemChat format["Add Magazine: %1", _list select 0]};
  [_box, _list select 0, true] call BIS_fnc_addVirtualMagazineCargo;
};

if (!isNil{_caller}) then {
  _list = getBackpackCargo _caller;
  if (count _list > 0) then {
    if (EE_Scripts_sa_debug) then {systemChat format["Add Backpack: %1", _list select 0]};
    [_box, _list select 0, true] call BIS_fnc_addVirtualBackpackCargo;
  };

  _list = getItemCargo _caller;
  if (count _list > 0) then {
    if (EE_Scripts_sa_debug) then {systemChat format["Add Item: %1", _list select 0]};
    [_box, _list select 0, true] call BIS_fnc_addVirtualItemCargo;
  };

  _list = getWeaponCargo _caller;
  if (count _list > 0) then {
    if (EE_Scripts_sa_debug) then {systemChat format["Add Weapon: %1", _list select 0]};
    [_box, _list select 0, true] call BIS_fnc_addVirtualWeaponCargo;
  };

  _list = getMagazineCargo _caller;
  if (count _list > 0) then {
    if (EE_Scripts_sa_debug) then {systemChat format["Add Magazine: %1", _list select 0]};
    [_box, _list select 0, true] call BIS_fnc_addVirtualMagazineCargo;
  };
};

clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearBackpackCargoGlobal _box;
true
