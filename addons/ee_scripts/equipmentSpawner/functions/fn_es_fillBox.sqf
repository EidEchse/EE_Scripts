params ["_logic", "_box", "_type", "_level", "_range"];

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

if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Cfg levels: %1", count _cfg]};

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

if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Min level: %1",_min]};
if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Max level: %1",_max]};

_pool = [_min, _max, _type] call EE_Scripts_fnc_es_createPool;

_whitelist_item = [];
_whitelist_weapon = [];
_whitelist_backpack = [];
if (count _pool > 0) then
{
	if (EE_Scripts_es_debug) then {systemChat format["DEBUG: equipmentSpawner: Pool size: %1",count _pool]};
	_eqm = [_pool, _type] call EE_Scripts_fnc_es_selectEquipment;
	if (!isNil {_eqm}) then
  {
		{
		  if (EE_Scripts_es_debug) then {systemChat format ["Selected equipment %1 type %2", _x, _type]};
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
_logic setVariable ["EE_Scripts_es_bwhitelist_backpack", _whitelist_backpack, true];
true
