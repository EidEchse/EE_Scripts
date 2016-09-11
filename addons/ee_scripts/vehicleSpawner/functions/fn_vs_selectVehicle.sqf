params ["_logic", "_pool"];

_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_type = _logic getVariable "Type";

_select =  floor (random ((count _pool) -1));
["DEBUG", _module, format["Select random pool number: %1", _select], _debug] spawn EE_Scripts_fnc_debug;
_vehicleName = _pool select _select;
scopeName "main";
_listed = [_logic, _vehicleName] call EE_Scripts_fnc_vs_inBlacklist;
if (_listed) then {
	["DEBUG", _module, "Select another equipment down", _debug] spawn EE_Scripts_fnc_debug;
	_i = _select -1;
  while {_i >= 0} do
	{
		_vehicleName = _pool select  _i;
		["DEBUG", _module, format["Select pool number: %1", _i], _debug] spawn EE_Scripts_fnc_debug;
		_listed = [_logic, _vehicleName] call EE_Scripts_fnc_vs_inBlacklist;
		if (!_listed) then {
			breakTo "main";
		};
		_i = _i - 1;
  };

	["DEBUG", _module, "Select another vehicle up", _debug] spawn EE_Scripts_fnc_debug;
	_i = _select +1;
  while {_i <= ((count _pool) -1)} do
  {
    _vehicleName = _pool select  _i;
		["DEBUG", _module, format["Select pool number: %1", _i], _debug] spawn EE_Scripts_fnc_debug;
    _listed = [_logic, _vehicleName] call EE_Scripts_fnc_vs_inBlacklist;
    if (!_listed) then {
      breakTo "main";
    };
		_i = _i + 1;
	};
  [_logic, _pool] call EE_Scripts_fnc_vs_clearBlacklist;
	_vehicleName = _pool select _select;
};

["DEBUG", _module, format["Add to blacklist: %1", _vehicleName], _debug] spawn EE_Scripts_fnc_debug;
switch _type do {
	case "aa": {
		EE_Scripts_vs_blacklist_aa = EE_Scripts_vs_blacklist_aa + [_vehicleName];
	};
	case "vehicle": {
		EE_Scripts_vs_blacklist_vehicle = EE_Scripts_vs_blacklist_vehicle + [_vehicleName];
	};
	case "artillary": {
		EE_Scripts_vs_blacklist_artillary = EE_Scripts_vs_blacklist_artillary + [_vehicleName];
	};
	case "plane": {
		EE_Scripts_vs_blacklist_plane = EE_Scripts_vs_blacklist_plane + [_vehicleName];
	};
	case "boat": {
		EE_Scripts_vs_blacklist_boat = EE_Scripts_vs_blacklist_boat + [_vehicleName];
	};
	case "helicopter": {
		EE_Scripts_vs_blacklist_helicopter = EE_Scripts_vs_blacklist_helicopter + [_vehicleName];
	};
};

_vehicleName
