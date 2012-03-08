/**
 * ...
 * @author sirmax2
 */
import wot.utils.Utils; 
 
// Convert OTMData.xml => XVM 1.1.0
class wot.utils.OTMConfigConverter
{
  private static var otm: Object;
  private static var xvm: Object;

  public static function convert(otm: Object)
  {
    OTMConfigConverter.otm = otm;
    xvm = {
      configVersion: "1.1.0",
      definition: { },
      battle: { },
      rating: { },
      markers: {
        ally:  { alive: { normal: { }, extended: { } }, dead: { normal: { }, extended: { } } },
        enemy: { alive: { normal: { }, extended: { } }, dead: { normal: { }, extended: { } } }
      }
    };
    xvm.configVersion = "1.0.0";

    xvm.definition.author = string("definition/author/data");
    xvm.definition.description = string("definition/description/data");
    xvm.definition.url = string("definition/mod-page/data");
    xvm.definition.date = string("definition/date/data");
    xvm.definition.gameVersion = string("definition/game-version/data");
    xvm.definition.modMinVersion = string("definition/mod-version-min/data");

    xvm.battle.showPostmortemTips = bool("battle/showPostmortemTips/data", true);
    xvm.battle.drawGrid = bool("battle/drawGrid/data");

    xvm.rating.showPlayersStatistics = bool("rating/showPlayersStatistics/data");

    ConvertComponents();
    ConvertBehavior();
    ConvertTextFields();

    return xvm;
  }

  public static function int(path: String, defaultValue: Number): Number
  {
    if (!otm)
      return undefined;
    if (!defaultValue)
      defaultValue = 0;
    var v = value(path);
    var n: Number = parseInt(v);
    return isNaN(n) ? defaultValue : n;
  }

  public static function bool(path: String, trueIsDefault: Boolean): Boolean
  {
    if (!otm)
      return undefined;
    var v = value(path).toLowerCase();
    return trueIsDefault ? v != "false" : v == "true";
  }

  public static function string(path: String, defaultValue: String): String
  {
    if (!otm)
      return undefined;
    var v = value(path);
    return v ? String(v) : defaultValue;
  }

  public static function value(path: String, convertFunc: Function)
  {
    if (!otm)
      return undefined;
    var p: Array = path.split("/"); // "path/to/value"
    var root = otm;
    for (var i = 0; i < p.length; i++)
    {
      if (!root.hasOwnProperty(p[i]))
        return undefined;
      root = root[p[i]];
    }
    return convertFunc ? convertFunc(root) : root;
  }

  public static function setValue(path: String, v)
  {
    var p: Array = path.split("/"); // "path/to/value"
    var root = xvm;
    for (var i = 0; i < p.length - 1; i++)
    {
      if (!root.hasOwnProperty(p[i]))
        root[p[i]] = { };
      root = root[p[i]];
    }
    root[p[p.length - 1]] = v;
  }

  private static function Copy(otmpath: String, xvmpath: String)
  {
    var v  = value(otmpath);
    if (v)
      setValue(xvmpath, v);
  }

  private static function CopyX(otmpath: String, xvmpaths: Array, xvmpath_suffix: String)
  {
    for (var i in xvmpaths)
    {
      var xvmpath = xvmpaths[i];
      Copy(otmpath, xvmpath_suffix ? xvmpath + "/" + xvmpath_suffix : xvmpath);
    }
  }

  // Components section

  private static var otmComponentsMap: Object = [
    [ "combatScrollText/enabled/attributes/value", "damageText/visible" ],
    [ "combatScrollText/speed/attributes/value", "damageText/speed" ],
    [ "combatScrollText/maxRange/attributes/value", "damageText/maxRange" ],
    [ "combatScrollText/textSize/attributes/value", "damageText/font/size" ],
    [ "combatScrollText/font/data", "damageText/font/name" ],
    // [ "combatScrollText/message", "" ], // Обрабатывается отдельно
    // [ "combatScrollText/prefix", "" ], // Обрабатывается отдельно
    // [ "combatScrollText/postfix", "" ], // Обрабатывается отдельно
    // [ "combatScrollText/hitKind", "" ], // Обрабатывается отдельно
    [ "combatScrollText/filter/attributes/size", "damageText/shadow/size" ],
    [ "combatScrollText/filter/attributes/angle", "damageText/shadow/angle" ],
    [ "combatScrollText/filter/attributes/distance", "damageText/shadow/distance" ],
    [ "combatScrollText/filter/attributes/color", "damageText/shadow/color" ],
    [ "combatScrollText/filter/attributes/alpha", "damageText/shadow/alpha" ],
    [ "combatScrollText/filter/attributes/strength", "damageText/shadow/strength" ],
    [ "contourIcon/tint/attributes/amount", "contourIcon/amount" ],
    [ "healthBar/border/attributes/size", "healthBar/border/size" ],
    [ "healthBar/border/attributes/color", "healthBar/border/color" ],
    [ "healthBar/border/attributes/alpha", "healthBar/border/alpha" ],
    [ "healthBar/fill/attributes/width", "healthBar/width" ],
    [ "healthBar/fill/attributes/height", "healthBar/height" ],
    [ "healthBar/fill/attributes/color", "healthBar/color" ],
    [ "healthBar/fill/attributes/lcolor", "healthBar/lcolor" ],
    [ "healthBar/fill/attributes/alpha", "healthBar/fill/alpha" ],
    [ "healthBar/damage/attributes/fade", "healthBar/damage/fade" ],
    [ "healthBar/damage/attributes/alpha", "healthBar/damage/alpha" ],
    [ "healthBar/damage/attributes/color", "healthBar/damage/color" ],
    // [ "vehicleIcon/fill", "" ], // TODO: what to do with it?
    [ "vehicleIcon/scale/attributes/maxScale", "vehicleIcon/maxScale" ],
    [ "vehicleIcon/scale/attributes/x", "vehicleIcon/scaleX" ],
    [ "vehicleIcon/scale/attributes/y", "vehicleIcon/scaleY" ]
  ];

