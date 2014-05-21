/**
 * @author sirmax2
 */
import com.xvm.*;
import flash.filters.*;
import net.wargaming.controls.*;
import wot.Minimap.*;
import wot.PlayersPanel.*;

class wot.PlayersPanel.PlayerListItemRenderer
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    public var wrapper:net.wargaming.ingame.PlayerListItemRenderer;
    private var base:net.wargaming.ingame.PlayerListItemRenderer;

    public function PlayerListItemRenderer(wrapper:net.wargaming.ingame.PlayerListItemRenderer, base:net.wargaming.ingame.PlayerListItemRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;
        wrapper.xvm_worker = this;
        PlayerListItemRendererCtor();
    }

    function __getColorTransform()
    {
        return this.__getColorTransformImpl.apply(this, arguments);
    }

    function update()
    {
        return this.updateImpl.apply(this, arguments);
    }

    function lightPlayer()
    {
        return this.lightPlayerImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private static var TF_DEFAULT_WIDTH = 300;
    private static var TF_DEFAULT_HEIGHT = 25;

    private var m_name:String = null;
    private var m_clan:String = null;
    private var m_vehicleState:Number = 0;
    private var m_dead:Boolean = null;

    private var m_clanIcon: UILoaderAlt = null;
    private var m_iconset: IconLoader = null;
    private var m_iconLoaded: Boolean = false;

    private var spotStatusView:SpotStatusView = null;
    private var extraFields:Object;

    public function PlayerListItemRendererCtor()
    {
        Utils.TraceXvmModule("PlayersPanel");

        if (wrapper._name == "renderer99")
            return;

        extraFields = {
            none: null,
            short:null,
            medium: null,
            medium2: null,
            large: null
        };

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, this, onConfigLoaded);
        if (isLeftPanel)
        {
            GlobalEventDispatcher.addEventListener(Defines.E_UPDATE_STAGE, this, adjustExtraFieldsLeft);
            GlobalEventDispatcher.addEventListener(Defines.E_LEFT_PANEL_SIZE_ADJUSTED, this, adjustExtraFieldsLeft);
        }
        else
        {
            GlobalEventDispatcher.addEventListener(Defines.E_UPDATE_STAGE, this, adjustExtraFieldsRight);
            GlobalEventDispatcher.addEventListener(Defines.E_RIGHT_PANEL_SIZE_ADJUSTED, this, adjustExtraFieldsRight);
        }
    }

    private function onConfigLoaded()
    {
        try
        {
            if (!isLeftPanel)
            {
                if (Config.config.playersPanel.enemySpottedMarker.enabled && spotStatusView == null)
                    spotStatusView = new SpotStatusView(this, Config.config.playersPanel.enemySpottedMarker);
            }

            // remove old text fields
            // TODO: is all children will be deleted?
            if (extraFields.none != null)    extraFields.none.removeMovieClip();
            if (extraFields.short != null)   extraFields.short.removeMovieClip();
            if (extraFields.medium != null)  extraFields.medium.removeMovieClip();
            if (extraFields.medium2 != null) extraFields.medium2.removeMovieClip();
            if (extraFields.large != null)   extraFields.large.removeMovieClip();

            extraFields.none = createFieldsForNoneMode();
            extraFields.short = createExtraFields("short");
            extraFields.medium = createExtraFields("medium");
            extraFields.medium2 = createExtraFields("medium2");
            extraFields.large = createExtraFields("large");
            //Logger.addObject(extraFields, 2);
        }
        catch (ex:Error)
        {
            Logger.add(ex.toString());
        }
    }

    // IMPL

    function __getColorTransformImpl(schemeName)
    {
        //Logger.add("data.squad=" + data.squad + " " + data.userName + " scheme=" + schemeName);

        if (Config.config.battle.highlightVehicleIcon == false)
        {
            if (schemeName == "selected" || schemeName == "squad")
                schemeName = "normal";
            else if (schemeName == "selected_dead" || schemeName == "squad_dead")
                schemeName = "normal_dead";
        }

        return base.__getColorTransform(schemeName);
    }

    function updateImpl()
    {
        var data:Object = wrapper.data;
        //Logger.addObject(data);
        //Logger.add("update: " + (data ? data.userName : "(null)"))

        var saved_icon:String;
        if (data == null)
        {
            m_name = null;
            m_clan = null;
            m_vehicleState = 0;
            m_dead = true;
        }
        else
        {
            m_name = data.userName;
            m_clan = data.clanAbbrev;
            m_vehicleState = data.vehicleState;
            m_dead = (data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) == 0;

            saved_icon = data.icon;

            // Alternative icon set
            if (!m_iconset)
                m_iconset = new IconLoader(this, completeLoad);
            m_iconset.init(wrapper.iconLoader,
                [ wrapper.data.icon.split(Defines.WG_CONTOUR_ICON_PATH).join(Defines.XVMRES_ROOT +
                (isLeftPanel
                    ? Config.config.iconset.playersPanelAlly
                    : Config.config.iconset.playersPanelEnemy)),
                saved_icon ]);
            data.icon = m_iconset.currentIcon;

            // Player/clan icons
            attachClanIconToPlayer();

            // Spot Status View
            updateSpotStatusView();

            // Extra Text Fields
            updateExtraFields();
        }

        if (Config.config.playersPanel.removeSquadIcon && (wrapper.squadIcon != null))
            wrapper.squadIcon._visible = false;

        base.update();

        if (data != null)
            data.icon = saved_icon;
    }

    private function lightPlayerImpl(visibility)
    {
        wrapper.dispatchLightPlayer(visibility);
        //setTimeout(wrapper, "checkLightState", 250); // disabled!
    }

    // PRIVATE

    // properties

    private var _team:Number = 0;

    private function get team():Number
    {
        if (_team == 0)
            _team = wrapper._parent._parent._itemRenderer == "LeftItemRendererIcon" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY
        return _team;
    }

    private function get isLeftPanel():Boolean
    {
        return team == Defines.TEAM_ALLY;
    }

    private var _panel:net.wargaming.ingame.PlayersPanel = null;
    private function get panel():net.wargaming.ingame.PlayersPanel
    {
        if (_panel == null)
            _panel = net.wargaming.ingame.PlayersPanel(wrapper._parent._parent._parent);
        return _panel;
    }

    private function get extraPanelsHolder():MovieClip
    {
        if (_root["extraPanels"] == null)
        {
            var depth:Number = -16384;//_root.getNextHighestDepth(); // TODO: find suitable depth
            _root["extraPanels"] = _root.createEmptyMovieClip("extraPanels", depth);
        }
        return _root["extraPanels"];
    }

    // misc

    private function completeLoad()
    {
        if (m_iconLoaded)
            return;
        m_iconLoaded = true;

        mirrorEnemyIcons();

        wrapper.iconLoader._visible = true;
    }

    private function mirrorEnemyIcons():Void
    {
        if (!Config.config.battle.mirroredVehicleIcons && !isLeftPanel)
        {
            wrapper.iconLoader._xscale = -wrapper.iconLoader._xscale;
            wrapper.iconLoader._x -= 80;
            wrapper.vehicleLevel._x = wrapper.iconLoader._x + 15;
            if (spotStatusView != null)
                spotStatusView.draw();
        }
    }

    private function attachClanIconToPlayer():Void
    {
        var cfg:Object = Config.config.playersPanel.clanIcon;
        if (!cfg.show)
            return;

        if (m_clanIcon == null)
        {
            var x = (!m_iconLoaded || Config.config.battle.mirroredVehicleIcons || isLeftPanel)
                ? wrapper.iconLoader._x : wrapper.iconLoader._x + 80;
            m_clanIcon = PlayerInfo.createIcon(wrapper, "clanicon", cfg, x, wrapper.iconLoader._y, team);
        }
        PlayerInfo.setSource(m_clanIcon, m_name, m_clan);
        m_clanIcon["holder"]._alpha = m_dead ? 50 : 100;
    }

    private function updateSpotStatusView():Void
    {
        if (spotStatusView != null)
            spotStatusView.invalidateData(m_name, m_vehicleState);
    }

    // Extra fields

    private function createFieldsForNoneMode():MovieClip
    {
        var cfg:Object = Config.config.playersPanel.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];
        if (cfg.formats == null || cfg.formats.length <= 0)
            return null;
        return _internal_createExtraFields(extraPanelsHolder, "none", cfg.formats, cfg.width, cfg.height, cfg);
    }

    private function createExtraFields(mode:String):MovieClip
    {
        var formats:Array = Config.config.playersPanel[mode]["extraFields" + (isLeftPanel ? "Left" : "Right")];
        if (formats == null || formats.length <= 0)
            return null;
        return _internal_createExtraFields(wrapper, mode, formats, TF_DEFAULT_WIDTH, TF_DEFAULT_HEIGHT, null);
    }

    private function _internal_createExtraFields(owner:MovieClip, mode:String, formats:Array, width:Number, height:Number, cfg:Object):MovieClip
    {
        var idx = parseInt(wrapper._name.split("renderer").join(""));
        var mc:MovieClip = owner.createEmptyMovieClip("extraField_" + team + "_" + idx, owner.getNextHighestDepth());
        mc.idx = idx;
        if (cfg != null)
            mc.cfg = cfg;

        var len = formats.length;
        mc.formats = [];
        for (var i:Number = 0; i < len; ++i)
        {
            var format = formats[i];

            if (format == null)
                continue;

            if (typeof format == "string")
                format = { format: format };
                formats[i] = format;

            if (typeof format != "object")
                continue;

            var isEmpty:Boolean = true;
            for (var n in format)
            {
                isEmpty = false;
                break;
            }
            if (isEmpty)
                continue;

            // make a copy of format, because it will be changed
            var fmt:Object = { };
            for (var n in format)
                fmt[n] = format[n];
            mc.formats.push(fmt);

            createExtraTextField(mc, fmt, mc.formats.length - 1, width, height)
        }

        return mc;
    }

    private function createExtraTextField(mc:MovieClip, format:Object, n:Number, defW:Number, defH:Number)
    {
        //Logger.addObject(format);
        var x:Number = format.x != null && !isNaN(format.x) ? format.x : 0;
        var y:Number = format.y != null && !isNaN(format.y) ? format.x : 0;
        var w:Number = format.width != null && !isNaN(format.width) ? format.width : defW;
        var h:Number = format.height != null  && !isNaN(format.height) ? format.height : defH;
        var tf:TextField = mc.createTextField("f" + n, n, 0, 0, 300, 25);
        tf.data = { x: x, y: y, w: w, h: h };
        alignTextField(tf);

        tf._alpha = format.alpha != null && !isNaN(format.alpha) ? format.alpha : 100;
        tf._rotation = format.rotation != null && !isNaN(format.rotation) ? format.rotation : 0;

        tf.selectable = false;
        tf.html = true;
        tf.multiline = true;
        tf.wordWrap = false;
        tf.antiAliasType = format.antiAliasType != null ? format.antiAliasType : "advanced";
        tf.align = format.align != null ? format.align : (isLeftPanel ? "left" : "right");
        tf.autoSize = "none";
        tf.verticalAlign = format.valign != null ? format.valign : "none";
        tf.styleSheet = Utils.createStyleSheet(Utils.createCSS("extraField", 0xFFFFFF, "$FieldFont", 14, "center", false, false));

        tf.border = format.borderColor != null;
        tf.borderColor = format.borderColor != null && !isNaN(format.borderColor) ? format.borderColor : 0xCCCCCC;
        tf.background = format.backgroundColor != null;
        tf.backgroundColor = format.backgroundColor != null && !isNaN(format.backgroundColor) ? format.backgroundColor : 0x000000;

        if (format.shadow != null)
        {
            tf.filters = [
                new DropShadowFilter(
                    format.shadow.distance != null ? format.shadow.distance : 0,
                    format.shadow.angle != null ? format.shadow.angle : 45,
                    format.shadow.alpha != null ? format.shadow.alpha : 1,
                    format.shadow.blur != null ? format.shadow.blur : 4,
                    format.shadow.blur != null ? format.shadow.blur : 4,
                    format.shadow.strength != null ? format.shadow.strength : 1)
            ];
        }

        cleanupFormat(tf, format);

        return tf;
    }

    // cleanup formats without macros to remove extra checks
    private function cleanupFormat(field, format:Object)
    {
        if (format.x != null && (typeof format.x != "string" || format.x.indexOf("{{") < 0))
            delete format.x;
        if (format.y != null && (typeof format.y != "string" || format.y.indexOf("{{") < 0))
            delete format.y;
        if (format.width != null && (typeof format.width != "string" || format.width.indexOf("{{") < 0))
            delete format.width;
        if (format.height != null && (typeof format.height != "string" || format.height.indexOf("{{") < 0))
            delete format.height;
        if (format.alpha != null && (typeof format.alpha != "string" || format.alpha.indexOf("{{") < 0))
            delete format.alpha;
        if (format.rotation != null && (typeof format.rotation != "string" || format.rotation.indexOf("{{") < 0))
            delete format.rotation;

        if (format.borderColor != null && (typeof format.borderColor != "string" || format.borderColor.indexOf("{{") < 0))
            delete format.borderColor;
        if (format.backgroundColor != null && (typeof format.backgroundColor != "string" || format.backgroundColor.indexOf("{{") < 0))
            delete format.backgroundColor;

        if (format.format != null && (typeof format.format != "string" || format.format.indexOf("{{") < 0))
        {
            if (format.format != null)
            {
                field.htmlText = "<span class='extraField'>" + format.format + "</span>";
                alignTextField(field);
            }
            delete format.format;
        }
    }

    private function updateExtraFields():Void
    {
        //Logger.add("updateExtraFields");
        var state:String = panel.state;

        if (extraFields.none != null )      extraFields.none._visible = state == "none";
        if (extraFields.short != null )     extraFields.short._visible = state == "short";
        if (extraFields.medium != null )    extraFields.medium._visible = state == "medium";
        if (extraFields.medium2 != null )   extraFields.medium2._visible = state == "medium2";
        if (extraFields.large != null )     extraFields.large._visible = state == "large";

        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var obj = BattleState.getUserData(m_name);
        var formats:Array = mc.formats;
        var len:Number = formats.length;
        for (var i:Number = 0; i < len; ++i)
            _internal_update(mc["f" + i], formats[i], obj);
    }

    private function _internal_update(f, format, obj)
    {
        var needAlign:Boolean = false;
        if (format.x != null)
        {
            f.data.x = parseFloat(Macros.Format(m_name, format.x, obj));
            needAlign = true;
        }
        if (format.y != null)
        {
            f.data.y = parseFloat(Macros.Format(m_name, format.y, obj));
            needAlign = true;
        }
        if (format.width != null)
        {
            f.data.w = parseFloat(Macros.Format(m_name, format.width, obj));
            needAlign = true;
        }
        if (format.height != null)
        {
            f.data.h = parseFloat(Macros.Format(m_name, format.height, obj));
            needAlign = true;
        }
        if (format.alpha != null)
            f._alpha = parseFloat(Macros.Format(m_name, format.alpha, obj));
        if (format.rotation != null)
            f._rotation = parseFloat(Macros.Format(m_name, format.rotation, obj));
        if (format.borderColor != null)
            f.borderColor = parseInt(Macros.Format(m_name, format.borderColor, obj));
        if (format.backgroundColor != null)
            f.backgroundColor = parseInt(Macros.Format(m_name, format.backgroundColor, obj));

        if (format.format != null)
        {
            var txt:String = Macros.Format(m_name, format.format, obj);
            //Logger.add(m_name + " " + txt);
            f.htmlText = "<span class='extraField'>" + txt + "</span>";
            needAlign = true;
        }

        if (needAlign)
            alignTextField(f);
    }

    private function alignTextField(tf:TextField)
    {
        var data:Object = tf["data"];
        var x:Number;
        var w:Number;
        var h:Number;

        switch (tf.align)
        {
            case "center":
                x = data.x;
                w = data.w;
                break;

            case "right":
                x = - data.w - data.x;
                //x = - tf.textWidth - data.x;
                w = data.w;
                break;

            default:
                x = data.x;
                w = data.w;
                break;
        }

        //Logger.add("x: " + x + " y: " + data.y + " w: " + w + " h: " + data.h);

        w += 2; // 2-pixel gutter
        h = data.h + 2; // 2-pixel gutter

        if (tf._x != x)
            tf._x = x;
        if (tf._width != w)
            tf._width = w;
        if (tf._y != data.y)
            tf._y = data.y;
        if (tf._height != h)
            tf._height = h;
    }

    private function adjustExtraFieldsLeft(e)
    {
        //Logger.add("adjustExtraFieldsLeft: " + e.state);
        var state:String = e.state;
        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var cfg = mc.cfg;
        if (cfg != null)
        {
            // none mode
            mc._x = cfg.x;
            mc._y = cfg.y + mc.idx * cfg.height;
        }
        else
        {
            // other modes
            mc._x = -panel.m_list._x;
            mc._y = 0;
        }
    }

    private function adjustExtraFieldsRight(e)
    {
        //Logger.add("adjustExtraFieldsRight: " + e.state);
        var state:String = e.state;
        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var cfg = mc.cfg;
        if (cfg != null)
        {
            // none mode
            mc._x = BattleState.screenSize.width - cfg.width - cfg.x;
            mc._y = cfg.y + mc.idx * cfg.height;
        }
        else
        {
            // other modes
            mc._x = panel.m_list.width - panel.m_list._x;
            mc._y = 0;
        }
        //Logger.add(BattleState.screenSize.width + " " + panel.m_list.width + " " + panel.m_list._x);
    }
}
/*
data = {
  "igrLabel": "",
  "uid": 1758821,
  "position": 10,
  "denunciations": 10,
  "userName": "_V_E_T_E_R_A_N_",
  "icon": "../maps/icons/vehicle/contour/ussr-Object_261.png",
  "teamKiller": false,
  "speaking": false,
  "vehicleState": 3,
  "VIP": false,
  "vipKilled": 0,
  "roster": 0,
  "frags": 0,
  "vehAction": 0,
  "vehicle": "Об. 261",
  "team": 2,
  "squad": 0,
  "himself": false,
  "level": 0,
  "vehId": 23084543,
  "isEnabledInRoaming": true,
  "muted": false,
  "isPostmortemView": false,
  "clanAbbrev": "S-HA",
  "isIGR": false,
  "label": "_V_E_T_E_R_A_N_[S-HA]"
}
*/
