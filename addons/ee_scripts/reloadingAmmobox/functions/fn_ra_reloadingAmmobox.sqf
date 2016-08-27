// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

_reloading = _logic getVariable ["Reloading", ""];
_logic setVariable ["Reloading", _reloading, true];

_distance = _logic getVariable ["Distance", 2];
if (_distance < 2) then {
	[2, "reloadingAmmobox", "Distance under 2m set to 2m"] call EE_Scripts_fnc_debug;
};
_logic setVariable ["Distance", _distance, true];

_time = _logic getVariable ["Time", 0];
_logic setVariable ["Time", _time, true];

_items = _logic getVariable ["Items", ""];
if ( _Items == "") then {
	_Items = getArray ( configfile >> "EE_Scripts" >> "reloadingAmmobox" >> "items");
}else{
	[1, "reloadingAmmobox", "Loading items from config"] call EE_Scripts_fnc_debug;
	_items = compile (_logic getVariable "Items");
	_items = [] call _items;
};
_logic setVariable ["Items", _items, true];

_magazines = _logic getVariable ["Magazines", ""];
if ( _magazines == "") then {
	_magazines = getArray ( configfile >> "EE_Scripts" >> "reloadingAmmobox" >> "magazines");
}else{
	[1, "reloadingAmmobox", "Loading magazines from config"] call EE_Scripts_fnc_debug;
	_magazines = compile  (_logic getVariable "Magazines");
	_magazines = [] call _magazines;
};
_logic setVariable ["Magazines", _magazines, true];


if (_activated) then {
	[0, "reloadingAmmobox", "Activated"] call EE_Scripts_fnc_debug;

	_box = ["unitSpawner", _logic, "Box_NATO_Ammo_F"] call EE_SCripts_fnc_spawnBox;

 	[_logic] spawn EE_Scripts_fnc_ra_reloadAmmobox;
};

true
