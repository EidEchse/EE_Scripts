params ["_pool", "_type"];

if (EE_Scripts_es_debug) then {systemChat format["Clear pool from blacklist: %1", count _pool]};
{
  _group_array = _x;
  {
    if (EE_Scripts_es_debug) then {systemChat format["Remove from blacklist: %1", _x]};
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
