/**
 * ...
 * @author sirmax2
 */
import flash.geom.ColorTransform;
import flash.filters.DropShadowFilter;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Utils;

class wot.utils.GraphicsUtil
{
  public static function createShadowFilter(data:Object):Object
  {
    if (Number(data.alpha) == 0 || Number(data.strength) == 0)
      return null;

    var shadow: DropShadowFilter = new DropShadowFilter(Number(data.distance), Number(data.angle), Number(data.color),
      Number(data.alpha) * 0.01, Number(data.size), Number(data.size), Number(data.strength) * 0.01, 3);

    return shadow;
  }

  public static function fillRect(target:MovieClip, x:Number, y:Number,
    width: Number, height: Number, color: Number, alpha: Number)
  {
    target.moveTo(x, y);
    target.beginFill(color, alpha);
    target.lineTo(x + width, y);
    target.lineTo(x + width, y + height);
    target.lineTo(x, y + height);
    target.lineTo(x, y);
    target.endFill();
  }

  public static function drawGrid(target:MovieClip, x:Number, y:Number,
    width: Number, height: Number, color: Number, alpha: Number)
  {
    with (target)
    {
      clear();
      beginFill(0, 0);
      lineStyle(1, color, alpha);
      moveTo(0, y);
      lineTo(0, y + height);
      moveTo(x, 0);
      lineTo(x + width, 0);
      for (var i = x + x % 10; i <= x + width; i += 10)
      {
        moveTo(i, y + height / 2 - 2);
        lineTo(i, y + height / 2 + 2);
      }
      for (var i = y + y % 10; i <= y + width; i += 10)
      {
        moveTo(x + width / 2 - 2, i);
        lineTo(x + width / 2 + 2, i);
      }

      moveTo(0, 0);
      for (var i = x + x % 10; i <= x + width; i += 10)
      {
        for (var j = y + y % 10; j <= y + width; j += 10)
        {
          moveTo(i, j - 2);
          lineTo(i, j + 2);
          moveTo(i - 2, j);
          lineTo(i + 2, j);
        }
      }
      endFill();
      _x = 0;
      _y = 0;
      _alpha = 100;
      _visible = true;
    }
  }

  public static function colorByRatio($value:Number, $start:Number, $end:Number):Number
  {
    var r: Number = $start >> 16;
    var g: Number = ($start >> 8) & 0xff;
    var b: Number = $start & 0xff;
    var r2: Number = ($end >> 16) - r;
    var g2: Number = (($end >> 8) & 0xff) - g;
    var b2: Number = ($end & 0xff) - b;
    return ((r + ($value * r2)) << 16 | (g + ($value * g2)) << 8 | (b + ($value * b2)));
  }

  //method to set a specified movieClip(item:movidClip) to a specified color(col:hex value number)
  public static function setColor(item, col)
  {
    var myColorTransform: ColorTransform = new ColorTransform();
    myColorTransform.rgb = Number(col);
    item.transform.colorTransform = myColorTransform;
  }

  public static function MultiplyColor(color: Number, ratio: Number): Number
  {
     return ((((color >> 16) & 0xFF) * ratio) << 16) + ((((color >> 8) & 0xFF) * ratio) << 8) + ((color & 0xFF) * ratio);
  }
  
  public static function GetDynamicColorValue(type: Number, value: Number, prefix: String, darker: Boolean): String
  {
    if (!prefix)
      prefix = "#";

    if (value == undefined || value == null)
      return prefix + "FFFBFB";

    var cfg_root = Config.s_config.colors;
    var cfg: Array;
    switch (type)
    {
      case Defines.DYNAMIC_COLOR_EFF:
        cfg = cfg_root.eff;
        break;
      case Defines.DYNAMIC_COLOR_RATING:
        cfg = cfg_root.rating;
        break;
      case Defines.DYNAMIC_COLOR_KB:
        cfg = cfg_root.kb;
        break;
      case Defines.DYNAMIC_COLOR_HP:
        cfg = cfg_root.hp;
        break;
      case Defines.DYNAMIC_COLOR_HP_RATIO:
        cfg = cfg_root.hp_ratio;
        break;
      default:
        return prefix + "FFFEFE";
    }

    for (var i = 0; i < cfg.length; ++i)
    {
      var cvalue: Number = cfg[i].value;
      var color: Number = Utils.toInt(cfg[i].color, 0xFFFFFF);
      if (value < cvalue)
      {
        if (darker)
          color = GraphicsUtil.MultiplyColor(color, 0.5);
        return prefix + color.toString(16);
      }
    }

    return prefix + "FFFFFF";
  }

  public static function GetDynamicAlphaValue(type: Number, value: Number): Number
  {
    if (value == undefined || value == null)
      return 101;

    var cfg_root = Config.s_config.alpha;
    var cfg: Array;
    switch (type)
    {
      case Defines.DYNAMIC_ALPHA_EFF:
        cfg = cfg_root.eff;
        break;
      case Defines.DYNAMIC_ALPHA_RATING:
        cfg = cfg_root.rating;
        break;
      case Defines.DYNAMIC_ALPHA_KB:
        cfg = cfg_root.kb;
        break;
      case Defines.DYNAMIC_ALPHA_HP:
        cfg = cfg_root.hp;
        break;
      case Defines.DYNAMIC_ALPHA_HP_RATIO:
        cfg = cfg_root.hp_ratio;
        break;
      default:
        return 102;
    }

    for (var i = 0; i < cfg.length; ++i)
    {
      var avalue: Number = cfg[i].value;
      var alpha: Number = cfg[i].alpha;
      if (value < avalue)
        return alpha;
    }

    return 100;
  }
}
