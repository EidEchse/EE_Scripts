if (isServer) then {
	// Argument 0 is module logic.
	_logic = param [0,objNull,[objNull]];
	// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
	_units = param [1,[],[[]]];
	// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
	_activated = param [2,true,[true]];

	//Modulename for Messages
	_module = "selectiveArsenal";
	_debug = "WARNING";
	if (!isNil "EE_Scripts_sa_debug") then {
		_debug = EE_Scripts_sa_debug;
	};
	_logic setVariable ["Module", _module];
	_logic setVariable ["Debug", _debug];

	if (isNil "EE_Scripts_sa_Arsenal") then
	{
		EE_Scripts_sa_Arsenal = [];
	};

	if ( isNil "EE_Scripts_sa_magazines") then
	{
		EE_Scripts_sa_magazines = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "magazines");
	};
	if ( isNil "EE_Scripts_sa_items") then
	{
		EE_Scripts_sa_items = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "items");
	};
	if ( isNil "EE_Scripts_sa_backpacks") then
	{
		EE_Scripts_sa_backpacks = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "backpacks");
	};
	if ( isNil "EE_Scripts_sa_weapons") then
	{
		EE_Scripts_sa_weapons = getArray ( configfile >> "EE_Scripts" >> "selectiveArsenal" >> "weapons");
	};

	if ( isNil "EE_Scripts_sa_boxClasses") then
	{
		EE_Scripts_sa_boxClasses = [];
	};

	if (_activated) then
	{
		["INFORMATION", _module, "Activated", _debug] spawn EE_Scripts_fnc_debug;
		_logic setVariable ["BoxClassDefault", "Box_NATO_AmmoVeh_F"];
	  _box = [_logic] call EE_SCripts_fnc_spawnBox;
		_box setVariable["EE_Scripts_is_selectiveArsenal", true, true];
		EE_Scripts_sa_boxClasses pushBackUnique (_logic getVariable ["BoxClass", "Box_NATO_AmmoVeh_F"]);
		EE_Scripts_sa_Arsenal pushBackUnique _box;

		["AmmoboxInit", [_box, false]] call BIS_fnc_arsenal;
	  [_box, EE_Scripts_sa_magazines, true] call BIS_fnc_addVirtualMagazineCargo;
	  [_box, EE_Scripts_sa_items, true] call BIS_fnc_addVirtualItemCargo;
	  [_box, EE_Scripts_sa_backpacks, true] call BIS_fnc_addVirtualBackpackCargo;
	  [_box, EE_Scripts_sa_weapons, true] call BIS_fnc_addVirtualWeaponCargo;
	};
};
true
