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
	if (!isNil "EE_Scripts_ra_debug") then {
		_debug = EE_Scripts_ra_debug;
	};
	_logic setVariable ["Module", _module];
	_logic setVariable ["Debug", _debug];

	_reloading = _logic getVariable ["Reloading", "B_Slingload_01_Ammo_F"];
	_logic setVariable ["Reloading", _reloading];

	_distance = _logic getVariable ["Distance", 2];
	if (_distance < 2) then
	{
		["WARNING", _module, "Distance under 2m set to 2m", _debug] spawn EE_Scripts_fnc_debug;
	};
	_logic setVariable ["Distance", _distance];

	_time = _logic getVariable ["Time", 0];
	_logic setVariable ["Time", _time];
	_magazines = _logic getVariable ["Magazines", ""];
	_logic setVariable ["Magazines", _magazines];
	_items = _logic getVariable ["Items", ""];
	_logic setVariable ["Items", _items];

	if (_activated) then
	{
		["INFORMATION", _module, "Activated",  _debug] spawn EE_Scripts_fnc_debug;
		_cfgs = [];
		_load = [_items, _magazines];
		["DEBUG", _module, format ["Load: %1", str _load], _debug] spawn EE_Scripts_fnc_debug;
		for [{_i=0},{_i <= 1},{_i=_i+1}] do
		{
			_cfg = _load select _i;
			_nameList = [];
			_countList = [];
			if ( _cfg != "") then
			{
				{
					_couple = _x splitString ":|";
					if ((count _couple) > 1) then
					{
						_nameList pushBack (_couple select 0);
						_countList pushBack (parseNumber (_couple select 1));
					}else{
						_nameList pushBack (_couple select 0);
						_countList pushBack (1);
					};
				} forEach (_cfg splitString ",; ");
			};
			_cfgs set [_i, [_nameList, _countList]];
		};
		["INFORMATION", _module, format ["Loading equipment from logic: %1", str _cfgs], _debug] spawn EE_Scripts_fnc_debug;

		_logic setVariable ["BoxClassDefault", "Box_NATO_Ammo_F"];
		[_logic] call EE_SCripts_fnc_spawnBox;
		[_logic, _cfgs] spawn EE_Scripts_fnc_ra_reloadAmmobox;
	};
};
true
