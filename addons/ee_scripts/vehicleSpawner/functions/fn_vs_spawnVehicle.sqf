params ["_logic"];

_type = _logic getVariable "Type"; //Type of equipment
if (isNil {_type}) then {_type = "vehicle"};
[0, "vehicleSpawner", format["Vehicle type: %1",_type], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
_logic setVariable ["Type", _type, true];
_level = _logic getVariable "Level"; //Level of the box
if (isNil {_level}) then {_level = 25};
[0, "vehicleSpawner", format["Vehicle level: %1",_level], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
_logic setVariable ["Level", _level, true];
_range = _logic getVariable "Range"; //Range for leveled Eqipment selection
if (isNil {_range}) then {_range = 5};
[0, "vehicleSpawner", format["Vehicle range: %1",_range], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
_logic setVariable ["Range", _range, true];

_vehicleName = _logic getVariable "VehicleName";
if (isNil{_vehicleName}) then
{
	//Select the equipment config for the equipment type
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

	[0, "vehicleSpawner", format["Cfg levels: %1", count _cfg], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;

	//Calculate the minimum and maximum level vor the equipment selection
	private ["_max", "_min"];
	if ((_level + _range) > ((count _cfg)-1)) then
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
	[0, "vehicleSpawner", format["Min level: %1",_min], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
	[0, "vehicleSpawner", format["Max level: %1",_max], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;

	_pool = [_min, _max, _type, _cfg] call EE_Scripts_fnc_vs_createPool;
	private "_vehicle";
	if (count _pool > 0) then
	{
		[0, "vehicleSpawner", format["Pool size: %1",count _pool], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
		_vehicleName = [_pool, _type] call EE_Scripts_fnc_vs_selectVehicle;
		[0, "vehicleSpawner", format ["Selected vehicle %1 type %2", _vehicleName, _type], EE_Scripts_vs_debug] spawn EE_Scripts_fnc_debug;
		_vehicle = _logic getVariable "Vehicle";
		if (!isNil {_vehicle}) then
		{
			if (alive  _vehicle) then
			{
				deleteVehicle _vehicle;
			};
		};

		_position = _logic getVariable ["Home", position _logic];
		_dir = _logic getVariable ["HomeDir", getDir _logic];
		_vehicle = _vehicleName createVehicle _position;
		_vehicle setDir _dir;

		_vehicle setVariable ["ALIVE_profileIgnore", true];
		_logic setVariable ["Vehicle", _vehicle, true];
		clearMagazineCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearWeaponCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;
		/*_vehicle addAction ["Set Home", '(_this select 3) setVariable ["Home", (position (_this select 0)), true];(_this select 3) setVariable ["HomeDir", (getDir (_this select 0)), true];', _logic, 1.5, false];*/
		[_vehicle, ["Set Home", {(_this select 3) setVariable ["Home", (position (_this select 0)), true];(_this select 3) setVariable ["HomeDir", (getDir (_this select 0)), true];}, _logic, 1.5, false]] remoteExec ["addAction", -2, _vehicle];

	  if (EE_Scripts_vs_debug < 3) then
		{
			/*_vehicle addAction ["SpawnVehicle", "[_this select 3] call EE_Scripts_fnc_vs_spawnVehicle;", _logic, 1.5, false];*/
			[_vehicle, ["SpawnVehicle", {[_this select 3] call EE_Scripts_fnc_vs_spawnVehicle;}, _logic, 1.5, false]] remoteExec ["addAction", -2, _vehicle];
		};
		/*[_logic, _vehicle] call EE_Scripts_fnc_vs_toggleLock;*/
		_vehicle lock 2;
		_logic setVariable ["VehicleName", _vehicleName, true];
		[_logic,_vehicleName] spawn EE_Scripts_fnc_vs_respawnVehicle;
	};
};

true
