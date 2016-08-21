// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

if ( isNil {EE_Scripts_es_debug}) then {
		EE_Scripts_es_debug = getNumber ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "debug");
		if (EE_Scripts_es_debug == 0) then {
			EE_Scripts_es_debug = false;
		}else{
			EE_Scripts_es_debug = true;
		};
};

//Select the equipment config for the equipment type
if ( isNil {EE_Scripts_es_item}) then {
	EE_Scripts_es_item = getArray ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "item");
};
if ( isNil {EE_Scripts_es_weapon}) then {
	EE_Scripts_es_weapon = getArray ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "weapon");
};
if ( isNil {EE_Scripts_es_backpack}) then {
	EE_Scripts_es_backpack = getArray ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "backpack");
};

if (_activated) then {
	if ( isNil {EE_Scripts_es_blacklist_item}) then {	EE_Scripts_es_blacklist_item = [];};
	if ( isNil {EE_Scripts_es_blacklist_weapon}) then {	EE_Scripts_es_blacklist_weapon = [];};
	if ( isNil {EE_Scripts_es_blacklist_backpack}) then {	EE_Scripts_es_blacklist_backpack = [];};

	if (EE_Scripts_es_debug) then {systemChat "init"};

 [_logic] call EE_Scripts_fnc_es_fillBox;
 if (EE_Scripts_es_debug) then {
	 _box = _logic getVariable "Box";
	 /*_box addAction ["FillBox", "[_this select 3] call EE_Scripts_fnc_es_fillBox;", _logic];*/
	 [_box, ["FillBox", {[_this select 3] call EE_Scripts_fnc_es_fillBox;}, _logic]] remoteExec ["addAction", -2, _box];
 };
};

true
