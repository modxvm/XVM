/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import flash.filters.DropShadowFilter;

class wot.BattleLoading extends net.wargaming.BattleLoading
{
  public static var infoField = null;

  function BattleLoading()
  {
    super();
    Config.LoadConfig();

    if (!infoField)
    {
      infoField = this.createTextField("info", getNextHighestDepth(), 0, 0, 140, 31);
      infoField.wordWrap = true;
      var textFormat: TextFormat = new TextFormat("$FieldFont", 12, 0x000000, true, false, false, null, null, "left");
      infoField.setNewTextFormat(textFormat);
      
      var shadow: DropShadowFilter = new DropShadowFilter();
      shadow.blurX = shadow.blurY = 3;
      shadow.angle = 0;
      shadow.distance = 0;
      shadow.color = 0x000000;
      shadow.alpha = 100;
      shadow.strength = 1;
      infoField.filters = [shadow];

      infoField.textColor = 0xFFFFFF;
      infoField._x = _width / 2;
      infoField._y = 0;
      infoField._height = 100;
      infoField._width = 500;
      infoField._alpha = 100;
      infoField._visible = true;
    }
  }

  public static function setInfoFieldData(data)
  {
    if (!infoField)
      return;

    var txt: String = "XVM v" + wot.utils.Defines.XVM_VERSION + "\n";

    if (data.ver && (String(data.ver) != wot.utils.Defines.XVM_VERSION))
    {
      txt += "New version available: " + String(data.ver) + "\n";
      if (data.message)
        txt += data.message + "\n";
      infoField.textColor = 0xAAFFAA;
    }

    infoField.text = txt;
  }
}
