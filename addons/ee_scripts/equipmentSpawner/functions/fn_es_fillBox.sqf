params ["_logic"];
_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_type = _logic getVariable "Type";
_range = _logic getVariable "Range";
_box = _logic getVariable "Box";
_level = _logic getVariable "Level";

_loadListItem = _logic getVariable "LoadListItem";
_loadListWeapon = _logic getVariable "LoadListWeapon";
_loadListBackpack = _logic getVariable "LoadListBackpack";

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

["DEBUG", _module, format["Cfg levels: %1", count _cfg], _debug] spawn EE_Scripts_fnc_debug;

//Calculate the minimum and maximum level vor the equipment selection
private ["_max", "_min"];
if (_range == 0) then {
  _max = _level;
  _min = _level;
}else{
  if ((_level + _range - 1) > ((count _cfg)-1)) then
  {
    _max = (count _cfg) - 1;
  }else{
    _max = _level + _range - 1;
  };

  if ((_level - _range) < 0) then
  {
    _min = 0;
  }else{
    _min = _level - _range;
  };
};

["DEBUG", _module, format["Min level: %1", _min], _debug] spawn EE_Scripts_fnc_debug;
["DEBUG", _module, format["Max level: %1", _max], _debug] spawn EE_Scripts_fnc_debug;

_pool = [_logic , _min, _max] call EE_Scripts_fnc_es_createPool;

if (count _pool > 0) then
{
	["INFORMATION", _module, format["Pool size: %1", count _pool], _debug] spawn EE_Scripts_fnc_debug;
	_eqm = [_logic, _pool] call EE_Scripts_fnc_es_selectEquipment;
	if (!isNil {_eqm}) then
  {
		{
			["INFORMATION", _module, format ["Selected equipment %2 %1", _x, _type], _debug] spawn EE_Scripts_fnc_debug;
		  switch _type do
      {
		    case "item":
        {
		      _box addItemCargoGlobal[_x, 1];
          _loadListItem pushBack _x;
		    };
		    case "weapon":
        {
		      _box addWeaponCargoGlobal[_x, 1];
          _loadListWeapon pushBack _x;
		    };
		    case "backpack":
        {
		      _box addBackpackCargoGlobal[_x, 1];
          _loadListBackpack pushBack _x;
		    };
		  };
		} forEach _eqm;
	};
};

_logic setVariable ["LoadListItem", _loadListItem];
_logic setVariable ["LoadListWeapon", _loadListWeapon];
_logic setVariable ["LoadListBackpack", _loadListBackpack];
true
