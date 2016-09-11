params ["_box"];
_nextRespawn = _box getVariable "NextRespawn";
_return = false;
if (_nextRespawn > 0) then
{
  _return = true;
};
_return
