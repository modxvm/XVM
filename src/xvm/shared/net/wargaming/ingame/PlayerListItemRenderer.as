import gfx.core.UIComponent;
intrinsic class net.wargaming.ingame.PlayerListItemRenderer extends gfx.core.UIComponent
{
  var vehicleLevel: MovieClip;
  var iconLoader: net.wargaming.controls.UILoaderAlt;
  var owner: Object;
  var data: Object;
  var squadIcon: MovieClip;
  var visibility;
  var bg:UIComponent;

  function __getColorTransform(schemeName);
  function get selected();

  function setData(data);
  function setState();
  function update();
  function invalidate();
  
  function dispatchLightPlayer(visibility);
}
