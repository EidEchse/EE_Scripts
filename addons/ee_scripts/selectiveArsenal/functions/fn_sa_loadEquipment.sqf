params ["_box", "_whitelist_item", "_whitelist_weapon", "_whitelist_backpack"];
_list = _whitelist_backpack;
_objects = _box nearObjects ["B_CargoNet_01_ammo_F", 5];
if (!isNil {_objects}) then
{
  _found = false;
  {
    _arsenal = _x;
    if (_x getVariable ["EE_Scripts_is_selectiveArsenal", false]) then
    {
      if (!_found) then {
        _found = true;
        if (count _list > 0) then
        {
          {
            if (EE_Scripts_sa_debug) then {systemChat format["Add Backpack: %1", _list select 0]};
            [_arsenal, _x, true] call BIS_fnc_addVirtualBackpackCargo;
            _cfg = (configfile >> "CfgWeapons" >> _x);
            if (EE_Scripts_sa_debug) then {systemChat format ["DEBUG: selectiveArsenal: class %1 config %2",_x, _cfg]};
            _displayName = getText (_cfg >> "displayName");
            _image = getText (_cfg >> "picture");

            _title = "<t color='#ffffff' size='1.2' shadow='1' shadowColor='#CCCCCC' align='center'>" + _displayName + "</t><br />";
            _picture = "<img size='4' image='" + _image + "' align='center'/><br />";
            _footer = "<t color='#ffffff' size='1.0' shadow='1' shadowColor='#CCCCCC' align='center'>Loaded to Selective Arsenal</t>";
            hint parseText (_title + _picture + _footer);
          } forEach _list;
          sleep 5;
          hint "";
          sleep 0.5;
        };

        _list = _whitelist_item;
        if (count _list > 0) then
        {
          {
            if (EE_Scripts_sa_debug) then {systemChat format["Add Item: %1", _list select 0]};
            [_arsenal, _x, true] call BIS_fnc_addVirtualItemCargo;
            _cfg = (configfile >> "CfgWeapons" >> _x);
            if (EE_Scripts_sa_debug) then {systemChat format ["DEBUG: selectiveArsenal: class %1 config %2",_x, _cfg]};
            _displayName = getText (_cfg >> "displayName");
            _image = getText (_cfg >> "picture");

            _title = "<t color='#ffffff' size='1.2' shadow='1' shadowColor='#CCCCCC' align='center'>" + _displayName + "</t><br />";
            _picture = "<img size='4' image='" + _image + "' align='center'/><br />";
            _footer = "<t color='#ffffff' size='1.0' shadow='1' shadowColor='#CCCCCC' align='center'>Loaded to Selective Arsenal</t>";
            hint parseText (_title + _picture + _footer);
            sleep 5;
            hint "";
            sleep 0.5;
          } forEach _list;
        };

        _list = _whitelist_weapon;
        if (count _list > 0) then
        {
          {
            if (EE_Scripts_sa_debug) then {systemChat format["Add Weapon: %1", _list select 0]};
            [_arsenal, _x, true] call BIS_fnc_addVirtualWeaponCargo;
            _cfg = (configfile >> "CfgWeapons" >> _x);
            if (EE_Scripts_sa_debug) then {systemChat format ["DEBUG: selectiveArsenal: class %1 config %2",_x, _cfg]};
            _displayName = getText (_cfg >> "displayName");
            _image = getText (_cfg >> "picture");

            _title = "<t color='#ffffff' size='1.2' shadow='1' shadowColor='#CCCCCC' align='center'>" + _displayName + "</t><br />";
            _picture = "<img size='4' image='" + _image + "' align='center'/><br />";
            _footer = "<t color='#ffffff' size='1.0' shadow='1' shadowColor='#CCCCCC' align='center'>Loaded to Selective Arsenal</t>";
            hint parseText (_title + _picture + _footer);
            sleep 5;
            hint "";
            sleep 0.5;
          } forEach _list;
        };
        [_arsenal] call EE_Scripts_fnc_sa_synchronizeArsenal;
      };
    };
  } forEach _objects;;
  hint "Selectiv Arsenal items added!";
  deleteVehicle _box;
};

true
