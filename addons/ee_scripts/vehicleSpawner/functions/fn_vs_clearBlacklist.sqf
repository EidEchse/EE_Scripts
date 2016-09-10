params ["_logic", "_pool"];
_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_type = _logic getVariable "Type";

["INFORMATION", _module, format["Clear pool from blacklist: %1", count _pool], _debug] spawn EE_Scripts_fnc_debug;
{
  switch (_type) do {
    ["DEBUG", _module, format["Remove from blacklist: %1", _x], _debug] spawn EE_Scripts_fnc_debug;
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
