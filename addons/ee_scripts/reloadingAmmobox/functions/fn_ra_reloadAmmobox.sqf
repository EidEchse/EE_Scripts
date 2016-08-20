params ["_logic"];
_init = _logic getVariable "Init";
_reloading = _logic getVariable "Reloading";
_distance = _logic getVariable "Distance";
_time = _logic getVariable "Time";
_items = compile (_logic getVariable "Items");
_items = [] call _items;
_magazines = compile  (_logic getVariable "Magazines");
_magazines = [] call _magazines;

_box = _logic getVariable "Box";
_reloading = _reloading splitString ",;";

while {true} do
{
    if (EE_Scripts_ra_debug) then {systemChat "DEBUG: reloadingAmmobox: check for reload"};
    if (EE_Scripts_ra_debug) then {systemChat format["DEBUG: reloadingAmmobox: nearestObjects[%1, %2, %3]",_box, _reloading, _distance]};
    _boxes = nearestObjects [_box, _reloading, _distance];
    _alive = false;
    {
      if (EE_Scripts_ra_debug) then {systemChat format["DEBUG: reloadingAmmobox: found box %1 for reload",_x]};
      if (alive _x) then {
        _alive = true;
      };
    } forEach _boxes;
    if (_alive) then
    {
      if (EE_Scripts_ra_debug) then {systemChat "DEBUG: reloadingAmmobox: AmmoboxNear"};
      if (!isNil {_items}) then {
        _boxItem = getItemCargo _box;
        {
          _cfgItem = _x;
          if (EE_Scripts_ra_debug) then {systemChat format["DEBUG: reloadingAmmobox: Check items %1",count (_boxItem select 0)]};
          _found = false;
          for [{_i=0},{_i < count (_boxItem select 0)},{_i=_i+1}] do
          {
            if (EE_Scripts_ra_debug) then {systemChat format["DEBUG: reloadingAmmobox: Compare Item %1 == %2",_cfgItem select 0, (_boxItem select 0 select _i)]};
            if ((_cfgItem select 0) == (_boxItem select 0 select _i)) then
            {
              if (EE_Scripts_ra_debug) then {systemChat format["DEBUG: reloadingAmmobox: Item %1 found in box",_cfgItem]};
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
            /*systemChat format ["ReloadingAmmobox: Adding item: %1 x %2...",_count , _name];*/
            sleep _time;
            _box addItemCargoGlobal [_name, _count];
          };
        } forEach _items;
      };

      if (!isNil {_magazines}) then {
        {
          _boxMagazin = getMagazineCargo _box;
          _cfgMagazin = _x;
          if (EE_Scripts_ra_debug) then {systemChat format["DEBUG: reloadingAmmobox: Check magzines %1",count (_boxMagazin select 0)]};
          _found = false;
          for [{_i=0},{_i < count (_boxMagazin select 0)},{_i=_i+1}] do
          {
            if (EE_Scripts_ra_debug) then {systemChat format["DEBUG: reloadingAmmobox: Compare Magzine %1 == %2",_cfgMagazin select 0, (_boxMagazin select 0 select _i)]};
            if ((_cfgMagazin select 0) == (_boxMagazin select 0 select _i)) then {
              if (EE_Scripts_ra_debug) then {systemChat format["DEBUG: reloadingAmmobox: Magzine %1 found in box",_cfgMagazin]};
              _found = true;
              if ((_cfgMagazin select 1) > (_boxMagazin select 1 select _i)) then {
                _name = _cfgMagazin select 0;
                _count = (_cfgMagazin select 1) - (_boxMagazin select 1 select _i);
                systemChat format ["ReloadingAmmobox: Reloading magzine: %1...", _name];
                sleep _time;
                _box addMagazineCargoGlobal [_name, _count];
              };
            };
          };

          if (!_found) then {
            _name = _cfgMagazin select 0;
            _count = _cfgMagazin select 1;
            /*systemChat format ["ReloadingAmmobox: Adding magazine: %1 x %2...",_count , _name];*/
            sleep _time;
            _box addItemCargoGlobal [_name, _count];
          };
        } forEach _magazines;
      };
    };
  sleep 60;
};
