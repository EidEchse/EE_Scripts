params ["_logic", "_vehicleName", "_debug"];
_init = _logic getVariable "Init";
_respawn = _logic getVariable "Respawn";

_vehicle = _logic getVariable "Vehicle";

_cfg = (configfile >> "cfgVehicles" >> _vehicleName);
["DEBUG", "vehicleSpawner", format ["Class %1 config %2", _vehicleName, _cfg], _debug] spawn EE_Scripts_fnc_debug;
_displayName = getText (_cfg >> "displayName");
_image = getText (_cfg >> "picture");

_title = "<t color='#ffffff' size='1.2' shadow='1' shadowColor='#CCCCCC' align='center'>" + _displayName + "</t><br />";
_picture = "<img size='4' image='" + _image + "' align='center'/><br />";
if (!isNil {_vehicle}) then
{
  waitUntil ({!alive _vehicle;});
  ["INFORMATION", "vehicleSpawner", format["Vehicle %1 distroyed", _vehicleName], _debug] spawn EE_Scripts_fnc_debug;
  _respawnIn = round _respawn;
  while{_respawnIn > 0} do
  {
    if (_respawnIn > 1) then
    {
      (format["Vehicle %1 respawns in %2 minutes", _displayName, _respawnIn]) remoteExec ["systemChat", [0,-2] select isDedicated];
    }else{
      (format["Vehicle %1 respawns in less than %2 minute", _displayName, 1]) remoteExec ["systemChat", [0,-2] select isDedicated];
    };
    _respawnIn = _respawnIn - 1;
    sleep 60;
    waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
  };
  if (!isNil {_vehicle}) then
  {
    deleteVehicle _vehicle;
    sleep 1;
  };
};

_position = _logic getVariable ["Home", position _logic];
_dir = _logic getVariable ["HomeDir", getDir _logic];
_vehicle = _vehicleName createVehicle _position;
_vehicle setDir _dir;
_return = true;
if (!isNull _vehicle) then
{
  _vehicle setVariable ["ALIVE_profileIgnore", true];
  _logic setVariable ["Vehicle", _vehicle, true];
  clearMagazineCargoGlobal _vehicle;
  clearItemCargoGlobal _vehicle;
  clearWeaponCargoGlobal _vehicle;
  clearBackpackCargoGlobal _vehicle;

  if (_init != "") then
  {
    [_logic,_vehicle, _vehicleName] execVM _init;
  };

  ["DEBUG", "vehicleSpawner", "Vehicle %1 init called", _debug] spawn EE_Scripts_fnc_debug;

  [_vehicle, ["Set Home", {(_this select 3) setVariable ["Home", (position (_this select 0)), true];(_this select 3) setVariable ["HomeDir", (getDir (_this select 0)), true];}, _logic, 1.5, false]] remoteExec ["addAction", [0,-2] select isDedicated, _vehicle];

  if (_debug isEqualTo "DEBUG") then
  {
    [_vehicle, ["SpawnVehicle", {[_this select 3] call EE_Scripts_fnc_vr_respawnVehicle;}, _logic, 1.5, false]] remoteExec ["addAction", [0,-2] select isDedicated, _vehicle];
  };

  _vehicle lock 2;
  [_logic, _vehicleName, _debug] spawn EE_Scripts_fnc_spawnVehicle;
  _firstRun = _logic getVariable ["firstRun", true];
  if (!_firstRun) then
  {
    _footer = "<t color='#ffffff' size='1.0' shadow='1' shadowColor='#CCCCCC' align='center'>respawned</t>";
    (parseText (_title + _picture + _footer)) remoteExec ["hint", [0,-2] select isDedicated];
  }else{
    _logic setVariable ["firstRun", false, true];
  };
}else{
  ["ERROR", "vehicleSpawner", format["Vehicle %1 wrong class name", _vehicleName], _debug] spawn EE_Scripts_fnc_debug;
  _return = false;
};
_return
