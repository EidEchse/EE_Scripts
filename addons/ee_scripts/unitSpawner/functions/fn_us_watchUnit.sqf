if (isServer) then {
  params ["_logic", "_unit"];
  _module = _logic getVariable "Module";
  _debug = _logic getVariable "Debug";

  _skill = _logic getVariable "Skill";
  _units = _logic getVariable "Units";

  _respawn = _logic getVariable "Respawn";
  _box = _logic getVariable "Box";
  _count = _logic getVariable "Count";

  /*if (_gou == "_unit") then {*/
    waitUntil ({!alive _unit;});
  /*}else{
    waitUntil (
      {
        _return = true;
        {
          if (alive _x) then {
              _return = false;
          };
        } forEach (units _unit);
        _return;
      });
  };*/

  _deleteUnits = _logic getVariable ["DeleteUnits", false];
  if (!_deleteUnits) then {
    _curUnits = _box getVariable "CurUnits";
    _box setVariable ["CurUnits", _curUnits - [_unit], true];
    _title = "<t color='#ffffff' size='1.2' align='center'>R.I.P.</t><br />";
    _footer = "<t color='#ffffff' size='1.0' align='center'>" + (name _unit) + "</t>";
    (parseText (_title + _footer)) remoteExec ["hint", [0,-2] select isDedicated];

    _i = floor _respawn;
    while{_i > 0} do
    {
      _nextRespawn = _box getVariable "NextRespawn";
      if ((_i <  _nextRespawn) or (_nextRespawn == 0)) then
      {
        _nextRespawn = _i;
        _box setVariable ["NextRespawn", _nextRespawn, true];
      };
      if (((_nextRespawn mod 10) == 0) or ((floor _respawn) == _nextRespawn)) then {
        (format["Next spawn available in %1 minutes.", _nextRespawn]) remoteExec ["systemChat", [0,-2] select isDedicated];
        [_logic] spawn EE_Scripts_fnc_us_createActions;
      };
      sleep 60;
      waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
      _i = _i - 1;
    };

    _box setVariable ["NextRespawn", 0, true];
    _curCount = _box getVariable "CurCount";
    _curCount = _curCount + 1;
    _box setVariable ["CurCount", _curCount, true];

    _title = "<t color='#ffffff' size='1.2' align='center'>BOX INFORMATION</t><br />";
    _curCount = "<t color='#ffffff' size='1.0' align='left'>Available: " + (str _curCount) + "/" + (str _count) + "</t><br />";
    _skillText = "<t color='#ffffff' size='1.0' align='left'>Skill: " + (str _skill) + "</t><br />";
    _location = nearestLocation [_position, ""];
    _locationText = "<t color='#ffffff' size='1.0' align='center'>Location: " + (className _location) + "</t><br />";
    _unitsText = "<t color='#ffffff' size='1.0' align='center'>Units:</t><br />";
    _text = _title + _curCount + _skillText + _locationText + _unitsText;
    _units = _units splitString " ,;";
    {
      _text = _text + "<t color='#ffffff' size='1.0' align='center'>" + getText (configfile >> "CfgVehicles" >> _x >> "displayName") + "</t><br />";
    } forEach _units;
    (parseText _text) remoteExec ["hint", [0,-2] select isDedicated];
    [_logic] spawn EE_Scripts_fnc_us_createActions;
  };
};
true
