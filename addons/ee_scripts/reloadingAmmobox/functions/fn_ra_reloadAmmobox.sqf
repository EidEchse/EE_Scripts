params ["_logic", "_loadList"];
_reloading = _logic getVariable "Reloading";
_distance = _logic getVariable "Distance";
_time = _logic getVariable "Time";

_box = _logic getVariable "Box";
_reloading = _reloading splitString ",;";

while {true} do
{
  ["DEBUG", "reloadingAmmobox", "Check for reload"] spawn EE_Scripts_fnc_debug;
  ["INFORMATION", "reloadingAmmobox", format["nearestObjects[%1, %2, %3]", _box, _reloading, _distance], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
  _reloaded = false;
  _boxes = nearestObjects [_box, _reloading, _distance];
  _alive = false;
  {
    ["DEBUG", "reloadingAmmobox", format["Found box %1 for reload", _x], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
    if (alive _x) then
    {
      _alive = true;
    };
  } forEach _boxes;

  if (_alive) then
  {
    ["INFORMATION", "reloadingAmmobox", "AmmoboxNear"] spawn EE_Scripts_fnc_debug;

    _magazineCargo = getMagazineCargo _box;
    _itemCargo = getItemCargo _box;
    _cargos = [_itemCargo, _magazineCargo];
    for [{_i=0},{_i < 2},{_i=_i+1}] do
    {
      _load = _loadList select _i;
      for [{_j=0},{_j < count (_load select 0)},{_j=_j+1}] do
      {
        _loadName = _load select 0 select _j;
        _loadCount = _load select 1 select _j;
        _foundIn = 2;
        _count = _loadCount;
        scopeName "found";
        for [{_k=0},{_k < 2},{_k=_k+1}] do
        {
          _cargo = _cargos select _k;
          for [{_l=0},{_l < count (_cargo select 0)},{_l=_l+1}] do
          {
            _eqmName = _cargo select 0 select _l;
            _eqmCount = _cargo select 1 select _l;
            if ((toLower _loadName) isEqualTo (toLower _eqmName)) then
            {
              _foundIn = _k;
              _count = _loadCount - _eqmCount;
              ["DEBUG", "reloadingAmmobox", format["Equipment %1 found in box", _eqmName], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
              breakTo "found";
            };
          };
        };
        if ((_foundIn != _i) and {_foundIn != 2}) then
        {
          ((_loadList select _i) select 0) deleteAt _j;
          ((_loadList select _i) select 1) deleteAt _j;
          ["WARNING", "reloadingAmmobox", format["Equipment %1 in wrong config %2 should be in %3", _loadName, _i, _foundIn], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
        }else{
          if (_count > 0) then
          {
            sleep _time;
            switch (_foundIn) do
            {
              case (0):
              {
                _box addItemCargoGlobal [_loadName, _count];
                ["INFORMATION", "reloadingAmmobox", format ["Reloading item: %1 x %2...", _count, _loadName], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
              };
              case (1):
              {
                _box addMagazineCargoGlobal [_loadName, _count];
                ["INFORMATION", "reloadingAmmobox", format ["Reloading magazine: %1 x %2...", _count, _loadName], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
              };
              case (2):
              {
                if (_i == 0) then
                {
                  _box addItemCargoGlobal [_loadName, _count];
                  ["INFORMATION", "reloadingAmmobox", format ["Added item: %1 x %2...", _count, _loadName], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
                }else{
                  _box addMagazineCargoGlobal [_loadName, _count];
                  ["INFORMATION", "reloadingAmmobox", format ["Added magazine: %1 x %2...", _count, _loadName], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
                };
              };
            };
            _reloaded = true;
          };
        };
      };
    };

    if (_reloaded) then
    {
      "AmmoBox reloaded" remoteExec ["hint", 0];
      sleep 10;
    };
  };
  sleep 10;
};
true
