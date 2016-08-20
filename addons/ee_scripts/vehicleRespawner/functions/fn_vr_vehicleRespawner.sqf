// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

if ( isNil {EE_Scripts_vr_debug}) then {
		EE_Scripts_vr_debug = getNumber ( configfile >> "EE_Scripts" >> "vehicleRespawner" >> "debug");
		if (EE_Scripts_vr_debug == 0) then {
			EE_Scripts_vr_debug = false;
		}else{
			EE_Scripts_vr_debug = true;
		};
};

_init = _logic getVariable ["Init", ""];
_logic setVariable ["Init", _init, true];

_name = _logic getVariable "Name";
if (isNil {_name}) then {
	systemChat "DEBUG: vehicleRespawner: Vehiclename is unset";
};
_logic setVariable ["Name", _name, true];

_respawn = _logic getVariable ["Respawn", 0];
_logic setVariable ["Respawn", _respawn, true];

if (_activated) then {
	if (EE_Scripts_vr_debug) then {systemChat "DEBUG: vehicleRespawner activated"};

 [_logic] spawn EE_Scripts_fnc_vr_respawnVehicle;
};
true
