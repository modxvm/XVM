/**
 * ...
 * @author Maxim Schedriviy
 */
import com.xvm.Cmd;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GraphicsUtil;
import com.xvm.JSONx;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Strings;
import com.xvm.Utils;
import com.xvm.VehicleInfo;

class wot.VehicleMarkersManager.log.HitLog
{
    public static var STYLE_NAME:String = "xvm_hitlog";

    private static var groupHitsByPlayer:Boolean = false;

    private var x:Number;
    private var y:Number;
    private var w:Number;
    private var h:Number;
    private var lines:Number;
    private var direction:Number;
    private var insertOrder:Number;
    private var defaultHeader:String;
    private var formatHeader:String;
    private var formatHistory:String;
    private var shadow:Object;

    private var textField:TextField;

    private var total:Number;
    private var players:Object;
    private var hits:Array;

    private var text:String;

    public function HitLog(cfg:Object)
    {
        x = cfg.x;
        y = cfg.y;
        w = cfg.w;
        h = cfg.h;
        lines = Math.min(100, Math.max(0, cfg.lines));
        direction = cfg.direction.toLowerCase() == "up" ? Defines.DIRECTION_UP : Defines.DIRECTION_DOWN;
        insertOrder = cfg.insertOrder.toLowerCase() == "begin" ? Defines.INSERTORDER_BEGIN : Defines.INSERTORDER_END;
        groupHitsByPlayer = cfg.groupHitsByPlayer == true;
        defaultHeader = Locale.get(cfg.defaultHeader);
        formatHeader = Locale.get(cfg.formatHeader);
        formatHistory = Locale.get(cfg.formatHistory);
        shadow = cfg.shadow;

        total = 0;
        hits = [];
        players = {};

        createControl();
    }

    /**
     * Save prepared content.
     * LogLists decides when to update text field with content.
     */
    function saveText(text:String)
    {
        this.text = text;
    }

    /** Invoked by LogLists */
    public function setHpText(text:String):Void
    {
        textField.htmlText = text;
    }

    /** Invoked by LogLists */
    public function setHitText():Void
    {
        textField.htmlText = "<span class='" + STYLE_NAME + "'>" + this.text + "</span>";
    }

    public function update(delta:Number, curHealth:Number, vehicleName:String, icon:String, playerName:String,
        level:Number, damageType:String, vtype:String, vtypeColor:String, dead:Boolean)
    {
        total += delta;

        var dmg = delta;
        var lastHit:Object = hits.length == 0 ? { } : hits[hits.length - 1];
        if ((damageType == "fire" || damageType == "ramming") && lastHit.damageType == damageType && lastHit.playerName == playerName)
        {
            dmg += lastHit.dmg;
            hits.pop();
        }

        var id:Number = hits.push({
            playerName:playerName,
            dmg:dmg,
            curHealth:curHealth,
            dead:dead,
            damageType:damageType
        }) - 1;

        if (!players[playerName])
        {
            players[playerName] = {
                vehicleName:vehicleName,
                icon:icon,
                level:level,
                vtype:vtype,
                vtypeColor:vtypeColor,
                total: 0,
                hits: []
            }
        }

        players[playerName].total += delta;

        if (players[playerName].hits.length == 0 || players[playerName].hits[players[playerName].hits.length - 1] != id)
            players[playerName].hits.push(id);

        var header:String = formatText(formatHeader, playerName);

        if (lines <= 0)
        {
            saveText(header);
            return;
        }

        var hist:String = formatText(formatHistory, playerName);
        hits[hits.length - 1].hist = hist;

        var skip:Array = [ ];
        var txt:String = "";
        for (var i:Number = 0, n:Number = hits.length - 1; i < lines, n >= 0; --n)
        {
            var data = hits[n];
            if (groupHitsByPlayer)
            {
                if (Utils.indexOf(skip, data.playerName) != -1)
                    continue;
                skip.push(data.playerName);
            }

            var br = (txt == "") ? "" : "<br/>";
            txt = (direction == insertOrder) ? txt + br + data.hist : data.hist + br + txt;
            i++;
        }

        saveText((direction == Defines.DIRECTION_DOWN) ? header + "<br/>" + txt : txt + "<br/>" + header);
    }

