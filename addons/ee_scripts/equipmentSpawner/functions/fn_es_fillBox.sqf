params ["_logic"];

_type = _logic getVariable ["Type","weapon"]; //Type of equipment
if (EE_Scripts_es_debug) then {systemChat format["Box type: %1",_type]};
_logic setVariable ["Type", _type, true];
_level = _logic getVariable ["Level",25]; //Level of the box
if (EE_Scripts_es_debug) then {systemChat format["Box level: %1",_level]};
_logic setVariable ["Level", _level, true];
_range = _logic getVariable ["Range",5]; //Range for leveled Eqipment selection
if (EE_Scripts_es_debug) then {systemChat format["Box range: %1",_range]};
_logic setVariable ["Range", _range, true];


private ["_box"];
_box = _logic getVariable "Box";
if (isNil {_box}) then {
  //Spawn the right box for the right type
  switch _type do {
    case "item": {
      _box = "Box_NATO_Support_F" createVehicle position _logic;
    };
    case "weapon": {
      if (_level <= 30) then {
        _box = "Box_NATO_Wps_F" createVehicle position _logic;
      }else{
        _box = "Box_NATO_WpsSpecial_F" createVehicle position _logic;
      };
    };
    case "backpack": {
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

//Select the equipment config for the equipment type
private "_cfg";
switch _type do {
	case "item": {
		_cfg = EE_Scripts_es_item;
	};
	case "weapon": {
		_cfg = EE_Scripts_es_weapon;
	};
	case "backpack": {
		_cfg = EE_Scripts_es_backpack;
	};
};

if (EE_Scripts_es_debug) then {systemChat format["Cfg levels: %1", count _cfg]};

//Calculate the minimum and maximum level vor the equipment selection
private ["_max", "_min"];
if ((_level + _range) > ((count _cfg)-1)) then {
  _max = (count _cfg)-1;
}else{
  _max = _level + _range;
};

if ((_level - _range) < 0) then {
  _min = 0;
}else{
  _min = _level - _range;
};
if (EE_Scripts_es_debug) then {systemChat format["Min level: %1",_min]};
if (EE_Scripts_es_debug) then {systemChat format["Max level: %1",_max]};

_pool = [_min, _max, _type] call EE_Scripts_fnc_es_createPool;
if (count _pool > 0) then {
	if (EE_Scripts_es_debug) then {systemChat format["Pool size: %1",count _pool]};
	_eqm = [_pool, _type] call EE_Scripts_fnc_es_selectEquipment;
	if (!isNil {_eqm}) then {
		{
		  if (EE_Scripts_es_debug) then {systemChat format ["Selected equipment %1 type %2", _x, _type]};
		  switch _type do {
		    case "item": {
		      _box addItemCargoGlobal[_x,1];
		    };
		    case "weapon": {
		      _box addWeaponCargoGlobal[_x,1];
		    };
		    case "backpack": {
		      _box addBackpackCargoGlobal[_x,1];
		    };
		  };
		} forEach _eqm;
	};
};
true
