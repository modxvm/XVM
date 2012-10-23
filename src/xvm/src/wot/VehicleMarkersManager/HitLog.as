/**
 * ...
 * @author Maxim Schedriviy
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.Utils;
import wot.VehicleMarkersManager.XvmHelper;

class wot.VehicleMarkersManager.HitLog
{
    // dummy var to avoid import warning
    private static var __dummy = Logger.dummy;

    private static var groupHitsByPlayer:Boolean = false;
    
    private var x:Number;
    private var y:Number;
    private var w:Number;
    private var h:Number;
    private var lines:Number;
    private var direction:Number;
    private var format:String;
    private var formatHistory:String;
    
    private var textField:TextField;

    private var total:Number;
    private var players:Object;
    private var hits:Array;

    public function HitLog(cfg:Object)
    {
        groupHitsByPlayer = Config.s_config.hitLog.groupHitsByPlayer == true;

        x = cfg.x;
        y = cfg.y;
        w = cfg.w;
        h = cfg.h;
        lines = Math.min(100, Math.max(1, cfg.lines));
        direction = cfg.direction.toUpperCase() == "UP" ? Defines.DIRECTION_UP : Defines.DIRECTION_DOWN;
        format = cfg.format;
        formatHistory = cfg.formatHistory;

        total = 0;
        hits = [];
        players = {};

        createControl();
    }

    function setText(txt)
    {
        textField.htmlText = "<span class='xvm_hitlog'>" + txt + "</span>";
        //Logger.add(textField.htmlText);
    }

    public function update(delta:Number, curHealth:Number, vehicleName:String, playerName:String,
        level:Number, damageType:String, vtypeColor:String)
    {
        //wot.utils.Logger.add(delta + " " + vehicleName + " " + playerName + " " + level);

        total += delta;

        var dmg = delta;
        var lastHit:Object = hits.length == 0 ? { } : hits[hits.length - 1];
        if ((damageType == "fire" || damageType == "ramming") && lastHit.damageType == damageType)
        {
            dmg += lastHit.dmg;
            hits.pop();
        }

        var id:Number = hits.push({
            playerName:playerName,
            dmg:dmg,
            curHealth:curHealth,
            damageType:damageType
        }) - 1;

        if (!players[playerName])
        {
            players[playerName] = {
                vehicleName:vehicleName,
                level:level,
                vtypeColor:vtypeColor,
                total: 0,
                hits: []
            }
        }

        players[playerName].total += delta;

        if (players[playerName].hits.length == 0 || players[playerName].hits[players[playerName].hits.length - 1] != id)
            players[playerName].hits.push(id);

        var last:String = formatText(format, playerName);
        if (lines <= 1)
        {
            setText(last);
            return;
        }

        var hist:String = formatText(formatHistory || format, playerName);
        hits[hits.length - 1].hist = hist;

        var skip:Array = [ playerName ];
        var txt:String = "";
        for (var i:Number = 0, n:Number = hits.length - 2; i < lines - 1, n >= 0; --n)
        {
            var data = hits[n];
            if (groupHitsByPlayer)
            {
                if (Utils.indexOf(skip, data.playerName) != -1)
                    continue;
                skip.push(data.playerName);
            }

            var br = (txt == "") ? "" : "<br/>";
            txt = (direction == Defines.DIRECTION_DOWN) ? txt + br + data.hist : data.hist + br + txt;
            i++;
        }

        setText((direction == Defines.DIRECTION_DOWN) ? last + "<br/>" + txt : txt + "<br/>" + last);
    }

    private function createControl()
    {
        //Logger.add("HitLog::createControl()");
        var x = this.x >= 0 ? this.x : Config.s_vars.window_size[0] + this.x;
        var y = this.y >= 0 ? this.y : Config.s_vars.window_size[1] + this.y;
        //Logger.addObject(Config.s_vars);

        textField = _root.createTextField("xvmHitLog", _root.getNextHighestDepth(), x, y, w, h);
        //textField.border = true;
        //textField.borderColor = 0xFFFFFF;
        textField.verticalAlign = (direction == Defines.DIRECTION_DOWN) ? "top" : "bottom";
        textField.antiAliasType = "advanced";
        textField.multiline = true;
        textField.wordWrap = false;
        textField.filters = [new flash.filters.DropShadowFilter(1, 90, 0, 100, 5, 5, 1.5, 3)];

        textField.html = true;
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(".xvm_hitlog {font-family:$FieldFont; font-size:15px; color:#F4EFE8;}");
        textField.styleSheet = style;

        setText(formatText(format, ""));
    }

    private function formatText(format:String, playerName:String):String
    {
        try
        {
            var data = players[playerName];
            if (data)
            {
                var last_player_hit_data = hits[data.hits[data.hits.length - 1]];
                data.dmg = last_player_hit_data.dmg;
                data.curHealth = last_player_hit_data.curHealth;
                data.damageType = last_player_hit_data.damageType;
            }
            else
            {
                data = {
                    playerName:"",
                    dmg:0,
                    curHealth:1,
                    damageType:"",
                    vehicleName:"",
                    level:0,
                    vtypeColor:null,
                    total: 0,
                    hits: []
                }
            }

            var formatArr:Array;
            formatArr = format.split("{{dead}}");
            if (formatArr.length > 1)
            {
                format = formatArr.join(data.curHealth < 0
                    ? Config.s_config.hitLog.blowupMarker 
                    : data.curHealth == 0 ? Config.s_config.hitLog.deadMarker : "");
            }
            formatArr = format.split("{{n}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(hits.length));
            formatArr = format.split("{{n-player}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.hits.length);
            formatArr = format.split("{{dmg}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.dmg);
            formatArr = format.split("{{dmg-total}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(total));
            formatArr = format.split("{{dmg-player}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.total);
            formatArr = format.split("{{nick}}");
            if (formatArr.length > 1)
                format = formatArr.join(playerName);
            formatArr = format.split("{{vehicle}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.vehicleName);
            formatArr = format.split("{{level}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.level);
            formatArr = format.split("{{rlevel}}");
            if (formatArr.length > 1)
                format = formatArr.join(XvmHelper.rlevel[data.level - 1]);
            formatArr = format.split("{{dmg-kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(Locale.get(data.damageType));
            formatArr = format.split("{{c:dmg-kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.dmg ? GraphicsUtil.GetDmgKindValue(data.damageType) : "")
            formatArr = format.split("{{c:dmg_kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.dmg ? GraphicsUtil.GetDmgKindValue(data.damageType) : "")
            formatArr = format.split("{{c:vtype}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.vtypeColor);

            format = Utils.trim(format);
        }
        catch (e)
        {
            format = "Error: " + String(e);
        }

        return format;
    }
}