    private function createControl()
    {
        //Logger.add("HitLog::createControl()");
        Cmd.getScreenSize(this, createControl2);
    }

    private function createControl2(size)
    {
        //Logger.add("HitLog::createControl2()");
        var sz = JSONx.parse(size);
        var x = this.x >= 0 ? this.x : sz[0] + this.x;
        var y = this.y >= 0 ? this.y : sz[1] + this.y;

        textField = _root.createTextField("xvmHitLog", _root.getNextHighestDepth(), x, y, w, h);
        //textField.border = true;
        //textField.borderColor = 0xFFFFFF;
        textField.verticalAlign = (direction == Defines.DIRECTION_DOWN) ? "top" : "bottom";
        textField.antiAliasType = "advanced";
        textField.selectable = false;
        textField.multiline = true;
        textField.wordWrap = false;
        if (shadow)
        {
            textField.filters = [ GraphicsUtil.createShadowFilter(shadow.distance, shadow.angle,
                parseInt(shadow.color), shadow.alpha, shadow.size, shadow.strength) ];
        }

        textField.html = true;
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS("." + STYLE_NAME + "{font-family:$FieldFont;font-size:15px;color:#f4efe8;}");
        textField.styleSheet = style;

        saveText(defaultHeader);
    }

    private function formatText(format:String, playerName:String):String
    {
        // TODO: Macros optimization - use com.xvm.Macros class

        if (format.indexOf("{{") == -1)
            return Utils.fixImgTag(format);

        try
        {
            var data = players[playerName];
            if (data)
            {
                var last_player_hit_data = hits[data.hits[data.hits.length - 1]];
                data.dmg = last_player_hit_data.dmg;
                data.curHealth = last_player_hit_data.curHealth;
                data.dead = last_player_hit_data.dead;
                data.damageType = last_player_hit_data.damageType;
            }
            else
            {
                data = {
                    playerName:"",
                    dmg:0,
                    curHealth:1,
                    dead:false,
                    damageType:"",
                    vehicleName:"",
                    icon:"",
                    level:0,
                    vtype:"",
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
                    : (data.curHealth == 0 || data.dead) ? Config.s_config.hitLog.deadMarker : "");
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
            formatArr = format.split("{{dmg-avg}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(hits.length == 0 ? 0 : Math.round(total / hits.length)));
            formatArr = format.split("{{dmg-player}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.total);

            formatArr = format.split("{{nick}}");
            if (formatArr.length > 1)
                format = formatArr.join(playerName);
            formatArr = format.split("{{name}}");
            if (formatArr.length > 1)
                format = formatArr.join(Utils.GetPlayerName(playerName));
            formatArr = format.split("{{clan}}");
            if (formatArr.length > 1)
                format = formatArr.join(Utils.GetClanNameWithBrackets(playerName));
            formatArr = format.split("{{clannb}}");
            if (formatArr.length > 1)
                format = formatArr.join(Utils.GetClanName(playerName));
            formatArr = format.split("{{vehicle}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.vehicleName);
            formatArr = format.split("{{vehiclename}}");
            if (formatArr.length > 1)
                format = formatArr.join(VehicleInfo.getVehicleName(data.icon));
            formatArr = format.split("{{vtype}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.vtype);
            formatArr = format.split("{{level}}");
            if (formatArr.length > 1)
                format = formatArr.join(data.level);
            formatArr = format.split("{{rlevel}}");
            if (formatArr.length > 1)
                format = formatArr.join(Defines.ROMAN_LEVEL[data.level - 1]);
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

            format = Strings.trim(format);
        }
        catch (e)
        {
            format = "Error: " + String(e);
        }

        return Utils.fixImgTag(format);
    }
}
