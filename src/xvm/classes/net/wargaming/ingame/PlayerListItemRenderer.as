intrinsic class net.wargaming.ingame.PlayerListItemRenderer extends gfx.core.UIComponent
{
  var vehicleLevel: MovieClip;
  var iconLoader: net.wargaming.controls.UILoaderAlt;
  var owner: Object;
  var data: Object;
  var squadIcon: MovieClip;

  function setData(data);
  function update();
  function invalidate();
}
