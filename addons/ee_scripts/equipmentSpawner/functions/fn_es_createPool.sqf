params ["_min", "_max","_type"];

//Select the equipment config for the equipment type
private "_cfg";
switch _type do {
	case "item": {
		_cfg = EE_Scripts_es_item;
	};
	case "weapon": {
		_cfg = EE_Scripts_es_weapon;
	};
	case "backpack": {
		_cfg = EE_Scripts_es_backpack;
	};
};

_pool = [];
for [{_i = _min}, {_i <= _max}, {_i=_i+1}] do
{
    _level_array = _cfg select _i;
    {
      if (count _x > 0) then {
        _pool pushBack _x;
      };
    } forEach _level_array;
};

_pool
