// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

if ( isNil {EE_Scripts_sa_debug}) then {
		EE_Scripts_sa_debug = getNumber ( configfile >> "EE_Scripts" >> "unitSpawner" >> "debug");
		if (EE_Scripts_sa_debug == 0) then {
			EE_Scripts_sa_debug = false;
		}else{
			EE_Scripts_sa_debug = true;
		};
};

if ( isNil {EE_Scripts_sa_magzines}) then {
	EE_Scripts_sa_magzines = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "magzines");
};
if ( isNil {EE_Scripts_sa_items}) then {
	EE_Scripts_sa_items = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "items");
};

if (_activated) then {
  if (EE_Scripts_sa_debug) then {systemChat "Init selectiveArsenal"};
  private ["_box"];
  _box = _logic getVariable "Box";
  if (isNil {_box}) then {
      _box = "Box_NATO_Wps_F" createVehicle position _logic;
  };
  _logic setVariable ["Box", _box, true];
  _box allowDamage false;
  _box setDir getDir _logic;
  _box setPos getPos _logic;
  clearMagazineCargoGlobal _box;
  clearItemCargoGlobal _box;
  clearWeaponCargoGlobal _box;
  clearBackpackCargoGlobal _box;

	0 = ["AmmoboxInit",[_box,false]] spawn BIS_fnc_arsenal;
  [_box,EE_Scripts_sa_magzines,true] call BIS_fnc_addVirtualMagazineCargo;
  [_box,EE_Scripts_sa_items,true] call BIS_fnc_addVirtualItemCargo;

	_box addAction ["Load content to Arsenal", "[_this select 0, _this select 1] call EE_Scripts_fnc_sa_loadEquipment",[],1.7,false,false];
  [_box] call EE_Scripts_fnc_sa_loadEquipment;
};

true
