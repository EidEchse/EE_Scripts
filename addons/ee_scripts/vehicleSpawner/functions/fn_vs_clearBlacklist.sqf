params ["_pool", "_type"];

if (EE_Scripts_vs_debug) then {systemChat format["Clear pool from blacklist: %1", count _pool]};
{
  switch (_type) do {
    if (EE_Scripts_vs_debug) then {systemChat format["Remove from blacklist: %1", _x]};
    case "aa": {
      EE_Scripts_vs_blacklist_aa = EE_Scripts_vs_blacklist_aa - [_x];
    };
    case "vehicle": {
      EE_Scripts_vs_blacklist_vehicle = EE_Scripts_vs_blacklist_vehicle - [_x];
    };
    case "artillary": {
      EE_Scripts_vs_blacklist_artillary = EE_Scripts_vs_blacklist_artillary - [_x];
    };
    case "plane": {
      EE_Scripts_vs_blacklist_plane = EE_Scripts_vs_blacklist_plane - [_x];
    };
    case "boat": {
      EE_Scripts_vs_blacklist_boat = EE_Scripts_vs_blacklist_boat - [_x];
    };
    case "helicopter": {
      EE_Scripts_vs_blacklist_helicopter = EE_Scripts_vs_blacklist_helicopter - [_x];
    };
  };
} forEach _pool;
true
