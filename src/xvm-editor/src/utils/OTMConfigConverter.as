/**
 * ...
 * @author sirmax2
 */
package utils
{
  import utils.Utils;

  // Convert OTMData.xml => XVM 1.1.0
  public class OTMConfigConverter
  {
    private static var otm: *;
    private static var xvm: *;

    public static function convert(otm:*):*
    {
      OTMConfigConverter.otm = otm;
      xvm = {
        configVersion: "1.0.0",
        definition: { },
        battle: { },
        rating: { },
        markers: {
          ally:  { alive: { normal: { }, extended: { } }, dead: { normal: { }, extended: { } } },
          enemy: { alive: { normal: { }, extended: { } }, dead: { normal: { }, extended: { } } }
        }
      };

      xvm.definition.author = string("definition/author");
      xvm.definition.description = string("definition/description");
      xvm.definition.url = string("definition/mod-page");
      xvm.definition.date = string("definition/date");
      xvm.definition.gameVersion = string("definition/game-version");
      xvm.definition.modMinVersion = string("definition/mod-version-min");

      xvm.battle.showPostmortemTips = bool("battle/showPostmortemTips", true);

      xvm.rating.showPlayersStatistics = bool("rating/showPlayersStatistics");

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
      var v:* = value(path);
      var n: Number = parseInt(v);
      return isNaN(n) ? defaultValue : n;
    }

    public static function bool(path: String, defaultValue: Boolean = false): Boolean
    {
      if (!otm)
        return undefined;
      var v:* = value(path);
	  if (!v)
		  return defaultValue;
	  if (v is Boolean)
		  return v;
	  if (v is String)
	  {
	    v = v.toLowerCase();
        return defaultValue ? v != "false" : v == "true";
	  }
	  return defaultValue;
    }

    public static function string(path: String, defaultValue: String = null): String
    {
      if (!otm)
        return undefined;
      var v:* = value(path);
      return v ? String(v) : defaultValue;
    }

    public static function value(path: String, convertFunc: Function = null):*
    {
      if (!otm)
        return undefined;
      var p: Array = path.split("/"); // "path/to/value"
      var root:* = otm;
      for (var i:Number = 0; i < p.length; ++i)
      {
        if (!root.hasOwnProperty(p[i]))
          return undefined;
        root = root[p[i]];
      }
      return (convertFunc != null) ? convertFunc(root) : root;
    }

    public static function setValue(path: String, v:*):void
    {
      var p: Array = path.split("/"); // "path/to/value"
      var root:* = xvm;
      for (var i:Number = 0; i < p.length - 1; ++i)
      {
        if (!root.hasOwnProperty(p[i]))
          root[p[i]] = { };
        root = root[p[i]];
      }
      root[p[p.length - 1]] = v;
    }

    private static function Copy(otmpath: String, xvmpath: String):void
    {
      var v:*  = value(otmpath);
      if (v)
        setValue(xvmpath, v);
    }

    private static function CopyX(otmpath: String, xvmpaths: Array, xvmpath_suffix: String):void
    {
      for each (var xvmpath:String in xvmpaths)
        Copy(otmpath, xvmpath_suffix ? xvmpath + "/" + xvmpath_suffix : xvmpath);
    }

    // Components section

    private static var otmComponentsMap:Array = [
      [ "combatScrollText/enabled/value/1", "damageText/visible" ],
      [ "combatScrollText/speed/value/1", "damageText/speed" ],
      [ "combatScrollText/color/value/1", "damageText/color" ],
      [ "combatScrollText/maxRange/value/1", "damageText/maxRange" ],
      [ "combatScrollText/textSize/value/1", "damageText/font/size" ],
      [ "combatScrollText/font", "damageText/font/name" ],
      // [ "combatScrollText/message", "" ], // Обрабатывается отдельно
      // [ "combatScrollText/prefix", "" ], // Обрабатывается отдельно
      // [ "combatScrollText/postfix", "" ], // Обрабатывается отдельно
      // [ "combatScrollText/hitKind", "" ], // Обрабатывается отдельно
      [ "combatScrollText/filter/size", "damageText/shadow/size" ],
      [ "combatScrollText/filter/angle", "damageText/shadow/angle" ],
      [ "combatScrollText/filter/distance", "damageText/shadow/distance" ],
      [ "combatScrollText/filter/color", "damageText/shadow/color" ],
      [ "combatScrollText/filter/alpha", "damageText/shadow/alpha" ],
      [ "combatScrollText/filter/strength", "damageText/shadow/strength" ],
      [ "contourIcon/tint/amount", "contourIcon/amount" ],
      [ "contourIcon/tint/color", "contourIcon/color" ],
      [ "healthBar/border/size", "healthBar/border/size" ],
      [ "healthBar/border/color", "healthBar/border/color" ],
      [ "healthBar/border/alpha", "healthBar/border/alpha" ],
      [ "healthBar/fill/width", "healthBar/width" ],
      [ "healthBar/fill/height", "healthBar/height" ],
      [ "healthBar/fill/color", "healthBar/color" ],
      [ "healthBar/fill/lcolor", "healthBar/lcolor" ],
      [ "healthBar/fill/alpha", "healthBar/fill/alpha" ],
      [ "healthBar/damage/fade", "healthBar/damage/fade" ],
      [ "healthBar/damage/alpha", "healthBar/damage/alpha" ],
      [ "healthBar/damage/color", "healthBar/damage/color" ],
      // [ "vehicleIcon/fill", "" ], // TODO: what to do with it?
      [ "vehicleIcon/scale/maxScale", "vehicleIcon/maxScale" ],
      [ "vehicleIcon/scale/x", "vehicleIcon/scaleX" ],
      [ "vehicleIcon/scale/y", "vehicleIcon/scaleY" ]
    ];

    private static var xp_status_mode_ally:Array = [
      "markers/ally/alive/normal", "markers/ally/alive/extended", "markers/ally/dead/normal", "markers/ally/dead/extended"//,
      //"markers/squad/alive/normal", "markers/squad/alive/extended", "markers/squad/dead/normal", "markers/squad/dead/extended",
      //"markers/teamKiller/alive/normal", "markers/teamKiller/alive/extended", "markers/teamKiller/dead/normal", "markers/ally/dead/extended",
    ];

    private static var xp_status_mode_enemy:Array = [
      "markers/enemy/alive/normal", "markers/enemy/alive/extended", "markers/enemy/dead/normal", "markers/enemy/dead/extended"
    ];

    private static function ConvertComponents():void
    {
      // components/friend/combatScrollText
      var carr:Array = [ "friend", "enemy" ];
      for each (var cname:String in carr)
      {
        var op: String = "components/" + cname + "/";
        var xp: Array = ((cname == "friend") ? xp_status_mode_ally : xp_status_mode_enemy);
        for each (var map:Array in otmComponentsMap)
          CopyX(op + map[0], xp, map[1]);

		// Convert combat scroll texts
        var cstPrefix: String = string(op + "combatScrollText/prefix");
        var cstPostfix: String = string(op + "combatScrollText/postfix");
        var cstHitKind: String = string(op + "combatScrollText/hitKind");
        var damageMessage: String = (cstHitKind && cstHitKind.toLowerCase() == "relative") ? "{{dmg-ratio}}" : "{{dmg}}";
        if (cstPrefix)
          damageMessage = cstPrefix + damageMessage;
        if (cstPostfix)
          damageMessage += cstPostfix;

        var blowupMessage: String = string(op + "combatScrollText/message");

        for each (var xvmpath:String in xp)
        {
          setValue(xvmpath + "/damageText/damageMessage", damageMessage);
          setValue(xvmpath + "/damageText/blowupMessage", blowupMessage);
        }
      }
    }

    // Behavior section

    private static function ConvertBehavior():void
    {
      var xp_ally: Array = [ "markers/ally"/*, "markers/squad", "markers/teamKiller"*/ ];
      var xp_enemy: Array = [ "markers/enemy" ];
      // behavior/friend/alive/normal/actionMarker
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
              var xname:String = i4;
              if (i4 == "combatScrollText")
                xname = "damageText";
              var op:String = "behavior/" + i1 + "/" + i2 + "/" + i3 + "/" + i4 + "/";
              var xp:Array = ((i1 == "friend") ? xp_ally : xp_enemy);
              for (var o:String in otm["behavior"][i1][i2][i3][i4])
                CopyX(op + o, xp, i2 + "/" + i3 + "/" + xname + "/" + o);
            }
          }
        }
      }
    }

    // Text fields section
    private static function GetTextField(team: String, mode: String, fieldName: String):*
    {
      var ocp: String = "components/" + team + "/" + fieldName + "/";
      var obp: String = "behavior/" + team + "/" + mode + "/" + fieldName + "/";

      if (!bool(obp + "visible"))
        return null;

      var fieldText:String = "";
      var dx:Number = 0;
      var dy:Number = 0;
      var bold:Boolean = false;
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
          fieldText = bool(ocp + "maxValue/enabled", true) ? "{{hp}} / {{hp-max}}" : "{{hp}}";
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
          name: string(ocp + "format/font", "$FieldFont"),
          size: int(ocp + "format/size", 13),
          align: string(ocp + "format/align", "center"),
          bold: bool(ocp + "format/bold", bold)
        },
        shadow: {
          alpha: string(ocp + "filter/alpha", "100"),
          color: string(ocp + "filter/color", "0x000000"),
          angle: int(ocp + "filter/angle", 45),
          strength: int(ocp + "filter/strength", 120),
          distance: int(ocp + "filter/distance", 0),
          size: int(ocp + "filter/size", 3)
        },
        format: fieldText
      };
    }

    private static function GetInfoTextField(infoText:*, ocp:String):*
    {
      if (!infoText || !infoText.visible || !Utils.toBool(infoText.visible, false))
        return null;

      return {
        visible: true,
        x: Number(infoText.x) || 0,
        y: Number(infoText.y) || 0,
        alpha: String(infoText.alpha) || "100",
        color: String(infoText.color) || null,
        font: {
          name: string(ocp + "format/font", "$FieldFont"),
          size: int(ocp + "format/size", 13),
          align: string(ocp + "format/align", "center"),
          bold: Boolean(infoText.bold)
        },
        shadow: {
          alpha: string(ocp + "filter/alpha", "100"),
          color: string(ocp + "filter/color", "0x000000"),
          angle: int(ocp + "filter/angle", 45),
          strength: int(ocp + "filter/strength", 120),
          distance: int(ocp + "filter/distance", 0),
          size: int(ocp + "filter/size", 3)
        },
        format: String(infoText.format) || ""
      };
    }

    private static function GetInfoTextFields(team:String, mode:String):*
    {
      var ocp: String = "components/" + team + "/infoText/";
      var obp: String = "behavior/" + team + "/" + mode + "/infoText";

      var infoText:* = value(obp);
      var textFields:Array = [];
      if (infoText is Array)
      {
        for (var i:String in infoText)
        {
          var f:* = GetInfoTextField(infoText[i], ocp);
          if (f && f.format && f.format != "")
            textFields.push(f);
        }
      }
      else
      {
        var f2:* = GetInfoTextField(infoText, ocp);
        if (f2)
          textFields.push(f2);
      };

      return textFields;
    }

    private static function ConvertTextFields():void
    {
      var carr:Array = [ "friend", "enemy" ];
      var barr:Array = [ "alive/normal", "alive/extended", "dead/normal", "dead/extended" ];
      var farr:Array = [ "playerName", "vehicleName", "currentHealth", "healthRatio", "infoText" ];

      for (var cid:String in carr)
      {
        var cname:String = carr[cid];
        var xname:String = (cname == "friend") ? "ally" : "enemy";
        for (var bid:String in barr)
        {
          var bname:String = barr[bid];
          var fields: Array = [ ];
          for (var fid:String in farr)
          {
            var fname:String = farr[fid];
            //wot.utils.Logger.add("ConvertTextFields: " + cname + ", " + bname + ", " + fname);
            var field:* = GetTextField(cname, bname, fname);
            if (field)
              fields.push(field);
            //wot.utils.Logger.add("ConvertTextFields: " + cname + ", " + bname + ", " + fname + " - done");
          }
          var infoTextFields:* = GetInfoTextFields(cname, bname);
          for (var i:String in infoTextFields)
            fields.push(infoTextFields[i]);
          //wot.utils.Logger.add("markers/" + xname + "/" + bname + "/textFields = " + fields.length)
          setValue("markers/" + xname + "/" + bname + "/textFields", fields);
        }
      }
    }
  }
}
