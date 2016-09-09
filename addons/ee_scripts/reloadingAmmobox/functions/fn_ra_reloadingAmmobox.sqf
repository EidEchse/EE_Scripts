if (isServer) then {
	// Argument 0 is module logic.
	_logic = param [0,objNull,[objNull]];
	// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
	_units = param [1,[],[[]]];
	// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
	_activated = param [2,true,[true]];

	if (isNil {EE_Scripts_ra_debug}) then {	EE_Scripts_ra_debug = "WARNING";};
	publicVariable "EE_Scripts_ra_debug";

	_reloading = _logic getVariable ["Reloading", "B_Slingload_01_Ammo_F"];
	_logic setVariable ["Reloading", _reloading, true];

	_distance = _logic getVariable ["Distance", 2];
	if (_distance < 2) then
	{
		["WARNING", "reloadingAmmobox", "Distance under 2m set to 2m", EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
	};
	_logic setVariable ["Distance", _distance, true];

	_time = _logic getVariable ["Time", 0];
	_logic setVariable ["Time", _time, true];
	_magazines = _logic getVariable ["Magazines", ""];
	_logic setVariable ["Magazines", _magazines, true];
	_items = _logic getVariable ["Items", ""];
	_logic setVariable ["Items", _items, true];

	if (_activated) then
	{
		["INFORMATION", "reloadingAmmobox", "Activated",  EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
		_cfgs = [];
		_load = [_items, _magazines];
		["DEBUG", "reloadingAmmobox", format ["Load: %1", str _load], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;
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
		["INFORMATION", "reloadingAmmobox", format ["Loading equipment from logic: %1", str _cfgs], EE_Scripts_ra_debug] spawn EE_Scripts_fnc_debug;

		["unitSpawner", _logic, "Box_NATO_Ammo_F"] call EE_SCripts_fnc_spawnBox;
		[_logic, _cfgs] call EE_Scripts_fnc_ra_reloadAmmobox;
	};
};
true
