if (isServer) then {
  params ["_logic", "_units"];
  _module = _logic getVariable "Module";
  _debug = _logic getVariable "Debug";

  _skill = _logic getVariable "Skill";

  _respawn = _logic getVariable "Respawn";
  _box = _logic getVariable "Box";
  _count = _logic getVariable "Count";
  _type = _logic getVariable "Type";
  _cfgs = _logic getVariable "Cfgs";

  _names = [];
  {
    _names pushBack (name _x);
  } forEach _units;

  _alive = true;
  while {_alive} do {
    sleep 1;
    _alive = false;
    {
      if (alive _x) then {
        _alive = true;
      };
    } forEach _units;
  };

  _deleteUnits = _logic getVariable ["DeleteUnits", false];
  if (!_deleteUnits) then {
    _curUnits = _box getVariable "CurUnits";
    _box setVariable ["CurUnits", _curUnits - _units, true];
    _title = "<t color='#ffffff' size='1.2' align='center'>R.I.P.</t><br />";
    _footer = "";
    {
      _footer = _footer + "<t color='#ffffff' size='1.0' align='center'>" + _x + "</t><br />";
    } forEach _names;
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
        _logic remoteExec ["EE_Scripts_fnc_us_createActions", [0,-2] select isDedicated, true];
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
    _location = nearestLocation [position _box, ""];
    _locationText = "<t color='#ffffff' size='1.0' align='left'>Location: " + (className _location) + "</t><br />";
    _unitsTitel = "<t color='#ffffff' size='1.0' align='center'>Units:</t><br />";
    _unitText = "";
    {
      private "_displayName";
      if (_type == "group") then {
        _displayName = getText (_x >> "name");
      }else{
        _displayName = getText (_x >> "displayName");
      };
      _unitText = _unitText + "<t color='#ffffff' size='1.0' align='center'>" + _displayName + "</t><br />";
    } forEach _cfgs;
    _text = _title + _curCount + _skillText + _locationText + _unitsTitel + _unitText;
    (parseText _text) remoteExec ["hint", [0,-2] select isDedicated];
    _logic remoteExec ["EE_Scripts_fnc_us_createActions", [0,-2] select isDedicated, true];
  };
};
true
