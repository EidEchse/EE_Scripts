params ["_logic"];
_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_init = _logic getVariable "Init";
_respawn = _logic getVariable "Respawn";
_vehicleName = _logic getVariable "Name";

_vehicle = _logic getVariable "Vehicle";

_cfg = (configfile >> "cfgVehicles" >> _vehicleName);
["DEBUG", _module, format ["Class %1 config %2", _vehicleName, _cfg], _debug] spawn EE_Scripts_fnc_debug;
_displayName = getText (_cfg >> "displayName");
_image = getText (_cfg >> "picture");

_title = "<t color='#ffffff' size='1.2' shadowColor='#CCCCCC' align='center'>" + _displayName + "</t><br />";
_picture = "<img size='4' image='" + _image + "' align='center'/><br />";
if (!isNil "_vehicle") then
{
  waitUntil ({!alive _vehicle;});
  _footer = "<t color='#ffffff' size='1.0' shadowColor='#CCCCCC' align='center'>distroyed</t>";
  (parseText (_title + _picture + _footer)) remoteExec ["hint", [0,-2] select isDedicated];
  _respawnIn = round _respawn;
  while{_respawnIn > 0} do
  {
    if ((_respawnIn / 5) < 1) then {
      (format["Vehicle %1 respawns in %2 minutes", _displayName, _respawnIn]) remoteExec ["systemChat", [0,-2] select isDedicated];
    }else{
      if ((_respawnIn mod 5) == 0) then {
        (format["Vehicle %1 respawns in %2 minutes", _displayName, _respawnIn]) remoteExec ["systemChat", [0,-2] select isDedicated];
      };
    };
    _respawnIn = _respawnIn - 1;
    sleep 60;
    waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
  };
  if (!isNil "_vehicle") then
  {
    deleteVehicle _vehicle;
    _vehicle = nil;
    sleep 5;
  };
};
_position = _logic getVariable ["Home", position _logic];
_dir = _logic getVariable ["HomeDir", getDir _logic];
_vehicle = _vehicleName createVehicle _position;
if (!isNull _vehicle) then
{
  _vehicle setDir _dir;
  _vehicle setPos _position;
  _vehicle setVariable ["ALIVE_profileIgnore", true];
  _vehicle lock 2;
  _logic setVariable ["Vehicle", _vehicle];
  clearMagazineCargoGlobal _vehicle;
  clearItemCargoGlobal _vehicle;
  clearWeaponCargoGlobal _vehicle;
  clearBackpackCargoGlobal _vehicle;

  if (_init != "") then
  {
    [_logic, _vehicle, _vehicleName] execVM _init;
  };

  ["DEBUG", _module, format ["Vehicle %1 init called", _vehicleName], _debug] spawn EE_Scripts_fnc_debug;

  _serverFunction = {
    _netId = (netId (_this select 3)) + "EE_Scripts_fnc_setHome";
    (_this select 3) remoteExec ["EE_Scripts_fnc_setHome", [0, 2] select isDedicated, _netId];
  };
  _addActionParams = ["Set Home", _serverFunction, _logic, 1.5, false];
  _netId = (netId _logic) + "addAction" + "Set Home";
  [_vehicle, _addActionParams] remoteExec ["addAction", [0,-2] select isDedicated, _netId];

  [_logic, _vehicleName, _debug] call EE_Scripts_fnc_spawnVehicle;

  _firstRun = _logic getVariable ["FirstRun", true];
  if (!_firstRun) then
  {
    _footer = "<t color='#ffffff' size='1.0' shadowColor='#CCCCCC' align='center'>respawned</t>";
    (parseText (_title + _picture + _footer)) remoteExec ["hint", [0,-2] select isDedicated];
  }else{
    _logic setVariable ["FirstRun", false];
  };
}else{
  ["ERROR", _module, format["Vehicle %1 wrong class name", _vehicleName], _debug] spawn EE_Scripts_fnc_debug;
};
true
