import net.wargaming.controls.UILoaderAlt;
import gfx.core.UIComponent;

intrinsic class net.wargaming.controls.LobbyPlayerListItemRenderer extends UIComponent // net.wargaming.controls.TextFieldShort
{
  var data: Object;
  var iconLoader: UILoaderAlt;
  var owner: Object;
  var vehicleField: TextField;
  var textField: TextField;
  var squad;
  var self_bg;

  function get disabled();
  function get selected();

  function configUI();
  function setData(data);
  function setState();
  function update();
}
