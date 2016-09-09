if (isServer) then {
	// Argument 0 is module logic.
	_logic = param [0,objNull,[objNull]];
	// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
	_units = param [1,[],[[]]];
	// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
	_activated = param [2,true,[true]];

	if (isNil {EE_Scripts_sa_debug}) then {	EE_Scripts_sa_debug = "WARNING";};
	publicVariable "EE_Scripts_sa_debug";

	if (isNil{EE_Scripts_sa_Arsenal}) then
	{
		EE_Scripts_sa_Arsenal = [];
		publicVariable "EE_Scripts_sa_Arsenal";
	};

	if ( isNil {EE_Scripts_sa_magazines}) then
	{
		EE_Scripts_sa_magazines = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "magazines");
		publicVariable "EE_Scripts_sa_magazines";
	};
	if ( isNil {EE_Scripts_sa_items}) then
	{
		EE_Scripts_sa_items = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "items");
		publicVariable "EE_Scripts_sa_items";
	};
	if ( isNil {EE_Scripts_sa_backpacks}) then
	{
		EE_Scripts_sa_backpacks = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "backpacks");
		publicVariable "EE_Scripts_sa_backpacks";
	};
	if ( isNil {EE_Scripts_sa_weapons}) then
	{
		EE_Scripts_sa_weapons = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "weapons");
		publicVariable "EE_Scripts_sa_weapons";
	};

	if (_activated) then
	{
		["INFORMATION", "selectiveArsenal", "Activated", EE_Scripts_sa_debug] spawn EE_Scripts_fnc_debug;
	  _box = ["selectiveArsenal", _logic, "Box_NATO_AmmoVeh_F"] call EE_SCripts_fnc_spawnBox;
		_box setVariable["EE_Scripts_is_selectiveArsenal", true, true];
		EE_Scripts_sa_Arsenal pushBackUnique _box;
		publicVariable "EE_Scripts_sa_Arsenal";

		["AmmoboxInit",[_box,false]] call BIS_fnc_arsenal;
	  [_box, EE_Scripts_sa_weapons, true] call BIS_fnc_addVirtualMagazineCargo;
	  [_box, EE_Scripts_sa_backpacks, true] call BIS_fnc_addVirtualMagazineCargo;
	  [_box, EE_Scripts_sa_magazines, true] call BIS_fnc_addVirtualMagazineCargo;
	  [_box, EE_Scripts_sa_items, true] call BIS_fnc_addVirtualItemCargo;
	};
};
true
