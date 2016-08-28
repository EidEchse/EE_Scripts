params ["_pool", "_type"];

_select =  floor (random ((count _pool) -1));
[0, "equipmentSpawner", format["Select random pool number: %1", _select], EE_Scripts_es_debug] call EE_Scripts_fnc_debug;
_eqm = _pool select _select;
scopeName "main";
_listed = [_eqm, _type] call EE_Scripts_fnc_es_inBlacklist;
if (_listed) then
{
	[0, "equipmentSpawner", "Select another equipment down", EE_Scripts_es_debug] call EE_Scripts_fnc_debug;
	_i = _select -1;
  while {_i >= 0} do
	{
		_eqm = _pool select  _i;
		[0, "equipmentSpawner", format["Select pool number: %1", _i], EE_Scripts_es_debug] call EE_Scripts_fnc_debug;
		_listed = [_eqm, _type] call EE_Scripts_fnc_es_inBlacklist;
		if (!_listed) then
		{
			breakTo "main";
		};
		_i = _i - 1;
  };

	[0, "equipmentSpawner", "Select another equipment up", EE_Scripts_es_debug] call EE_Scripts_fnc_debug;
	_i = _select +1;
  while {_i <= ((count _pool) -1)} do
  {
    _eqm = _pool select  _i;
		[1, "equipmentSpawner", format["Select pool number: %1", _i], EE_Scripts_es_debug] call EE_Scripts_fnc_debug;
    _listed = [_eqm, _type] call EE_Scripts_fnc_es_inBlacklist;
    if (!_listed) then
		{
      breakTo "main";
    };
		_i = _i + 1;
	};
  [_pool, _type] call EE_Scripts_fnc_es_clearBlacklist;
	_eqm = _pool select _select;
};

{
	[0, "equipmentSpawner", format["Add to blacklist: %1", _x], EE_Scripts_es_debug] call EE_Scripts_fnc_debug;
  switch (_type) do
	{
    case "item":
		{
        EE_Scripts_es_blacklist_item = EE_Scripts_es_blacklist_item + [_x];
    };
    case "weapon":
		{
        EE_Scripts_es_blacklist_weapon = EE_Scripts_es_blacklist_weapon + [_x];
    };
    case "backpack":
		{
      EE_Scripts_es_blacklist_backpack = EE_Scripts_es_blacklist_backpack + [_x];
    };
  };
} forEach _eqm;

_eqm
