params ["_logic"];
_reloading = _logic getVariable "Reloading";
_distance = _logic getVariable "Distance";
_time = _logic getVariable "Time";
_items = _logic getVariable "Items";
_magazines = _logic getVariable "Magazines";

_box = _logic getVariable "Box";
_reloading = _reloading splitString ",;";

while {true} do
{
    [0, "reloadingAmmobox", "Check for reload"] call EE_Scripts_fnc_debug;
    [1, "reloadingAmmobox", format["nearestObjects[%1, %2, %3]",_box, _reloading, _distance]] call EE_Scripts_fnc_debug;
    _boxes = nearestObjects [_box, _reloading, _distance];
    _alive = false;
    {
      [1, "reloadingAmmobox", format["Found box %1 for reload",_x]] call EE_Scripts_fnc_debug;
      if (alive _x) then {
        _alive = true;
      };
    } forEach _boxes;
    if (_alive) then
    {
      [1, "reloadingAmmobox", "AmmoboxNear"] call EE_Scripts_fnc_debug;
      if (!isNil {_items}) then {
        _boxItem = getItemCargo _box;
        {
          _cfgItem = _x;
          [1, "reloadingAmmobox", format["Check items %1",count (_boxItem select 0)]] call EE_Scripts_fnc_debug;
          _found = false;
          for [{_i=0},{_i < count (_boxItem select 0)},{_i=_i+1}] do
          {
            [1, "reloadingAmmobox", format["Compare Item %1 == %2",_cfgItem select 0, (_boxItem select 0 select _i)]] call EE_Scripts_fnc_debug;
            if ((_cfgItem select 0) == (_boxItem select 0 select _i)) then
            {
              [0, "reloadingAmmobox", format["Item %1 found in box",_cfgItem]] call EE_Scripts_fnc_debug;
              _found = true;
              if ((_cfgItem select 1) > (_boxItem select 1 select _i)) then
              {
                _name = _cfgItem select 0;
                _count = (_cfgItem select 1) - (_boxItem select 1 select _i);
                systemChat format ["ReloadingAmmobox: Reloading item: %1 x %2...", _count, _name];
                sleep _time;
                _box addItemCargoGlobal [_name, _count];
              };
            };
          };

          if (!_found) then {
            _name = _cfgItem select 0;
            _count = _cfgItem select 1;
            systemChat format ["ReloadingAmmobox: Adding item: %1 x %2...",_count , _name];
            sleep _time;
            _box addItemCargoGlobal [_name, _count];
          };
        } forEach _items;
      };

      if (!isNil {_magazines}) then {
        {
          _boxMagazin = getMagazineCargo _box;
          _cfgMagazin = _x;
          [1, "reloadingAmmobox", format["Check magazine %1",count (_boxMagazin select 0)]] call EE_Scripts_fnc_debug;
          _found = false;
          for [{_i=0},{_i < count (_boxMagazin select 0)},{_i=_i+1}] do
          {
            [1, "reloadingAmmobox", format["Compare magazine %1 == %2",_cfgMagazin select 0, (_boxMagazin select 0 select _i)]] call EE_Scripts_fnc_debug;
            if ((_cfgMagazin select 0) == (_boxMagazin select 0 select _i)) then {
              [0, "reloadingAmmobox", format["Magazine %1 found in box",_cfgMagazin]] call EE_Scripts_fnc_debug;
              _found = true;
              if ((_cfgMagazin select 1) > (_boxMagazin select 1 select _i)) then {
                _name = _cfgMagazin select 0;
                _count = (_cfgMagazin select 1) - (_boxMagazin select 1 select _i);
                systemChat format ["ReloadingAmmobox: Reloading magazine: %1 x %2...", _count, _name];
                sleep _time;
                _box addMagazineCargoGlobal [_name, _count];
              };
            };
          };

          if (!_found) then {
            _name = _cfgMagazin select 0;
            _count = _cfgMagazin select 1;
            systemChat format ["ReloadingAmmobox: Adding magazine: %1 x %2...",_count , _name];
            sleep _time;
            _box addItemCargoGlobal [_name, _count];
          };
        } forEach _magazines;
      };
    };
  sleep 60;
};
