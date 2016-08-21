params ["_logic"];
_init = _logic getVariable "Init";
_vehicleName = _logic getVariable "Name";
_respawn = _logic getVariable "Respawn";

_vehicle = _logic getVariable "Vehicle";
if (!isNil {_vehicle}) then {
  waitUntil ({!alive _vehicle;});
  _vehicle = nil;
  if (EE_Scripts_vr_debug) then {systemChat format["DEBUG: vehicleRespawner: Vehicle %1 distroyed", _vehicleName]};
  _respawnIn = round _respawn;
  while{_respawnIn > 0} do
  {
    systemChat format["Vehicle Respawner: Vehicle %1 respawns in %2 minutes", _vehicleName , _respawnIn];
    _respawnIn = _respawnIn - 1;
    sleep 60;
  };
};

_position = _logic getVariable ["Home", position _logic];
_dir = _logic getVariable ["HomeDir", getDir _logic];
_vehicle = _vehicleName createVehicle _position;
_vehicle setDir _dir;
_return = true;
if (!isNull _vehicle) then {
  systemChat format["Vehicle Respawner: Vehicle %1 respawned", _vehicleName];
  _vehicle setVariable ["ALIVE_profileIgnore", true];
  _logic setVariable ["Vehicle", _vehicle, true];
  clearMagazineCargoGlobal _vehicle;
  clearItemCargoGlobal _vehicle;
  clearWeaponCargoGlobal _vehicle;
  clearBackpackCargoGlobal _vehicle;

  if (_init != "") then {
    [_logic,_vehicle, _vehicleName] execVM _init;
  };

  if (EE_Scripts_vr_debug) then {systemChat "DEBUG: vehicleRespawner: Vehicle %1 init called"};

  /*_vehicle addAction ["Set Home", '(_this select 3) setVariable ["Home", (position (_this select 0)), true];(_this select 3) setVariable ["HomeDir", (getDir (_this select 0)), true];', _logic, 1.5, false];*/
  [_vehicle, ["Set Home", {(_this select 3) setVariable ["Home", (position (_this select 0)), true];(_this select 3) setVariable ["HomeDir", (getDir (_this select 0)), true];}, _logic, 1.5, false]] remoteExec ["addAction", -2, _vehicle];

  if (EE_Scripts_vr_debug) then {
    /*_vehicle addAction ["DEBUG: SpawnVehicle", "[_this select 3] call EE_Scripts_fnc_vr_respawnVehicle;", _logic, 1.5, false];*/
    [_vehicle, ["DEBUG: SpawnVehicle", {[_this select 3] call EE_Scripts_fnc_vr_respawnVehicle;}, _logic, 1.5, false]] remoteExec ["addAction", -2, _vehicle];
  };

  /*[_logic, _vehicle] call EE_Scripts_fnc_vs_toggleLock;*/
  _vehicle lock 2;
  [_logic] spawn EE_Scripts_fnc_vr_respawnVehicle;
}else{
  systemChat format["ERROR: vehicleRespawner: Vehicle %1 wrong class name", _vehicleName];
  _return = false;
};

_return