  private static var xp_status_mode_ally: Array = [
    "markers/ally/alive/normal", "markers/ally/alive/extended", "markers/ally/dead/normal", "markers/ally/dead/extended"//,
    //"markers/squad/alive/normal", "markers/squad/alive/extended", "markers/squad/dead/normal", "markers/squad/dead/extended",
    //"markers/teamKiller/alive/normal", "markers/teamKiller/alive/extended", "markers/teamKiller/dead/normal", "markers/ally/dead/extended",
  ];

  private static var xp_status_mode_enemy: Array = [
    "markers/enemy/alive/normal", "markers/enemy/alive/extended", "markers/enemy/dead/normal", "markers/enemy/dead/extended"
  ];

  private static function ConvertComponents()
  {
    // components/friend/combatScrollText
    var carr = [ "friend", "enemy" ];
    for (var cid in carr)
    {
      var cname = carr[cid];
      var op: String = "components/" + cname + "/";
      var xp: Array = ((cname == "friend") ? xp_status_mode_ally : xp_status_mode_enemy);
      for (var mapId in otmComponentsMap)
      {
        var map = otmComponentsMap[mapId];
        CopyX(op + map[0], xp, map[1]);
      }

      // Convert combat scroll texts
      var cstPrefix: String = string(op + "combatScrollText/prefix/data");
      var cstPostfix: String = string(op + "combatScrollText/postfix/data");
      var cstHitKind: String = string(op + "combatScrollText/hitKind/data");
      var damageMessage: String = (cstHitKind && cstHitKind.toLowerCase() == "relative") ? "{{dmg-ratio}}" : "{{dmg}}";
      if (cstPrefix)
        damageMessage = cstPrefix + damageMessage;
      if (cstPostfix)
        damageMessage += cstPostfix;

      var blowupMessage: String = string(op + "combatScrollText/message/data");

      for (var i in xp)
      {
        var xvmpath = xp[i];
        setValue(xvmpath + "/damageText/damageMessage", damageMessage);
        setValue(xvmpath + "/damageText/blowupMessage", blowupMessage);
      }
    }
  }

  // Behavior section

  private static function ConvertBehavior()
  {
    var xp_ally: Array = [ "markers/ally"/*, "markers/squad", "markers/teamKiller"*/ ];
    var xp_enemy: Array = [ "markers/enemy" ];
    // behavior/friend/alive/normal/actionMarker/attributes
    for (var i1: String in otm["behavior"])
    {
      for (var i2: String in otm["behavior"][i1])
      {
        for (var i3: String in otm["behavior"][i1][i2])
        {
          for (var i4: String in otm["behavior"][i1][i2][i3])
          {
            if (i4 == "playerName" || i4 == "vehicleName" || i4 == "currentHealth" || i4 == "healthRatio" || i4 == "infoText")
              continue;
            var xname = i4;
            if (i4 == "combatScrollText")
              xname = "damageText";
            var op:String = "behavior/" + i1 + "/" + i2 + "/" + i3 + "/" + i4 + "/attributes/";
            var xp:Array = ((i1 == "friend") ? xp_ally : xp_enemy);
            for (var o:String in otm["behavior"][i1][i2][i3][i4]["attributes"])
              CopyX(op + o, xp, i2 + "/" + i3 + "/" + xname + "/" + o);
          }
        }
      }
    }
  }

