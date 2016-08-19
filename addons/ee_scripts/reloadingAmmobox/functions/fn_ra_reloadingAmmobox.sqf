// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

if ( isNil {EE_Scripts_ra_debug}) then {
		EE_Scripts_ra_debug = getNumber ( configfile >> "EE_Scripts" >> "reloadingAmmobox" >> "debug");
		if (EE_Scripts_ra_debug == 0) then {
			EE_Scripts_ra_debug = false;
		}else{
			EE_Scripts_ra_debug = true;
		};
};

if ( isNil {EE_Scripts_ra_items}) then {
		EE_Scripts_ra_items = getNumber ( configfile >> "EE_Scripts" >> "reloadingAmmobox" >> "items");
};
if ( isNil {EE_Scripts_ra_magzines}) then {
		EE_Scripts_ra_magzines = getNumber ( configfile >> "EE_Scripts" >> "reloadingAmmobox" >> "magazines");
};

_init = _logic getVariable ["Init", ""];
_logic setVariable ["Init", _init, true];

_reloading = _logic getVariable ["Reloading", ""];
_logic setVariable ["Reloading", _reloading, true];

_distance = _logic getVariable ["Distance", 2];
if (_distance < 2) then {
	systemChat "WARNING: reloadingAmmobox: Distance under 2m set to 2m";
};
_logic setVariable ["Distance", _distance, true];

_time = _logic getVariable ["Time", 0];
_logic setVariable ["Time", _time, true];

_items = _logic getVariable ["Items", [[]]];
_logic setVariable ["Items", _items, true];

_magazines = _logic getVariable ["Magazines", [[]]];
_logic setVariable ["Magazines", _magazines, true];


if (_activated) then {
	if (EE_Scripts_ra_debug) then {systemChat "DEBUG: reloadingAmmobox activated"};

	private ["_box"];
  _box = _logic getVariable "Box";
  if (isNil {_box}) then {
      _box = "Box_NATO_AmmoVeh_F" createVehicle position _logic;
  };
  _logic setVariable ["Box", _box, true];
  _box allowDamage false;
  _box setDir getDir _logic;
  _box setPos getPos _logic;
  clearMagazineCargoGlobal _box;
  clearItemCargoGlobal _box;
  clearWeaponCargoGlobal _box;
  clearBackpackCargoGlobal _box;

 	[_logic] spawn EE_Scripts_fnc_ra_watchForReload;
};
true
