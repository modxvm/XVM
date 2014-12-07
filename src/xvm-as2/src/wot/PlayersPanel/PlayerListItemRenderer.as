/**
 * @author sirmax2
 */
import com.xvm.*;
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

    function __getColorTransform()
    {
        return this.__getColorTransformImpl.apply(this, arguments);
    }

    function setState()
    {
        return this.setStateImpl.apply(this, arguments);
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

    private var extraFields:Object;
    private var extraFieldsLayout:String;

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

    function __getColorTransformImpl(schemeName:String, force:Boolean)
    {
        //Logger.add(m_name + " scheme=" + schemeName);

        if (Config.config.battle.highlightVehicleIcon == false && !force)
        {
            if (schemeName == "selected" || schemeName == "squad")
                schemeName = "normal";
            else if (schemeName == "selected_offline" || schemeName == "squad_offline")
                schemeName = "normal_offline";
            else if (schemeName == "selected_dead" || schemeName == "squad_dead")
                schemeName = "normal_dead";
        }

        return base.__getColorTransform(schemeName);
    }

    function setStateImpl()
    {
        var savedValue = wrapper.data.isPostmortemView;
        if (Config.config.playersPanel.removeSelectedBackground)
            wrapper.data.isPostmortemView = false;
        base.setState();
        wrapper.data.isPostmortemView = savedValue;
    }

    function updateImpl()
    {
        try
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

                // Extra Text Fields
                updateExtraFields();
            }

            if (wrapper.squadIcon != null)
                wrapper.squadIcon._visible = (panel.state == "large" && !Config.config.playersPanel.removeSquadIcon);

            base.update();

            wrapper.iconLoader.content._alpha = Config.config.playersPanel.iconAlpha;

            if (data != null)
                data.icon = saved_icon;
        }
        catch (ex:Error)
        {
            Logger.addObject(ex.toString());
        }
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

    private static function get extraPanelsHolder():MovieClip
    {
        if (_root["extraPanels"] == null)
        {
            var depth:Number = -16377; // the only one free depth for panels
            _root["extraPanels"] = _root.createEmptyMovieClip("extraPanels", depth);
            createMouseHandler();
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

            updateExtraFields();
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
        PlayerInfo.setSource(m_clanIcon, wrapper.data.uid, m_name, m_clan);
        m_clanIcon["holder"]._alpha = m_dead ? 50 : 100;
    }

    // Extra fields

    private function createFieldsForNoneMode():MovieClip
    {
        try
        {
            extraFieldsLayout = Config.config.playersPanel.none.layout;
            var cfg:Object = Config.config.playersPanel.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];
            if (cfg.formats == null || cfg.formats.length <= 0)
                return null;
            var mc:MovieClip = _internal_createExtraFields(extraPanelsHolder, "none", cfg.formats, cfg.width, cfg.height, cfg);
            var menu_mc:Button = UIComponent.createInstance(mc, "HiddenButton", "menu_mc", mc.getNextHighestDepth(), {
                _x: isLeftPanel ? 0 : -cfg.width,
                width:cfg.width,
                height:cfg.height,
                panel: isLeftPanel ? _root["leftPanel"] : _root["rightPanel"],
                owner: this } );
            menu_mc.addEventListener("rollOver", wrapper, "onItemRollOver");
            menu_mc.addEventListener("rollOut", wrapper, "onItemRollOut");
            menu_mc.addEventListener("releaseOutside", wrapper, "onItemReleaseOutside");

            return mc;
        }
        catch (ex:Error)
        {
            Logger.add(ex.message);
            return null;
        }
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
        var mc:MovieClip = owner.createEmptyMovieClip("extraField_" + team + "_" + mode + "_" + idx, owner.getNextHighestDepth());
        mc._visible = false;
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
            {
                format = { format: format };
                formats[i] = format;
            }

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

            if (fmt.src != null)
                createExtraMovieClip(mc, fmt, mc.formats.length - 1);
            else
                createExtraTextField(mc, fmt, mc.formats.length - 1, width, height);
        }

        return mc;
    }

    private function createExtraMovieClip(mc:MovieClip, format:Object, n:Number)
    {
        //Logger.addObject(format);
        var x:Number = format.x != null && !isNaN(format.x) ? format.x : 0;
        var y:Number = format.y != null && !isNaN(format.y) ? format.y : 0;
        var w:Number = format.w != null && !isNaN(format.w) ? format.w : NaN;
        var h:Number = format.h != null && !isNaN(format.h) ? format.h : NaN;

        var img:UILoaderAlt = (UILoaderAlt)(mc.attachMovie("UILoaderAlt", "f" + n, mc.getNextHighestDepth()));
        img["data"] = {
            x: x, y: y, w: w, h: h,
            format: format,
            align: format.align != null ? format.align : (isLeftPanel ? "left" : "right"),
            scaleX: format.scaleX != null && !isNaN(format.scaleX) ? format.scaleX * 100 : 100,
            scaleY: format.scaleY != null && !isNaN(format.scaleY) ? format.scaleY * 100 : 100
        };
        //Logger.addObject(img["data"]);

        img._alpha = format.alpha != null && !isNaN(format.alpha) ? format.alpha : 100;
        img._rotation = format.rotation != null && !isNaN(format.rotation) ? format.rotation : 0;
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
        var x:Number = format.x != null && !isNaN(format.x) ? format.x : 0;
        var y:Number = format.y != null && !isNaN(format.y) ? format.y : 0;
        var w:Number = format.w != null && !isNaN(format.w) ? format.w : defW;
        var h:Number = format.h != null  && !isNaN(format.h) ? format.h : defH;
        var tf:TextField = mc.createTextField("f" + n, n, 0, 0, 0, 0);
        tf.data = {
            x: x, y: y, w: w, h: h,
            align: format.align != null ? format.align : (isLeftPanel ? "left" : "right")
        };

        tf._alpha = format.alpha != null && !isNaN(format.alpha) ? format.alpha : 100;
        tf._rotation = format.rotation != null && !isNaN(format.rotation) ? format.rotation : 0;
        tf._xscale = format.scaleX != null && !isNaN(format.scaleX) ? format.scaleX * 100 : 100;
        tf._yscale = format.scaleY != null && !isNaN(format.scaleY) ? format.scaleY * 100 : 100;
        tf.selectable = false;
        tf.html = true;
        tf.multiline = true;
        tf.wordWrap = false;
        tf.antiAliasType = format.antiAliasType != null ? format.antiAliasType : "advanced";
        tf.autoSize = "none";
        tf.verticalAlign = format.valign != null ? format.valign : "none";
        tf.styleSheet = Utils.createStyleSheet(Utils.createCSS("extraField", 0xFFFFFF, "$FieldFont", 14, "center", false, false));

        tf.border = format.borderColor != null;
        tf.borderColor = format.borderColor != null && !isNaN(format.borderColor) ? format.borderColor : 0xCCCCCC;
        tf.background = format.bgColor != null;
        tf.backgroundColor = format.bgColor != null && !isNaN(format.bgColor) ? format.bgColor : 0x000000;
        if (tf.background && !tf.border)
        {
            format.borderColor = format.bgColor;
            tf.border = true;
            tf.borderColor = tf.backgroundColor;
        }

        if (format.shadow != null)
        {
            tf.filters = [
                new DropShadowFilter(
                    format.shadow.distance != null ? format.shadow.distance : 0,
                    format.shadow.angle != null ? format.shadow.angle : 45,
                    format.shadow.color != null ? parseInt(format.shadow.color) : 0x000000,
                    format.shadow.alpha != null ? format.shadow.alpha : 1,
                    format.shadow.blur != null ? format.shadow.blur : 4,
                    format.shadow.blur != null ? format.shadow.blur : 4,
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
        if (format.alpha != null && (typeof format.alpha != "string" || format.alpha.indexOf("{{") < 0))
            delete format.alpha;
        if (format.rotation != null && (typeof format.rotation != "string" || format.rotation.indexOf("{{") < 0))
            delete format.rotation;
        if (format.scaleX != null && (typeof format.scaleX != "string" || format.scaleX.indexOf("{{") < 0))
            delete format.scaleX;
        if (format.scaleY != null && (typeof format.scaleY != "string" || format.scaleY.indexOf("{{") < 0))
            delete format.scaleY;
        if (format.borderColor != null && (typeof format.borderColor != "string" || format.borderColor.indexOf("{{") < 0))
            delete format.borderColor;
        if (format.bgColor != null && (typeof format.bgColor != "string" || format.bgColor.indexOf("{{") < 0))
            delete format.bgColor;
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
            f.data.x = parseFloat(Macros.Format(m_name, format.x, obj)) || 0;
            if (format.bindToIcon)
                f.data.x += isLeftPanel ? panel.m_list._x + panel.m_list.width : BattleState.screenSize.width - panel._x - panel.m_list._x + panel.m_list.width;

            needAlign = true;
        }
        if (format.y != null)
        {
            f.data.y = parseFloat(Macros.Format(m_name, format.y, obj)) || 0;
            needAlign = true;
        }
        if (format.w != null)
        {
            f.data.w = parseFloat(Macros.Format(m_name, format.w, obj)) || 0;
            needAlign = true;
        }
        if (format.h != null)
        {
            f.data.h = parseFloat(Macros.Format(m_name, format.h, obj)) || 0;
            needAlign = true;
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
            var txt:String = Macros.Format(m_name, format.format, obj);
            //Logger.add(m_name + " " + txt);
            f.htmlText = "<span class='extraField'>" + txt + "</span>";
            //if (format.format.indexOf("{{") < 0) // TODO
            //    delete format.format;
            needAlign = true;
        }

        if (format.src != null)
        {
            //var dead = (wrapper.data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) == 0;
            //Logger.add(dead + " " + obj.dead + " " + m_name);
            var src:String = Macros.Format(m_name, format.src, obj);
            if (Strings.startsWith("img://gui/maps/icons/", src.toLowerCase()))
                src = "../" + Utils.fixImgTag(src).slice(10);
            else
                src = "../../" + Utils.fixImgTag(src).split("img://").join("");
            if (f.source != src)
            {
                //Logger.add(m_name + " " + f.source + " => " + src);
                f._visible = false;
                f.source = src;
            }

            if (format.highlight == true)
            {
                var state = wrapper.data.vehicleState;
                var sn = PlayerStatus.getStatusColorSchemeNames(
                    (state & net.wargaming.ingame.VehicleStateInBattle.NOT_AVAILABLE) != 0,
                    !obj.dead,
                    wrapper.selected,
                    wrapper.data.squad,
                    wrapper.data.teamKiller,
                    wrapper.data.VIP,
                    !obj.ready);
                if (sn.vehicleSchemeName != format.__last_vehicleSchemeName)
                {
                    format.__last_vehicleSchemeName = sn.vehicleSchemeName;
                    (new Transform(f)).colorTransform = this.__getColorTransform(sn.vehicleSchemeName, true);
                    //Logger.add(f.source + " " + sn.vehicleSchemeName);
                }
            }
        }

        if (needAlign)
            alignField(f);
    }

    private function alignField(field)
    {
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
        //Logger.add("adjustExtraFieldsLeft: " + e.state);
        var state:String = e.state;
        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var cfg = mc.cfg;
        if (cfg != null)
        {
            // none mode
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
            // other modes
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
        //Logger.add("adjustExtraFieldsRight: " + e.state);
        var state:String = e.state;
        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var cfg = mc.cfg;
        if (cfg != null)
        {
            // none mode
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
            // other modes
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

    private static function createMouseHandler():Void
    {
        var mouseHandler:Object = new Object();
        Mouse.addListener(mouseHandler);
        mouseHandler.onMouseDown = function(button, target)
        {
            //Logger.add(target + " " + button);
            if (_root["leftPanel"].state != net.wargaming.ingame.PlayersPanel.STATES.none.name)
                return;

            var extraPanels:MovieClip = _root["extraPanels"];
            var t = null;
            for (var n in extraPanels)
            {
                var a:MovieClip = extraPanels[n];
                if (a == null)
                    continue;
                var b:MovieClip = a["menu_mc"];
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
                if (_root.g_cursorVisible)
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
