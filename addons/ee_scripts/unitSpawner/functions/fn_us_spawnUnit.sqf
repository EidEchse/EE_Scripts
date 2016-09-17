if (isServer) then {
  params ["_logic", "_cfg", "_caller"];
  _module = _logic getVariable "Module";
  _debug = _logic getVariable "Debug";

  _box = _logic getVariable "Box";
  _skill = _logic getVariable "Skill";
  _type = _logic getVariable "Type";

  _units = [];
  if (_type == "group") then {
    private "_group";
    _side = getNumber (_cfg >> "side");
    switch (_side) do {
      case 0: {
        _group = createGroup east;
      };
      case 1: {
        _group = createGroup west;
      };
      case 2: {
        _group = createGroup resistance;
      };
    };
    if (!isNil "_group") then {
      _cfgUnits = "true" configClasses _cfg;
      {
        _rank = getText (_x >> "rank");
        _cfgPos = getArray (_x >> "position");
        _boxPos = position _box;
        _position = [((_cfgPos select 0) + (_boxPos select 0)), ((_cfgPos select 1) + (_boxPos select 1)), ((_cfgPos select 2) + (_boxPos select 2))];
        _unit = _group createUnit [(getText (_x >> "vehicle")), _position, [], 0, "FORM"];
        _unit setUnitRank _rank;
        _units pushBack _unit;
      } forEach _cfgUnits;
      (hcLeader (group _caller)) hcSetGroup [_group];
    };
  }else{
    _group = group _caller;
    _unit = _group createUnit [configName _cfg, position _box, [], 0, "FORM"];
    _units pushBack _unit;
  };

  {
    _x setVariable ["ALIVE_profileIgnore", true];
    _x setSkill _skill;
  } forEach _units;

  _logic setVariable ["DeleteUnits", false];
  _curCount = _box getVariable "CurCount";
  _box setVariable ["CurCount", (_curCount - 1), true];
  _curUnits = _box getVariable "CurUnits";
  _curUnits pushback _units;
  _box setVariable ["CurUnits", _curUnits, true];
  _logic remoteExec ["EE_Scripts_fnc_us_createActions", [0,-2] select isDedicated, true];
  [_logic, _units] spawn EE_Scripts_fnc_us_watchUnit;
};
true
