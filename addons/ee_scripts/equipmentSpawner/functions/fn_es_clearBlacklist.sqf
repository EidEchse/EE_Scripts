params ["_logic", "_pool"];

_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_type = _logic getVariable "Type";

["INFORMATION", _module, format["Clear pool from blacklist: %1", count _pool], _debug] spawn EE_Scripts_fnc_debug;
{
  _group_array = _x;
  {
    ["DEBUG", _module, format["Remove from blacklist: %1", _x], _debug] spawn EE_Scripts_fnc_debug;
    switch (_type) do
    {
      case "item":
      {
        EE_Scripts_es_blacklist_item = EE_Scripts_es_blacklist_item - [_x];
      };
      case "weapon":
      {
        EE_Scripts_es_blacklist_weapon = EE_Scripts_es_blacklist_weapon - [_x];
      };
      case "backpack":
      {
        EE_Scripts_es_blacklist_backpack = EE_Scripts_es_blacklist_backpack - [_x];
      };
    };
  } forEach _group_array;
} forEach _pool;
true
