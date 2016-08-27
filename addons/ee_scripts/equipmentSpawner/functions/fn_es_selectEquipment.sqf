params ["_pool", "_type"];

_select =  floor (random ((count _pool) -1));
if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Select random pool number: %1", _select]};
_eqm = _pool select _select;
scopeName "main";
_listed = [_eqm, _type] call EE_Scripts_fnc_es_inBlacklist;
if (_listed) then
{
	if (EE_Scripts_es_debug) then {systemChat "DEBUG: equipmentSpawner: Select another equipment down"};
	_i = _select -1;
  while {_i >= 0} do
	{
		_eqm = _pool select  _i;
		if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Select pool number: %1", _i]};
		_listed = [_eqm, _type] call EE_Scripts_fnc_es_inBlacklist;
		if (!_listed) then
		{
			breakTo "main";
		};
		_i = _i - 1;
  };

	if (EE_Scripts_es_debug) then {systemChat "DEBUG: equipmentSpawner: Select another equipment up"};
	_i = _select +1;
  while {_i <= ((count _pool) -1)} do
  {
    _eqm = _pool select  _i;
    if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Select pool number: %1", _i]};
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
  if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Add to blacklist: %1", _x]};
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
