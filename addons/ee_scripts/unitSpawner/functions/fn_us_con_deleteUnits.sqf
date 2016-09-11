params ["_box"];
_nextRespawn = _box getVariable "NextRespawn";
_curUnits = _box getVariable "CurUnits";
_return = false;
if (_nextRespawn == 0) then
{
  if ((count _curUnits) > 0) then
  {
    _return = true;
  };
};
_return
