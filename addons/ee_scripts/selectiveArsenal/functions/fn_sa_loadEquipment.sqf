if (isServer) then {
  params ["_logic"];

  _module = _logic getVariable "Module";
  _debug = _logic getVariable "Debug";

  _box = _logic getVariable "Box";
  _loadListItem = _logic getVariable "LoadListItem";
  _loadListWeapon = _logic getVariable "LoadListWeapon";
  _loadListBackpack = _logic getVariable "LoadListBackpack";

  _loadlist = [_loadListItem, _loadListWeapon, _loadListBackpack];
  ["DEBUG", _module, format ["Loadlist: %1", str _loadlist], _debug] spawn EE_Scripts_fnc_debug;
  _netId = (netId _box) + "removeAllActions";
  _box remoteExec ["removeAllActions", [0,-2] select isDedicated, _netId];
  {
    _className = _x;
    _objects = _box nearObjects [_className, 5];
    _found = false;
    if (!isNil {_objects}) then
    {
      {
        _arsenal = _x;
        if (_arsenal getVariable ["EE_Scripts_is_selectiveArsenal", false]) then
        {
          if (!_found) then
          {
            _found = true;
            ["DEBUG", _module, format ["Arsenal found", _arsenal], _debug] spawn EE_Scripts_fnc_debug;
            for [{_i=0},{_i < (count _loadlist)},{_i=_i+1}] do
            {
              _list = _loadlist select _i;
              ["DEBUG", _module, format ["Loadlist %1: %2", _i, str _list], _debug] spawn EE_Scripts_fnc_debug;
              {
                _eqm = _x;
                switch (_i) do
                {
                  case (0):
                  {
                    ["INFORMATION", _module, format["Add item: %1", _eqm], _debug] spawn EE_Scripts_fnc_debug;
                    [_arsenal, _eqm, true] call BIS_fnc_addVirtualItemCargo;
                  };
                  case (1):
                  {
                    ["INFORMATION", _module, format["Add weapon: %1", _eqm], _debug] spawn EE_Scripts_fnc_debug;
                    [_arsenal, _eqm, true] call BIS_fnc_addVirtualWeaponCargo;
                  };
                  case (2):
                  {
                    ["INFORMATION", _module, format["Add backpack: %1", _eqm], _debug] spawn EE_Scripts_fnc_debug;
                    [_arsenal, _eqm, true] call BIS_fnc_addVirtualBackpackCargo;
                  };
                };
                _cfg = (configfile >> "CfgWeapons" >> _eqm);
                ["DEBUG", _module, format ["Class %1 config %2",_eqm, _cfg], _debug] spawn EE_Scripts_fnc_debug;
                _displayName = getText (_cfg >> "displayName");
                _image = getText (_cfg >> "picture");

                _title = "<t color='#ffffff' size='1.2' shadowColor='#CCCCCC' align='center'>" + _displayName + "</t><br />";
                _picture = "<img size='4' image='" + _image + "' align='center'/><br />";
                _footer = "<t color='#ffffff' size='1.0' shadowColor='#CCCCCC' align='center'>Loaded to Selective Arsenal</t>";
               (parseText (_title + _picture + _footer)) remoteExec ["hint", [0,-2] select isDedicated];
               sleep 5;
              } forEach _list;
              "" remoteExec ["hint", [0,-2] select isDedicated];
              sleep 1;
            };
            [_arsenal] call EE_Scripts_fnc_sa_synchronizeArsenal;
            sleep 5;
          };
        };
      } forEach _objects;
      "Selectiv Arsenal items added!" remoteExec ["hint", [0,-2] select isDedicated];
      deleteVehicle _box;
    };
  } forEach EE_Scripts_sa_boxClasses;
};
true
