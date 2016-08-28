params ["_pool", "_type"];

_select =  floor (random ((count _pool) -1));
[0, "vehicleSpawner", format["Select random pool number: %1", _select], EE_Scripts_vs_debug] call EE_Scripts_fnc_debug;
_vehicleName = _pool select _select;
scopeName "main";
_listed = [_vehicleName, _type] call EE_Scripts_fnc_vs_inBlacklist;
if (_listed) then {
	[0, "vehicleSpawner", "Select another equipment down"] call EE_Scripts_fnc_debug;
	_i = _select -1;
  while {_i >= 0} do
	{
		_vehicleName = _pool select  _i;
		[0, "vehicleSpawner", format["Select pool number: %1", _i], EE_Scripts_vs_debug] call EE_Scripts_fnc_debug;
		_listed = [_vehicleName, _type] call EE_Scripts_fnc_vs_inBlacklist;
		if (!_listed) then {
			breakTo "main";
		};
		_i = _i - 1;
  };

	[0, "vehicleSpawner", "Select another vehicle up"] call EE_Scripts_fnc_debug;
	_i = _select +1;
  while {_i <= ((count _pool) -1)} do
  {
    _vehicleName = _pool select  _i;
		[0, "vehicleSpawner", format["Select pool number: %1", _i], EE_Scripts_vs_debug] call EE_Scripts_fnc_debug;
    _listed = [_vehicleName, _type] call EE_Scripts_fnc_vs_inBlacklist;
    if (!_listed) then {
      breakTo "main";
    };
		_i = _i + 1;
	};
  [_pool, _type] call EE_Scripts_fnc_vs_clearBlacklist;
	_vehicleName = _pool select _select;
};
//Select the equipment config for the equipment type
[0, "vehicleSpawner", format["Add to blacklist: %1", _vehicleName], EE_Scripts_vs_debug] call EE_Scripts_fnc_debug;
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
