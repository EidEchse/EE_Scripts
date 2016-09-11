params ["_logic" ,"_pool"];
_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_type = _logic getVariable "Type";

_select =  floor (random ((count _pool) -1));
["INFORMATION", _module, format["Select random pool number: %1", _select], _debug] spawn EE_Scripts_fnc_debug;
_eqm = _pool select _select;
scopeName "main";
_listed = [_logic, _eqm] call EE_Scripts_fnc_es_inBlacklist;
if (_listed) then
{
	["DEBUG", _module, "Select another equipment down", _debug] spawn EE_Scripts_fnc_debug;
	_i = _select -1;
  while {_i >= 0} do
	{
		_eqm = _pool select  _i;
		["DEBUG", _module, format["Select pool number: %1", _i], _debug] spawn EE_Scripts_fnc_debug;
		_listed = [_logic, _eqm] call EE_Scripts_fnc_es_inBlacklist;
		if (!_listed) then
		{
			breakTo "main";
		};
		_i = _i - 1;
  };

	["INFORMATION", _module, "Select another equipment up", _debug] spawn EE_Scripts_fnc_debug;
	_i = _select +1;
  while {_i <= ((count _pool) -1)} do
  {
    _eqm = _pool select  _i;
		["INFORMATION", _module, format["Select pool number: %1", _i], _debug] spawn EE_Scripts_fnc_debug;
    _listed = [_logic, _eqm] call EE_Scripts_fnc_es_inBlacklist;
    if (!_listed) then
		{
      breakTo "main";
    };
		_i = _i + 1;
	};
  [_logic, _pool] call EE_Scripts_fnc_es_clearBlacklist;
	_eqm = _pool select _select;
};

{
	["DEBUG", _module, format["Add to blacklist: %1", _x], _debug] spawn EE_Scripts_fnc_debug;
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
