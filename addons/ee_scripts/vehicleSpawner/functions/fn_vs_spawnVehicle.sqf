params ["_logic"];
_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_type = _logic getVariable "Type";
_level = _logic getVariable "Level";
_range = _logic getVariable "Range";

private "_cfg";
switch _type do
{
	case "aa":
	{
		_cfg = EE_Scripts_vs_aa;
	};
	case "vehicle":
	{
		_cfg = EE_Scripts_vs_vehicle;
	};
	case "artillary":
	{
		_cfg = EE_Scripts_vs_artillary;
	};
	case "plane":
	{
		_cfg = EE_Scripts_vs_plane;
	};
	case "boat":
	{
		_cfg = EE_Scripts_vs_boat;
	};
	case "helicopter":
	{
		_cfg = EE_Scripts_vs_helicopter;
	};
};
["DEBUG", _module, format["Cfg levels: %1", count _cfg], _debug] spawn EE_Scripts_fnc_debug;

private "_respawn_cfg";
switch _type do
{
  case "aa": {
    _respawn_cfg = EE_Scripts_vs_respawn_aa;
  };
  case "vehicle":
  {
    _respawn_cfg = EE_Scripts_vs_respawn_vehicle;
  };
  case "artillary":
  {
    _respawn_cfg = EE_Scripts_vs_respawn_artillary;
  };
  case "plane":
  {
    _respawn_cfg = EE_Scripts_vs_respawn_plane;
  };
  case "boat":
  {
    _respawn_cfg = EE_Scripts_vs_respawn_boat;
  };
  case "helicopter":
  {
    _respawn_cfg = EE_Scripts_vs_respawn_helicopter;
  };
};

private ["_max", "_min"];
if ((_level + _range -1) > ((count _cfg)-1)) then
{
  _max = (count _cfg)-1;
}else{
  _max = _level + _range;
};

if ((_level - _range) < 0) then
{
  _min = 0;
}else{
  _min = _level - _range;
};
["DEBUG", _module, format["Min level: %1", _min], _debug] spawn EE_Scripts_fnc_debug;
["DEBUG", _module, format["Max level: %1", _max], _debug] spawn EE_Scripts_fnc_debug;

_pool = [_min, _max, _type, _cfg] call EE_Scripts_fnc_vs_createPool;
if (count _pool > 0) then
{
	["DEBUG", _module, format["Pool size: %1",count _pool], _debug] spawn EE_Scripts_fnc_debug;
	_vehicleName = [_logic, _pool] call EE_Scripts_fnc_vs_selectVehicle;
	["DEBUG", _module, format ["Selected vehicle %1 type %2", _vehicleName, _type], _debug] spawn EE_Scripts_fnc_debug;

	_level = 0;
	scopeName "main";
	{
		_level_array = _x;
		{
			if (_x == _vehicleName) then
			{
				["DEBUG", _module, format["Vehicle %1 level found: %2", _level, _vehicleName], _debug] spawn EE_Scripts_fnc_debug;
				breakTo "main";
			};
		} forEach _level_array;
		_level = _level + 1;
	} forEach _cfg;
	_respawn = _respawn_cfg select _level;
	_logic setVariable ["Respawn", _respawn];
	_result = [str _vehicleName, configFile >> "CfgVehicles"] call EE_Scripts_fnc_getConfig;
	if (isNil{_result}) then {
		["ERROR", _module, format["No vehilce config found for: %1", _vehicleName], _debug] spawn EE_Scripts_fnc_debug;
	}else{
		_logic setVariable ["Name", _result];
		[_logic] spawn EE_Scripts_fnc_spawnVehicle;
	};
}else{
	["WARNING", _module, format ["No Vehicles in range from %1 to %2", _min, _max], _debug] spawn EE_Scripts_fnc_debug;
};

true
