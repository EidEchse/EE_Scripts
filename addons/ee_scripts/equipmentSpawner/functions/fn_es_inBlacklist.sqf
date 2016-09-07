params [ "_logic", "_eqm"];

_type = _logic getVariable "Type";

private "_blacklist";
switch (_type) do
{
  case "item":
  {
      _blacklist = EE_Scripts_es_blacklist_item;
  };
  case "weapon":
  {
      _blacklist = EE_Scripts_es_blacklist_weapon;
  };
  case "backpack":
  {
    _blacklist = EE_Scripts_es_blacklist_backpack;
  };
};

private _return = false;
scopeName "main";
{
  _blackEqm = _x;
  switch (_type) do
  {
    ["DEBUG", "equipmentSpawner", format["Check: %1", _blackEqm], EE_Scripts_es_debug] spawn EE_Scripts_fnc_debug;
    if (_x == _blackEqm) then
    {
      ["DEBUG", "equipmentSpawner", format["%1: %2 is in blacklist!", _type, _x], EE_Scripts_es_debug] spawn EE_Scripts_fnc_debug;
		  _return = true;
			breakTo "main";
    };
  } forEach _eqm;
} forEach _blacklist;

_return
