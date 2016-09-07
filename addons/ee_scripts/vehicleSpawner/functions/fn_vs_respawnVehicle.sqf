params ["_logic", "_vehicleName"];

_type = _logic getVariable "Type";
_vehicle = _logic getVariable "Vehicle";

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
	case "boat": {
		_cfg = EE_Scripts_vs_boat;
	};
	case "helicopter":
	{
		_cfg = EE_Scripts_vs_helicopter;
	};
};

if (!isNil{_vehicle}) then
{
	waitUntil ({!alive _vehicle;});
	[0, "vehicleSpawner", "Vehicle distroyed"] spawn EE_Scripts_fnc_debug;

	_level = 0;
	scopeName "main";
	{

	  _level_array = _x;
	  {
	    if (_x == _vehicleName) then
			{
				[0, "vehicleSpawner", format["Vehicle %1 level found: %2", _level, _vehicleName], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
	      breakTo "main";
	    };
	  } forEach _level_array;
	  _level = _level + 1;
	} forEach _cfg;

	_max = _respawn_cfg select _level;
		[0, "vehicleSpawner", format["Respawn time: %1", _max], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
	_i = floor _max;
	while{_i > 0} do
	{
	  if ((_i mod 300) == 0) then{
	    systemChat format["%1 respawns in %2 minutes.",_vehicleName,_i / 60];
	  };
	  _i = _i - 1;
	  sleep 1;
		waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
	};
	[_logic] spawn EE_Scripts_fnc_vs_spawnVehicle;
};
true
