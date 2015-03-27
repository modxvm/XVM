/**
 * ...
 * @author Maxim Schedriviy
 */
import com.xvm.*;
import com.xvm.DataTypes.VehicleData;

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
        x = Macros.FormatGlobalNumberValue(cfg.x);
        y = Macros.FormatGlobalNumberValue(cfg.y);
        w = Macros.FormatGlobalNumberValue(cfg.w);
        h = Macros.FormatGlobalNumberValue(cfg.h);

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
            dmg += lastHit.delta;
            hits.pop();
        }

        var id:Number = hits.push({
            playerName:playerName,
            delta:dmg,
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

        var player:Object = players[playerName];
        player.total += delta;

        if (player.hits.length == 0 || player.hits[player.hits.length - 1] != id)
            player.hits.push(id);

        var last_player_hit_data = hits[player.hits[player.hits.length - 1]];
        player.delta = player.delta = last_player_hit_data.delta;
        player.curHealth = last_player_hit_data.curHealth;
        player.dead = last_player_hit_data.dead;
        player.damageType = last_player_hit_data.damageType;

        player.global = {
            hits: hits,
            total: total
        };

        //Logger.addObject(player);
        var header:String = Macros.Format(playerName, formatHeader, player);
        //Logger.add(formatHeader);

        if (lines <= 0)
        {
            saveText(header);
            return;
        }

        var hist:String = Macros.Format(playerName, formatHistory, player);
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

        saveText(Macros.FormatGlobalStringValue(defaultHeader));
    }
}
