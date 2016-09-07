// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

if (isNil {EE_Scripts_vr_debug}) then {	EE_Scripts_vr_debug = "WARNING";};

_init = _logic getVariable ["Init", ""];
_logic setVariable ["Init", _init, true];

_name = _logic getVariable "Name";
if (isNil {_name}) then {
	["ERROR", "vehicleRespawner", "Vehiclename is unset", EE_Scripts_vr_debug] spawn EE_Scripts_fnc_debug;
};
_logic setVariable ["Name", _name, true];

_respawn = _logic getVariable ["Respawn", 0];
_logic setVariable ["Respawn", _respawn, true];

if (_activated) then
{
	["DEBUG", "vehicleRespawner", "Activated", EE_Scripts_vr_debug] spawn EE_Scripts_fnc_debug;

 [_logic, _name, EE_Scripts_vr_debug] spawn EE_Scripts_fnc_spawnVehicle;
};
true
