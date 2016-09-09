params ["_box", "_whitelist_item", "_whitelist_weapon", "_whitelist_backpack"];
_loadlist = [_whitelist_item, _whitelist_weapon, _whitelist_backpack];
["DEBUG", "selectiveArsenal", format ["Loadlist: %1",str _loadlist], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
_objects = _box nearObjects ["B_CargoNet_01_ammo_F", 5];
_box remoteExec ["removeAllActions", [0,-2] select isDedicated];
if (isNil {EE_Scripts_sa_debug}) then {	EE_Scripts_sa_debug = "WARNING";};

if (!isNil {_objects}) then
{
  _found = false;
  {
    _arsenal = _x;
    if (_arsenal getVariable ["EE_Scripts_is_selectiveArsenal", false]) then
    {
      if (!_found) then
      {
        _found = true;
        ["DEBUG", "selectiveArsenal", format ["Arsenal found", _arsenal], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
        for [{_i=0},{_i < (count _loadlist)},{_i=_i+1}] do
        {
          _list = _loadlist select _i;
          ["DEBUG", "selectiveArsenal", format ["Loadlist %1: %2", _i, str _list], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
          {
            _eqm = _x;
            switch (_i) do
            {
              case (0):
              {
                ["INFORMATION", "selectiveArsenal", format["Add item: %1", _eqm], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
                [_arsenal, _eqm, true] call BIS_fnc_addVirtualItemCargo;
              };
              case (1):
              {
                ["INFORMATION", "selectiveArsenal", format["Add weapon: %1", _eqm], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
                [_arsenal, _eqm, true] call BIS_fnc_addVirtualWeaponCargo;
              };
              case (2):
              {
                ["INFORMATION", "selectiveArsenal", format["Add backpack: %1", _eqm], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
                [_arsenal, _eqm, true] call BIS_fnc_addVirtualBackpackCargo;
              };
            };
            _cfg = (configfile >> "CfgWeapons" >> _eqm);
            ["DEBUG", "selectiveArsenal", format ["Class %1 config %2",_eqm, _cfg], EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
            _displayName = getText (_cfg >> "displayName");
            _image = getText (_cfg >> "picture");

            _title = "<t color='#ffffff' size='1.2' shadow='1' shadowColor='#CCCCCC' align='center'>" + _displayName + "</t><br />";
            _picture = "<img size='4' image='" + _image + "' align='center'/><br />";
            _footer = "<t color='#ffffff' size='1.0' shadow='1' shadowColor='#CCCCCC' align='center'>Loaded to Selective Arsenal</t>";
           (parseText (_title + _picture + _footer)) remoteExec ["hint", [0,-2] select isDedicated];
           sleep 5;
          } forEach _list;
          "" remoteExec ["hint", [0,-2] select isDedicated];
          sleep 1;
        };
        [_arsenal] call EE_Scripts_fnc_sa_synchronizeArsenal;
      };
    };
  } forEach _objects;
  "Selectiv Arsenal items added!" remoteExec ["hint", [0,-2] select isDedicated];
  deleteVehicle _box;
};
true
