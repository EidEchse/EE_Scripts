params ["_logic"];
_init = _logic getVariable "Init";
_reloading = _logic getVariable "Reloading";
_distance = _logic getVariable "Distance";
_time = _logic getVariable "Time";
_items = _logic getVariable "Items";
_magazines = _logic getVariable "Magazines";

_box = _logic getVariable "Box";
_reloading = _reloading splitString ",;";

_existingItems = getItemCargo _box;
_existingMagazines = getMagazineCargo _box;

while {true} do {
{
    _boxes = nearestObjects [_box, _reloading, _distance];
    if (count _boxes > 0) then
    {
      {
        _cfgItem = _x;
        for [{_i=0},{_i < count _boxItem},{_i=_i+1}] do
        {
          if (_cfgItem select 0 == (_boxItem select _i select 0)) then
          {
            _found = true;
            if (_cfgItem select 1 < (_boxItem select _i select 1)) then
            {
              _name = _cfgItem select 0;
              _count = _cfgItem select 1 - (_boxItem select _i select 1);
              _box addItemCargoGlobal [_name, _count];
            }
          };
        };
      } forEach _items;

      {
        _cfgMagazin = _x;
        for [{_i=0},{_i < count _boxMagazin},{_i=_i+1}] do
        {
          if (_cfgMagazin select 0 == (_boxMagazin select _i select 0)) then {
            _found = true;
            if (_cfgMagazin select 1 < (_boxMagazin select _i select 1)) then {
              _name = _cfgMagazin select 0;
              _count = _cfgMagazin select 1 - (_boxMagazin select _i select 1);
              sleep _time;
              _box addMagazineCargoGlobal [_name, _count];
            }
          };
        };
      } forEach _magazines;
    }
  sleep 60;
};
