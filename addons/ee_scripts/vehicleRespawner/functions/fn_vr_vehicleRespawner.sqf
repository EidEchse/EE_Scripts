// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

if ( isNil {EE_Scripts_vr_debug}) then {
			EE_Scripts_vr_debug = false;
};

_init = _logic getVariable ["Init", ""];
_name = _logic getVariable "Name";
if (isNil {_name}) then {
	systemChat "DEBUG: vehicleRespawner: Vehiclename is unset";
};
_respawn = _logic getVariable ["Respawn", 0];

if (_activated) then {
	if (EE_Scripts_vr_debug) then {systemChat "DEBUG: vehicleRespawner activated"};

 [_logic] spawn EE_Scripts_fnc_vr_respawnVehicle;
};
true
