/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import com.xvm.DataTypes.*;
import flash.filters.*;
import flash.geom.*;
import gfx.core.*;
import gfx.controls.*;
import net.wargaming.*;
import net.wargaming.controls.*;
import net.wargaming.managers.*;
import net.wargaming.ingame.*;
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

    function getColorTransform()
    {
        if (Config.eventType != "normal")
            return base.getColorTransform.apply(base, arguments);
        return this.getColorTransformImpl.apply(this, arguments);
    }

    function setState()
    {
        if (Config.eventType != "normal")
            return base.setState.apply(base, arguments);
        return this.setStateImpl.apply(this, arguments);
    }

    function update()
    {
        if (Config.eventType != "normal")
            return base.update.apply(base, arguments);
        return this.updateImpl.apply(this, arguments);
    }

    function updateSquadIcons()
    {
        if (Config.eventType != "normal")
            return base.updateSquadIcons.apply(base, arguments);
        return this.updateSquadIconsImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    public static var MENU_MC_NAME = "menu_mc";

    private static var TF_DEFAULT_WIDTH = 300;
    private static var TF_DEFAULT_HEIGHT = 25;

    private var cfg:Object;

    private var m_name:String = null;
    private var m_clan:String = null;
    private var m_vehicleState:Number = 0;
    private var m_dead:Boolean = null;

    private var m_clanIcon: UILoaderAlt = null;
    private var m_iconset: IconLoader = null;
    private var m_iconLoaded: Boolean = false;

    private var extraFields:Object;
    private var extraFieldsLayout:String;
    private var extraFieldsConfigured:Boolean;

    public function PlayerListItemRendererCtor()
    {
        Utils.TraceXvmModule("PlayersPanel");

        if (wrapper._name == "renderer99")
            return;

        extraFields = null;
        extraFieldsConfigured = false;

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(Defines.E_STAT_LOADED, this, onStatLoaded);

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

    // IMPL

    function getColorTransformImpl(schemeName:String, force:Boolean)
    {
        if (Config.config.battle.highlightVehicleIcon == false && !force)
        {
            if (schemeName == "selected" || schemeName == "squad")
                schemeName = "normal";
            else if (schemeName == "selected_offline" || schemeName == "squad_offline")
                schemeName = "normal_offline";
            else if (schemeName == "selected_dead" || schemeName == "squad_dead")
                schemeName = "normal_dead";
        }

        return base.getColorTransform(schemeName);
    }

    function setStateImpl()
    {
        var savedValue = wrapper.data.isPostmortemView;

        if (Macros.FormatGlobalBooleanValue(cfg.removeSelectedBackground))
            wrapper.data.isPostmortemView = false;

        base.setState();

        if (wrapper.vehicleLevel != null)
            wrapper.vehicleLevel._alpha *= panel.state == "none" ? 0 : cfg[panel.state].vehicleLevelAlpha / 100.0;

        wrapper.data.isPostmortemView = savedValue;
    }

    function updateImpl()
    {
        try
        {
            var data:Object = wrapper.data;
            //Logger.add("update: " + (data ? data.userName : "(null)"))
            //Logger.addObject(data);

            var saved_icon:String;
            if (data == null)
            {
                m_name = null;
                m_clan = null;
                m_vehicleState = 0;
                m_dead = true;
                if (extraFields != null)
                    extraFields.none._visible = false;
            }
            else
            {
                m_name = data.userName;
                m_clan = data.clanAbbrev;
                m_vehicleState = data.vehicleState;
                m_dead = (data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) == 0;

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

                // Extra fields
                if (Stat.s_loaded)
                {
                    if (!extraFieldsConfigured)
                        configureExtraFields();
                    updateExtraFields();
                }
            }

            if (wrapper.squadIcon != null)
                wrapper.squadIcon._visible = (panel.state != "none" && !cfg[panel.state].removeSquadIcon);

            base.update();

            wrapper.iconLoader.content._alpha = cfg.iconAlpha;

            if (data != null)
                data.icon = saved_icon;
        }
        catch (ex:Error)
        {
            Logger.addObject(ex.toString());
        }
    }

    private function updateSquadIconsImpl(squadPositionX, dynamicIcoPotionX)
    {
        //Logger.add(squadPositionX + " " + dynamicIcoPotionX);
        wrapper.squadIcon._x = squadPositionX;
        wrapper.addToSquad._x = dynamicIcoPotionX;
        wrapper.acceptSquadInvite._x = dynamicIcoPotionX;
        wrapper.inviteWasSent._x = dynamicIcoPotionX;
        wrapper.inviteReceived._x = dynamicIcoPotionX;
        wrapper.inviteReceivedFromSquad._x = dynamicIcoPotionX;
        wrapper.inviteDisabled._x = dynamicIcoPotionX;
    }

    // PRIVATE

    // properties

    private var _team:Number = 0;

    private function get team():Number
    {
        if (_team == 0)
            _team = wrapper._parent._parent._itemRenderer == "LeftItemRendererIcon" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
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

    private static function get extraPanelsHolder():MovieClip
    {
        if (_root["extraPanels"] == null)
        {
            var depth:Number = -16377; // the only one free depth for panels
            _root["extraPanels"] = _root.createEmptyMovieClip("extraPanels", depth);
            createMouseHandler(_root["extraPanels"]);
        }
        return _root["extraPanels"];
    }

    // misc

    private function onConfigLoaded()
    {
        //Logger.add(Config.eventType);
        if (Config.eventType != "normal")
            return;
        try
        {
            this.cfg = Config.config.playersPanel;

            //Logger.add("onConfigLoaded: " + m_name);
            if (extraFields == null)
            {
                extraFields = {
                    none:    createFieldsHolderForNoneState(),
                    short:   createExtraFieldsHolder("short"),
                    medium:  createExtraFieldsHolder("medium"),
                    medium2: createExtraFieldsHolder("medium2"),
                    large:   createExtraFieldsHolder("large")
                };
            }

            extraFieldsConfigured = false;
            if (m_name)
                configureExtraFields();
        }
        catch (ex:Error)
        {
            Logger.add(ex.toString());
        }
    }

    private function onStatLoaded()
    {
        if (Config.eventType != "normal")
            return;
        update();
    }

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

            updateExtraFields();
        }
    }

    private function attachClanIconToPlayer():Void
    {
        var clanIconCfg:Object = cfg.clanIcon;
        if (!clanIconCfg.show)
            return;

        var statData:Object = Stat.s_data[m_name];
        if (statData == null)
            return;
        var emblem:String = (statData == null && statData.stat != null) ? null : statData.stat.emblem;

        if (m_clanIcon == null)
        {
            var x = (!m_iconLoaded || Config.config.battle.mirroredVehicleIcons || isLeftPanel)
                ? wrapper.iconLoader._x : wrapper.iconLoader._x + 80;
            m_clanIcon = PlayerInfo.createIcon(wrapper, "clanicon", clanIconCfg, x, wrapper.iconLoader._y, team);
        }
        PlayerInfo.setSource(m_clanIcon, wrapper.data.uid, m_name, m_clan, emblem);
        m_clanIcon["holder"]._alpha = m_dead ? 50 : 100;
    }

    // Extra fields

    private function createFieldsHolderForNoneState():MovieClip
    {
        extraFieldsLayout = cfg.none.layout;
        var cfg_xf:Object = cfg.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];

        var mc:MovieClip = _internal_createExtraFieldsHolder(extraPanelsHolder, "none", cfg_xf.formats, cfg_xf);
        mc._visible = false;

        return mc;
    }

    private function createExtraFieldsHolder(state:String):MovieClip
    {
        var formats:Array = cfg[state]["extraFields" + (isLeftPanel ? "Left" : "Right")];
        return _internal_createExtraFieldsHolder(wrapper, state, formats, null);
    }

    private function _internal_createExtraFieldsHolder(owner:MovieClip, state:String, formats:Array, cfg:Object):MovieClip
    {
        var idx = parseInt(wrapper._name.split("renderer").join(""));
        var mc:MovieClip = owner.createEmptyMovieClip("extraField_" + team + "_" + state + "_" + idx, owner.getNextHighestDepth());
        mc._visible = false;
        mc.idx = idx;
        mc.orig_formats = formats;
        mc.cfg = cfg;
        return mc;
    }

    private function configureExtraFields()
    {
        try
        {
            //Logger.add("configureExtraFields: " + m_name);

            if (extraFields == null)
            {
                Logger.add("WARNING: extraFields == null");
                return;
            }

            if (extraFieldsConfigured)
                return;

            extraFieldsConfigured = true;

            // remove old text fields
            Utils.removeChildren(extraFields.none);
            Utils.removeChildren(extraFields.short);
            Utils.removeChildren(extraFields.medium);
            Utils.removeChildren(extraFields.medium2);
            Utils.removeChildren(extraFields.large);

            var cf:Object = cfg.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];
            _internal_createExtraFields("none", cf.width, cf.height);
            _internal_createExtraFields("short", TF_DEFAULT_WIDTH, TF_DEFAULT_HEIGHT);
            _internal_createExtraFields("medium", TF_DEFAULT_WIDTH, TF_DEFAULT_HEIGHT);
            _internal_createExtraFields("medium2", TF_DEFAULT_WIDTH, TF_DEFAULT_HEIGHT);
            _internal_createExtraFields("large", TF_DEFAULT_WIDTH, TF_DEFAULT_HEIGHT);
        }
        catch (ex:Error)
        {
            Logger.add(ex.message);
            return null;
        }
    }

    private function _internal_createExtraFields(state:String, width:Number, height:Number)
    {
        //Logger.add("_internal_createExtraFields: " + state);
        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var formats:Array = mc.orig_formats;
        if (formats == null || formats.length <= 0)
            return;

        mc.formats = [];
        var n:Number = 0;
        var len:Number = formats.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var format = formats[i];

            if (format == null)
                continue;

            if (typeof format == "string")
            {
                format = { format: format };
                formats[i] = format;
            }

            if (typeof format != "object")
                continue;

            var isEmpty:Boolean = true;
            for (var nm in format)
            {
                isEmpty = false;
                break;
            }
            if (isEmpty)
                continue;

            if (format.enabled != null)
            {
                var enabled:Boolean = Macros.FormatGlobalBooleanValue(format.enabled);
                if (enabled == false)
                    continue;
            }

            // make a copy of format, because it will be changed
            var fmt:Object = { };
            for (var nm in format)
                fmt[nm] = format[nm];
            mc.formats.push(fmt);

            if (fmt.src != null)
            {
                createExtraMovieClip(mc, fmt, n);
            }
            else
            {
                createExtraTextField(mc, fmt, n, width, height);
            }
            n++;
        }

        if (state == "none")
            _internal_createMenuForNoneState(mc);
    }

    private function _internal_createMenuForNoneState(mc:MovieClip)
    {
        var cf:Object = cfg.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];
        if (cf.formats == null || cf.formats.length <= 0)
            return;
        var menu_mc:UIComponent = UIComponent.createInstance(mc, "HiddenButton", MENU_MC_NAME, mc.getNextHighestDepth(), {
            _x: isLeftPanel ? 0 : -cf.width,
            width: cf.width,
            height: cf.height,
            panel: isLeftPanel ? _root["leftPanel"] : _root["rightPanel"],
            owner: this } );
        menu_mc.addEventListener("rollOver", wrapper, "onItemRollOver");
        menu_mc.addEventListener("rollOut", wrapper, "onItemRollOut");
        menu_mc.addEventListener("releaseOutside", wrapper, "onItemReleaseOutside");
    }

    private function createExtraMovieClip(mc:MovieClip, format:Object, n:Number)
    {
        //Logger.addObject(format);
        var x:Number = Macros.FormatNumber(m_name, format, "x", null, 0, 0);
        var y:Number = Macros.FormatNumber(m_name, format, "y", null, 0, 0);
        var w:Number = Macros.FormatNumber(m_name, format, "w", null, NaN, 0);
        var h:Number = Macros.FormatNumber(m_name, format, "h", null, NaN, 0);

        var img:UILoaderAlt = (UILoaderAlt)(mc.attachMovie("UILoaderAlt", "f" + n, mc.getNextHighestDepth()));
        img["data"] = {
            x: x, y: y, w: w, h: h,
            format: format,
            align: format.align != null ? format.align : (isLeftPanel ? "left" : "right"),
            scaleX: Macros.FormatNumber(m_name, format, "scaleX", null, 1, 1) * 100,
            scaleY: Macros.FormatNumber(m_name, format, "scaleY", null, 1, 1) * 100
        };
        //Logger.addObject(img["data"]);

        img._alpha = Macros.FormatNumber(m_name, format, "alpha", null, 100, 100);
        img._rotation = Macros.FormatNumber(m_name, format, "rotation", null, 0, 0);
        img.autoSize = true;
        img.maintainAspectRatio = false;
        var me = this;
        img.visible = false;
        img.onLoadInit = function() { me.onExtraMovieClipLoadInit(img); }

        cleanupFormat(img, format);

        return img;
    }

    private function onExtraMovieClipLoadInit(img:UILoaderAlt)
    {
        //Logger.add("onExtraMovieClipLoadInit: " + m_name + " " + img.source);

        var data = img["data"];
        //Logger.addObject(data, 2, m_name);

        img.visible = false;
        img._x = 0;
        img._y = 0;
        img.width = 0;
        img.height = 0;
        img._xscale = data.scaleX;
        img._yscale = data.scaleY;
        alignField(img);

        setTimeout(function() { img.visible = true; }, 1);
    }

    private function createExtraTextField(mc:MovieClip, format:Object, n:Number, defW:Number, defH:Number)
    {
        //Logger.addObject(format);
        var x:Number = Macros.FormatNumber(m_name, format, "x", null, 0, 0);
        var y:Number = Macros.FormatNumber(m_name, format, "y", null, 0, 0);
        var w:Number = Macros.FormatNumber(m_name, format, "w", null, defW, 0);
        var h:Number = Macros.FormatNumber(m_name, format, "h", null, defH, 0);
        var tf:TextField = mc.createTextField("f" + n, n, 0, 0, 0, 0);
        tf.data = {
            x: x, y: y, w: w, h: h,
            align: format.align != null ? format.align : (isLeftPanel ? "left" : "right")
        };

        tf._xscale = Macros.FormatNumber(m_name, format, "scaleX", null, 1, 1) * 100;
        tf._yscale = Macros.FormatNumber(m_name, format, "scaleY", null, 1, 1) * 100;
        tf._alpha = Macros.FormatNumber(m_name, format, "alpha", null, 100, 100);
        tf._rotation = Macros.FormatNumber(m_name, format, "rotation", null, 0, 0);
        tf.selectable = false;
        tf.html = true;
        tf.multiline = true;
        tf.wordWrap = false;
        tf.antiAliasType = format.antiAliasType != null ? format.antiAliasType : "advanced";
        tf.autoSize = "none";
        tf.verticalAlign = format.valign != null ? format.valign : "none";
        tf.styleSheet = Utils.createStyleSheet(Utils.createCSS("extraField", 0xFFFFFF, "$FieldFont", 14, "center", false, false));

        tf.border = format.borderColor != null;
        tf.borderColor = Macros.FormatNumber(m_name, format, "borderColor", null, 0xCCCCCC, 0xCCCCCC, true);
        tf.background = format.bgColor != null;
        tf.backgroundColor = Macros.FormatNumber(m_name, format, "bgColor", null, 0x000000, 0x000000, true);
        if (tf.background && !tf.border)
        {
            format.borderColor = format.bgColor;
            tf.border = true;
            tf.borderColor = tf.backgroundColor;
        }

        if (format.shadow && format.shadow.alpha != 0 && format.shadow.strength != 0 && format.shadow.blur != 0)
        {
            var blur = format.shadow.blur != null ? format.shadow.blur : 2;
            tf.filters = [
                new DropShadowFilter(
                    format.shadow.distance != null ? format.shadow.distance : 0,
                    format.shadow.angle != null ? format.shadow.angle : 0,
                    format.shadow.color != null ? parseInt(format.shadow.color) : 0x000000,
                    format.shadow.alpha != null ? format.shadow.alpha : 0.75,
                    blur,
                    blur,
                    format.shadow.strength != null ? format.shadow.strength : 1)
            ];
        }

        cleanupFormat(tf, format);

        alignField(tf);

        return tf;
    }

    // cleanup formats without macros to remove extra checks
    private function cleanupFormat(field, format:Object)
    {
        if (format.x != null && (typeof format.x != "string" || format.x.indexOf("{{") < 0) && !format.bindToIcon)
            delete format.x;
        if (format.y != null && (typeof format.y != "string" || format.y.indexOf("{{") < 0))
            delete format.y;
        if (format.w != null && (typeof format.w != "string" || format.w.indexOf("{{") < 0))
            delete format.w;
        if (format.h != null && (typeof format.h != "string" || format.h.indexOf("{{") < 0))
            delete format.h;
        if (format.scaleX != null && (typeof format.scaleX != "string" || format.scaleX.indexOf("{{") < 0))
            delete format.scaleX;
        if (format.scaleY != null && (typeof format.scaleY != "string" || format.scaleY.indexOf("{{") < 0))
            delete format.scaleY;
        if (format.alpha != null && (typeof format.alpha != "string" || format.alpha.indexOf("{{") < 0))
            delete format.alpha;
        if (format.rotation != null && (typeof format.rotation != "string" || format.rotation.indexOf("{{") < 0))
            delete format.rotation;
        if (format.borderColor != null && (typeof format.borderColor != "string" || format.borderColor.indexOf("{{") < 0))
            delete format.borderColor;
        if (format.bgColor != null && (typeof format.bgColor != "string" || format.bgColor.indexOf("{{") < 0))
            delete format.bgColor;
    }

    private function updateExtraFields():Void
    {
        //Logger.add("updateExtraFields");
        if (extraFields == null)
            return;

        var state:String = panel.state;

        if (extraFields.none != null)    extraFields.none._visible = state == "none" && wrapper.data != null;
        if (extraFields.short != null)   extraFields.short._visible = state == "short";
        if (extraFields.medium != null)  extraFields.medium._visible = state == "medium";
        if (extraFields.medium2 != null) extraFields.medium2._visible = state == "medium2";
        if (extraFields.large != null)   extraFields.large._visible = state == "large";

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
        var value;
        var needAlign:Boolean = false;
        if (format.x != null)
        {
            value = !isNaN(format.x) ? format.x : (parseFloat(Macros.Format(m_name, format.x, obj)) || 0);
            if (format.bindToIcon)
            {
                value += isLeftPanel
                    ? panel.m_list._x + panel.m_list.width
                    : BattleState.screenSize.width - panel._x - panel.m_list._x + panel.m_list.width;
            }
            if (f.data.x != value)
            {
                f.data.x = value;
                //Logger.add("x=" + value);
                needAlign = true;
            }
        }
        if (format.y != null)
        {
            value = parseFloat(Macros.Format(m_name, format.y, obj)) || 0;
            if (f.data.y != value)
            {
                f.data.y = value;
                //Logger.add("y=" + value);
                needAlign = true;
            }
        }
        if (format.w != null)
        {
            value = parseFloat(Macros.Format(m_name, format.w, obj)) || 0;
            if (f.data.w != value)
            {
                f.data.w = value;
                //Logger.add("w=" + value);
                needAlign = true;
            }
        }
        if (format.h != null)
        {
            value = parseFloat(Macros.Format(m_name, format.h, obj)) || 0;
            if (f.data.h != value)
            {
                f.data.h = value;
                //Logger.add("h=" + value);
                needAlign = true;
            }
        }
        if (format.alpha != null)
        {
            var alpha = parseFloat(Macros.Format(m_name, format.alpha, obj));
            f._alpha = isNaN(alpha) ? 100 : alpha;
        }
        if (format.rotation != null)
            f._rotation = parseFloat(Macros.Format(m_name, format.rotation, obj)) || 0;
        if (format.scaleX != null)
            f._xscale = parseFloat(Macros.Format(m_name, format.scaleX, obj)) * 100 || 100;
        if (format.scaleY != null)
            f._yscale = parseFloat(Macros.Format(m_name, format.scaleY, obj)) * 100 || 100;
        if (format.borderColor != null)
            f.borderColor = parseInt(Macros.Format(m_name, format.borderColor, obj).split("#").join("0x")) || 0;
        if (format.bgColor != null)
            f.backgroundColor = parseInt(Macros.Format(m_name, format.bgColor, obj).split("#").join("0x")) || 0;

        if (format.format != null)
        {
            value = Macros.Format(m_name, format.format, obj);
            if (f.formattedValue != value)
            {
                f.formattedValue = value;
                f.htmlText = "<span class='extraField'>" + value + "</span>";
                //Logger.add("txt=" + value);
                needAlign = true;
            }
        }

        if (format.src != null)
        {
            //var dead = (wrapper.data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) == 0;
            //Logger.add(dead + " " + obj.dead + " " + m_name);
            var src:String = Utils.fixImgTagSrc(Macros.Format(m_name, format.src, obj));
            if (f.source != src)
            {
                //Logger.add(m_name + " " + f.source + " => " + src);
                f._visible = false;
                f.source = src;
            }

            var highlight = format.highlight;
            if (highlight != null && highlight != false)
            {
                if (typeof(format.highlight) == 'string')
                    highlight = Utils.toBool(Macros.Format(m_name, format.highlight, obj).toLowerCase(), false);
                var sn = PlayerStatus.getStatusColorSchemeNames(
                    (wrapper.data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.NOT_AVAILABLE) != 0,
                    true,
                    highlight != true ? false : wrapper.selected,
                    highlight != true ? false : wrapper.data.squad,
                    highlight != true ? false : wrapper.data.teamKiller,
                    highlight != true ? false : wrapper.data.VIP,
                    !obj.ready);
                if (sn.vehicleSchemeName != format.__last_vehicleSchemeName)
                {
                    format.__last_vehicleSchemeName = sn.vehicleSchemeName;
                    (new Transform(f)).colorTransform = this.getColorTransform(sn.vehicleSchemeName, true);
                    //Logger.add(f.source + " " + sn.vehicleSchemeName);
                }
            }
        }

        if (needAlign)
            alignField(f);
    }

    private function alignField(field)
    {
        //Logger.add("alignField");
        var tf:TextField = TextField(field);
        var img:UILoaderAlt = UILoaderAlt(field);

        var data:Object = field["data"];
        //Logger.addObject(data);

        var x:Number = isLeftPanel ? data.x : -data.x;
        var y:Number = data.y;
        var w:Number = isNaN(data.w) ? img.content._width : data.w;
        var h:Number = isNaN(data.h) ? img.content._height : data.h;

        if (tf != null)
        {
            if (tf.textWidth > 0)
                w = tf.textWidth + 4; // 2 * 2-pixel gutter
        }

        if (data.align == "right")
            x -= w;
        else if (data.align == "center")
            x -= w / 2;

        //Logger.add("x:" + x + " y:" + y + " w:" + w + " h:" + h + " align:" + data.align + " textWidth:" + tf.textWidth);

        if (tf != null)
        {
            if (tf._x != x)
                tf._x = x;
            if (tf._y != y)
                tf._y = y;
            if (tf._width != w)
                tf._width = w;
            if (tf._height != h)
                tf._height = h;
        }
        else
        {
            if (img._x != x)
                img._x = x;
            if (img._y != y)
                img._y = y;
            if (img.width != w || img.height != h)
            {
                //Logger.add(img.width + "->" + w + " " + x + " " + y + " " + m_name + " " + wrapper._name);
                img.setSize(w, h);
                img.validateNow();
            }
        }
    }

    var _savedScreenWidth = 0;
    var _savedX = 0;
    private function adjustExtraFieldsLeft(e)
    {
        if (Config.eventType != "normal")
            return;

        var state:String = e.state || panel.m_state;
        //Logger.add("adjustExtraFieldsLeft: " + state);
        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var cfg:Object = mc.cfg;
        if (cfg != null)
        {
            // none state
            switch (extraFieldsLayout)
            {
                case "horizontal":
                    mc._x = cfg.x + mc.idx * cfg.width;
                    mc._y = cfg.y;
                    break;
                default:
                    mc._x = cfg.x;
                    mc._y = cfg.y + mc.idx * cfg.height;
                    break;
            }
        }
        else
        {
            // other states
            mc._x = -panel.m_list._x;
            mc._y = 0;
        }

        if (_savedX != panel.m_list._x)
        {
            _savedX = panel.m_list._x;
            updateExtraFields();
        }
    }

    private function adjustExtraFieldsRight(e)
    {
        if (Config.eventType != "normal")
            return;

        var state:String = e.state || panel.m_state;
        //Logger.add("adjustExtraFieldsRight: " + state);
        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var cfg:Object = mc.cfg;
        if (cfg != null)
        {
            // none state
            switch (extraFieldsLayout)
            {
                case "horizontal":
                    mc._x = BattleState.screenSize.width - cfg.x - mc.idx * cfg.width;
                    mc._y = cfg.y;
                    break;
                default:
                    mc._x = BattleState.screenSize.width - cfg.x;
                    mc._y = cfg.y + mc.idx * cfg.height;
                    break;
            }
        }
        else
        {
            // other states
            mc._x = panel.m_list.width - panel.m_list._x;
            mc._y = 0;
        }
        //Logger.add(BattleState.screenSize.width + " " + panel.m_list.width + " " + panel.m_list._x);

        if (_savedScreenWidth != BattleState.screenSize.width || _savedX != panel.m_list._x)
        {
            //Logger.add('updateExtraFields');
            _savedScreenWidth = BattleState.screenSize.width;
            _savedX = panel.m_list._x;
            updateExtraFields();
        }
    }

    private static function createMouseHandler(extraPanels:MovieClip):Void
    {
        var mouseHandler:Object = new Object();
        Mouse.addListener(mouseHandler);
        mouseHandler.onMouseDown = function(button, target)
        {
            //Logger.add(target + " " + button);
            if (_root["leftPanel"].state != net.wargaming.ingame.PlayersPanel.STATES.none.name)
                return;

            if (!_root.g_cursorVisible)
                return;

            var t = null;
            for (var n in extraPanels)
            {
                var a:MovieClip = extraPanels[n];
                if (a == null)
                    continue;
                var b:MovieClip = a[PlayerListItemRenderer.MENU_MC_NAME];
                if (b == null)
                    continue;
                if (b.hitTest(_root._xmouse, _root._ymouse, true))
                {
                    t = b;
                    break;
                }
            }
            if (t == null)
                return;

            var data = t.owner.wrapper.data;
            if (data == null)
                return;

            if (button == Mouse.RIGHT)
            {
                var xmlKeyConverter = new net.wargaming.managers.XMLKeyConverter();
                net.wargaming.ingame.MinimapEntry.unhighlightLastEntry();
                var ignored = net.wargaming.messenger.MessengerUtils.isIgnored(data);
                net.wargaming.ingame.BattleContextMenuHandler.showMenu(extraPanels, data, [
                    [ { id: net.wargaming.messenger.MessengerUtils.isFriend(data) ? "removeFromFriends" : "addToFriends", disabled: !data.isEnabledInRoaming } ],
                    [ ignored ? "removeFromIgnored" : "addToIgnored" ],
                    t.panel.getDenunciationsSubmenu(xmlKeyConverter, data.denunciations, data.squad),
                    [ !ignored && _global.wg_isShowVoiceChat ? (net.wargaming.messenger.MessengerUtils.isMuted(data) ? "unsetMuted" : "setMuted") : null ]
                    ]);
            }
            else if (!net.wargaming.ingame.BattleContextMenuHandler.hitTestToCurrentMenu())
            {
                gfx.io.GameDelegate.call("Battle.selectPlayer", [data.vehId]);
            }
        }
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
  "igrType": 0,
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
