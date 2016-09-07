params ["_logic"];

_type = _logic getVariable "Type";
_range = _logic getVariable "Range";
_box = _logic getVariable "Box";
_level = _logic getVariable "Level";

//Select the equipment config for the equipment type
private "_cfg";
switch _type do
{
	case "item":
  {
		_cfg = EE_Scripts_es_item;
	};
	case "weapon":
  {
		_cfg = EE_Scripts_es_weapon;
	};
	case "backpack":
  {
		_cfg = EE_Scripts_es_backpack;
	};
};

["DEBUG", "equipmentSpawner", format["Cfg levels: %1", count _cfg], EE_Scripts_es_debug] spawn EE_Scripts_fnc_debug;

//Calculate the minimum and maximum level vor the equipment selection
private ["_max", "_min"];
if (_range == 0) then {
  _max = _level;
  _min = _level;
}else{
  if ((_level + _range - 1) > ((count _cfg)-1)) then
  {
    _max = (count _cfg)-1;
  }else{
    _max = _level + _range;
  };

  if ((_level - _range) < 0) then
  {
    _min = 0;
  }else{
    _min = _level - _range;
  };
};


["DEBUG", "equipmentSpawner", format["Min level: %1", _min], EE_Scripts_es_debug] spawn EE_Scripts_fnc_debug;
["DEBUG", "equipmentSpawner", format["Max level: %1", _max], EE_Scripts_es_debug] spawn EE_Scripts_fnc_debug;

_pool = [_logic , _min, _max] call EE_Scripts_fnc_es_createPool;

_whitelist_item = [];
_whitelist_weapon = [];
_whitelist_backpack = [];
if (count _pool > 0) then
{
	["INFORMATION", "equipmentSpawner", format["Pool size: %1", count _pool], EE_Scripts_es_debug] spawn EE_Scripts_fnc_debug;
	_eqm = [_logic, _pool] call EE_Scripts_fnc_es_selectEquipment;
	if (!isNil {_eqm}) then
  {
		{
			["INFORMATION", "equipmentSpawner", format ["Selected equipment %2 %1", _x, _type], EE_Scripts_es_debug] spawn EE_Scripts_fnc_debug;
		  switch _type do
      {
		    case "item":
        {
		      _box addItemCargoGlobal[_x, 1];
          _whitelist_item pushBack _x;
		    };
		    case "weapon":
        {
		      _box addWeaponCargoGlobal[_x, 1];
          _whitelist_weapon pushBack _x;
		    };
		    case "backpack":
        {
		      _box addBackpackCargoGlobal[_x, 1];
          _whitelist_backpack pushBack _x;
		    };
		  };
		} forEach _eqm;
	};
};

_logic setVariable ["EE_Scripts_es_whitelist_item", _whitelist_item, true];
_logic setVariable ["EE_Scripts_es_whitelist_weapon", _whitelist_weapon, true];
_logic setVariable ["EE_Scripts_es_whitelist_backpack", _whitelist_backpack, true];
true