  // Text fields section
  private static function GetTextField(team, mode, fieldName)
  {
    var ocp: String = "components/" + team + "/" + fieldName + "/";
    var obp: String = "behavior/" + team + "/" + mode + "/" + fieldName + "/attributes/";

    if (!bool(obp + "visible"))
      return null;

    var fieldText = "";
    var dx = 0;
    var dy = 0;
    var bold = false;
    switch (fieldName)
    {
      case "playerName":
        fieldText = "{{nick}}";
        dx = -70;
        dy = -16;
        break;
      case "vehicleName":
        fieldText = "{{vehicle}}";
        dx = -70;
        dy = -16;
        break;
      case "currentHealth":
        fieldText = bool(ocp + "maxValue/attributes/enabled", true) ? "{{hp}} / {{hp-max}}" : "{{hp}}";
        dx = -41;
        dy = -18;
        bold = true;
        break;
      case "healthRatio":
        fieldText = "{{hp-ratio}}%";
        dx = -41;
        dy = -18;
        bold = true;
        break;
    }

    return {
      visible: true,
      x: int(obp + "x", dx) - dx,
      y: int(obp + "y", dy) - dy,
      alpha: string(obp + "alpha", "100"),
      color: string(obp + "color", null),
      font: {
        name: string(ocp + "format/attributes/font", "$FieldFont"),
        size: int(ocp + "format/attributes/size", 13),
        align: string(ocp + "format/attributes/align", "center"),
        bold: bool(ocp + "format/attributes/bold", bold)
      },
      shadow: {
        alpha: string(ocp + "filter/attributes/alpha", "100"),
        color: string(ocp + "filter/attributes/color", "0x000000"),
        angle: int(ocp + "filter/attributes/angle", 45),
        strength: int(ocp + "filter/attributes/strength", 120),
        distance: int(ocp + "filter/attributes/distance", 0),
        size: int(ocp + "filter/attributes/size", 3)
      },
      format: fieldText
    };
  }

  private static function GetInfoTextField(infoText, ocp)
  {
    if (!infoText || !infoText.attributes || !infoText.attributes.visible || !Utils.toBool(infoText.attributes.visible, false))
      return null;

    return {
      visible: true,
      x: Number(infoText.attributes.x) || 0,
      y: Number(infoText.attributes.y) || 0,
      alpha: String(infoText.attributes.alpha) || "100",
      color: String(infoText.attributes.color) || null,
      font: {
        name: string(ocp + "format/attributes/font", "$FieldFont"),
        size: int(ocp + "format/attributes/size", 13),
        align: string(ocp + "format/attributes/align", "center"),
        bold: Boolean(infoText.attributes.bold)
      },
      shadow: {
        alpha: string(ocp + "filter/attributes/alpha", "100"),
        color: string(ocp + "filter/attributes/color", "0x000000"),
        angle: int(ocp + "filter/attributes/angle", 45),
        strength: int(ocp + "filter/attributes/strength", 120),
        distance: int(ocp + "filter/attributes/distance", 0),
        size: int(ocp + "filter/attributes/size", 3)
      },
      format: String(infoText.attributes.format) || ""
    };
  }

  private static function GetInfoTextFields(team, mode)
  {
    var ocp: String = "components/" + team + "/infoText/";
    var obp: String = "behavior/" + team + "/" + mode + "/infoText";

    var infoText = value(obp);
    var textFields = [];
    if (infoText instanceof Array)
    {
      for (var i in infoText)
      {
        var f = GetInfoTextField(infoText[i], ocp);
        if (f && f.format != "")
          textFields.push(f);
      }
    }
    else
    {
      var f = GetInfoTextField(infoText, ocp);
      if (f)
        textFields.push(f);
    };

    return textFields;
  }

  private static function ConvertTextFields()
  {
    var carr = [ "friend", "enemy" ];
    var barr = [ "alive/normal", "alive/extended", "dead/normal", "dead/extended" ];
    var farr = [ "playerName", "vehicleName", "currentHealth", "healthRatio", "infoText" ];

    for (var cid in carr)
    {
      var cname = carr[cid];
      var xname = (cname == "friend") ? "ally" : "enemy";
      for (var bid in barr)
      {
        var bname = barr[bid];
        var fields: Array = [ ];
        for (var fid in farr)
        {
          var fname = farr[fid];
          //wot.utils.Logger.add("ConvertTextFields: " + cname + ", " + bname + ", " + fname);
          var field = GetTextField(cname, bname, fname);
          if (field)
            fields.push(field);
          //wot.utils.Logger.add("ConvertTextFields: " + cname + ", " + bname + ", " + fname + " - done");
        }
        var infoTextFields = GetInfoTextFields(cname, bname);
        for (var i in infoTextFields)
          fields.push(infoTextFields[i]);
        //wot.utils.Logger.add("markers/" + xname + "/" + bname + "/textFields = " + fields.length)
        setValue("markers/" + xname + "/" + bname + "/textFields", fields);
      }
    }
  }
}
