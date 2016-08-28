params ["_pool", "_type"];

[0, "equipmentSpawner", format["Clear pool from blacklist: %1", count _pool], EE_Scripts_es_debug] call EE_Scripts_fnc_debug;
{
  _group_array = _x;
  {
    [0, "equipmentSpawner", format["Remove from blacklist: %1", _x], EE_Scripts_es_debug] call EE_Scripts_fnc_debug;
    switch (_type) do {
      case "item": {
          EE_Scripts_Scripts_es_blacklist_item = EE_Scripts_es_blacklist_item - [_x];
      	};
      case "weapon": {
          EE_Scripts_es_blacklist_weapon = EE_Scripts_es_blacklist_weapon - [_x];
      	};
      case "backpack": {
        EE_Scripts_es_blacklist_backpack = EE_Scripts_es_blacklist_backpack - [_x];
      };
    };
  } forEach _group_array;
} forEach _pool;
true
