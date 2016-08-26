// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = param [1,[],[[]]];
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = param [2,true,[true]];

if (_activated) then {
	if ( isNil {EE_Scripts_es_debug}) then
	{
			EE_Scripts_es_debug = getNumber ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "debug");
			if (EE_Scripts_es_debug == 0) then
			{
				EE_Scripts_es_debug = false;
			}else{
				EE_Scripts_es_debug = true;
			};
	};
	if (EE_Scripts_es_debug) then {systemChat "DEBUG: equipmentSpawner init"};

	//Select the equipment config for the equipment type
	if ( isNil {EE_Scripts_es_item}) then
	{
		EE_Scripts_es_item = getArray ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "item");
	};
	if ( isNil {EE_Scripts_es_weapon}) then
	{
		EE_Scripts_es_weapon = getArray ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "weapon");
	};
	if ( isNil {EE_Scripts_es_backpack}) then
	{
		EE_Scripts_es_backpack = getArray ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "backpack");
	};

	_type = _logic getVariable ["Type","weapon"]; //Type of equipment
	if (EE_Scripts_es_debug) then {systemChat format["DEBUG: EquipmentSpawner: Box type: %1",_type]};
	_level = _logic getVariable ["Level",25]; //Level of the box
	if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Box level: %1",_level]};
	switch (_type) do {
    switch ("item") do
		{
      if (_level > count EE_Scripts_es_item) then {
				systemChat format ["WARNING: equipmentSpawner: Box level %1 higher than item config level %2", _level, count EE_Scripts_es_item];
				_level = count EE_Scripts_es_item;
			};
    };
    switch ("weapon") do
		{
      if (_level > count EE_Scripts_es_weapon) then {
				systemChat format ["WARNING: equipmentSpawner: Box level %1 higher than weapon config level %2", _level, count EE_Scripts_es_item];
				_level = count EE_Scripts_es_weapon;
			};
    };
    switch ("backpack") do
		{
      if (_level > count EE_Scripts_es_backpack) then {
				systemChat format ["WARNING: equipmentSpawner: Box level %1 higher than backpack config level %2", _level, count EE_Scripts_es_item];
				_level = count EE_Scripts_es_backpack;
			};
    };
		if (_level < 0) then {
			systemChat format ["WARNING: equipmentSpawner: Box level %1 lower than 0", _level];
			_level = 0;
		};
	};
	_range = _logic getVariable ["Range",5]; //Range for leveled Eqipment selection
	if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Box range: %1",_range]};
	if (_level < 0) then {
		systemChat format ["WARNING: equipmentSpawner: Box range %1 higher than box level %2", _range, _level];
		_ERROR = true;
	};

	_logic setVariable ["Type", _type, true];
	_logic setVariable ["Level", _level, true];
	_logic setVariable ["Range", _range, true];

	if ( isNil {EE_Scripts_es_blacklist_item}) then {	EE_Scripts_es_blacklist_item = [];};
	if ( isNil {EE_Scripts_es_blacklist_weapon}) then {	EE_Scripts_es_blacklist_weapon = [];};
	if ( isNil {EE_Scripts_es_blacklist_backpack}) then {	EE_Scripts_es_blacklist_backpack = [];};

	private ["_box"];
	_box = _logic getVariable "Box";
	if (isNil {_box}) then
	{
	  //Spawn the right box for the right type
	  switch _type do
	  {
	    case "item":
	    {
	      _box = "Box_NATO_Support_F" createVehicle position _logic;
	    };
	    case "weapon":
	    {
	      if (_level <= 30) then
	      {
	        _box = "Box_NATO_Wps_F" createVehicle position _logic;
	      }else{
	        _box = "Box_NATO_WpsSpecial_F" createVehicle position _logic;
	      };
	    };
	    case "backpack":
	    {
	      _box = "B_supplyCrate_F" createVehicle position _logic;
	    };
	   };
	   _logic setVariable ["Box", _box, true];
	};

	_box allowDamage false;
	_box setDir getDir _logic;
	_box setPos getPos _logic;
	clearMagazineCargoGlobal _box;
	clearItemCargoGlobal _box;
	clearWeaponCargoGlobal _box;
	clearBackpackCargoGlobal _box;
	_box setVariable["EE_Scripts_is_equipmentSpawner", true, true];

 [_logic, _box, _type, _level, _range] call EE_Scripts_fnc_es_fillBox;
 _whitelist_item = _logic getVariable ["EE_Scripts_es_whitelist_item", []];
 _whitelist_weapon = _logic getVariable ["EE_Scripts_es_whitelist_weapon", []];
 _whitelist_backpack = _logic getVariable ["EE_Scripts_es_bwhitelist_backpack", []];

 [_box, ["Load to Arsenal", {[_this select 3 select 0, _this select 3 select 1, _this select 3 select 2, _this select 3 select 3] call EE_Scripts_fnc_sa_loadEquipment;}, [_box, _whitelist_item, _whitelist_weapon, _whitelist_backpack],1.4,false,false,"","[_target] call EE_Scripts_fnc_es_selectiveArsenalNear"]] remoteExec ["addAction", 0, _box];
 if (EE_Scripts_es_debug) then {
	 _box = _logic getVariable "Box";
	 [_box, ["FillBox", {[_this select 3 select 0, _this select 3 select 1, _this select 3 select 2, _this select 3 select 3] call EE_Scripts_fnc_es_fillBox;}, [_logic, _box, _type, _level, _range]]] remoteExec ["addAction", -2, _box];
 };
};

true
