if (isServer) then {
	// Argument 0 is module logic.
	_logic = param [0,objNull,[objNull]];
	// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
	_units = param [1,[],[[]]];
	// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
	_activated = param [2,true,[true]];

	//Modulename for Messages
	_module = "equipmentSpawner";
	_debug = "WARNING";
	if (!isNil "EE_Scripts_es_debug") then {
		_debug = EE_Scripts_es_debug;
	};
	_logic setVariable ["Module", _module];
	_logic setVariable ["Debug", _debug];

	//Select the equipment config for the equipment type
	if (isNil "EE_Scripts_es_item") then {
		EE_Scripts_es_item = getArray ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "item");
	};
	if (isNil "EE_Scripts_es_weapon") then {
		EE_Scripts_es_weapon = getArray ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "weapon");
	};
	if (isNil "EE_Scripts_es_backpack") then {
		EE_Scripts_es_backpack = getArray ( configfile >> "EE_Scripts" >> "equipmentSpawner" >> "backpack");
	};

	_level = _logic getVariable ["Level", 25]; //Level of the box
	if (_level < 0) then
	{
		["WARNING", _module, format ["Box level %1 lower than 0", _level], _debug] spawn EE_Scripts_fnc_debug;
		_level = 0;
	};

	_type = _logic getVariable ["Type", "weapon"]; //Type of equipment
	_logic setVariable ["Type", _type];
	["DEBUG", _module, format["Box type: %1", _type], _debug] spawn EE_Scripts_fnc_debug;
	switch (_type) do
	{
	  case "item":
		{
	    if (_level > count EE_Scripts_es_item) then
			{
				["WARNING", _module, format ["Box level %1 higher than item config level %2", _level, count EE_Scripts_es_item], _debug] spawn EE_Scripts_fnc_debug;
				_level = count EE_Scripts_es_item;
			};
	  };
	  case "weapon":
		{
	    if (_level > count EE_Scripts_es_weapon) then
			{
				["WARNING", _module, format ["Box level %1 higher than weapon config level %2", _level, count EE_Scripts_es_weapon], _debug] spawn EE_Scripts_fnc_debug;
				_level = count EE_Scripts_es_weapon;
			};
	  };
	  case "backpack":
		{
	    if (_level > count EE_Scripts_es_backpack) then
			{
				["WARNING", _module, format ["Box level %1 higher than backpack config level %2", _level, count EE_Scripts_es_backpack], _debug] spawn EE_Scripts_fnc_debug;
				_level = count EE_Scripts_es_backpack;
			};
	  };
	};
	_logic setVariable ["Level", _level];
	["DEBUG", _module, format["Box level: %1", _level], _debug] spawn EE_Scripts_fnc_debug;

	_range = _logic getVariable ["Range", 5]; //Range for leveled Eqipment selection
	if ((_level - _range) < 0) then
	{
		["WARNING", _module, format["Box range %1 higher than box level %2", _range, _level], _debug] spawn EE_Scripts_fnc_debug;
	};
	_logic setVariable ["Range", _range];
	["DEBUG", _module, format["Box range: %1",_range], _debug] spawn EE_Scripts_fnc_debug;

	if (_activated) then
	{
		["DEBUG", _module, "Activated", _debug] spawn EE_Scripts_fnc_debug;
		if ( isNil "EE_Scripts_es_blacklist_item") then {	EE_Scripts_es_blacklist_item = [];};
		if ( isNil "EE_Scripts_es_blacklist_weapon") then {	EE_Scripts_es_blacklist_weapon = [];};
		if ( isNil "EE_Scripts_es_blacklist_backpack") then {	EE_Scripts_es_blacklist_backpack = [];};

	  //Spawn the right box for the right type
		private "_boxClassDefault";
		switch _type do
	  {
	    case "item":
	    {
	      _boxClassDefault = "Box_NATO_Support_F";
	    };
	    case "weapon":
	    {
	      if (_level <= (_level/2)) then
	      {
	        _boxClassDefault = "Box_NATO_Wps_F";
	      }else{
	        _boxClassDefault = "Box_NATO_WpsSpecial_F";
	      };
	    };
	    case "backpack":
	    {
	      _boxClassDefault = "B_supplyCrate_F";
	    };
	   };
	   _logic setVariable ["BoxClassDefault", _boxClassDefault];

		_logic setVariable ["LoadListItem", []];
		_logic setVariable ["LoadListWeapon", []];
		_logic setVariable ["LoadListBackpack", []];

		_box = [_logic] call EE_Scripts_fnc_spawnBox;

		[_logic] call EE_Scripts_fnc_es_fillBox;

		_serverFunction = {
			(_this select 3) remoteExec ["EE_Scripts_fnc_sa_loadEquipment", [0, 2] select isDedicated, true];
		};
		_addActionParams = ["Load to Arsenal", _serverFunction, _logic, 1.4, false, false, "", "[_target] call EE_Scripts_fnc_es_con_selectiveArsenalNear", 5];
		[_box, _addActionParams] remoteExec ["addAction", [0,-2] select isDedicated, true];
	};
};
true
