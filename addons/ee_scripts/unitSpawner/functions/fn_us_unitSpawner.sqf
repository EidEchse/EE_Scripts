// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

if ( isNil {EE_Scripts_us_debug}) then {
		EE_Scripts_us_debug = getNumber ( configfile >> "EE_Scripts" >> "unitSpawner" >> "debug");
		if (EE_Scripts_us_debug == 0) then {
			EE_Scripts_us_debug = false;
		}else{
			EE_Scripts_us_debug = true;
		};
};

_units = _logic getVariable ["Units",'B_Soldier_F,B_Soldier_GL_F,B_soldier_AR_F'];
if (EE_Scripts_us_debug) then {systemChat format["Units to spawn: %1",_units]};
_logic setVariable ["Units", _units, true];
_count = _logic getVariable ["Count",1];
if (EE_Scripts_us_debug) then {systemChat format["Number of units: %1",_count]};
_logic setVariable ["Count", _count, true];
_respawn = _logic getVariable ["Respawn",60];
if (EE_Scripts_us_debug) then {systemChat format["Time to respawn: %1",_respawn]};
_logic setVariable ["Respawn", _respawn, true];

if (_activated) then {
  if (EE_Scripts_us_debug) then {systemChat "init"};
  private ["_box"];
  _box = _logic getVariable "Box";
  if (isNil {_box}) then {
      _box = "CargoNet_01_box_F" createVehicle position _logic;
  };
  _logic setVariable ["Box", _box, true];
  _box allowDamage false;
  _box setDir getDir _logic;
  _box setPos getPos _logic;
  clearMagazineCargoGlobal _box;
  clearItemCargoGlobal _box;
  clearWeaponCargoGlobal _box;
  clearBackpackCargoGlobal _box;

  [_logic] call EE_Scripts_fnc_us_createActions;
};

true
