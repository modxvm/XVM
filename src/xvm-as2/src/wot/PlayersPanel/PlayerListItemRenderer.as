// AS3:DONE /**
// AS3:DONE  * XVM
// AS3:DONE  * @author Maxim Schedriviy <max(at)modxvm.com>
// AS3:DONE  */
// AS3:DONE import com.xvm.*;
// AS3:DONE import com.xvm.DataTypes.*;
// AS3:DONE import com.xvm.events.*;
// AS3:DONE import flash.filters.*;
// AS3:DONE import flash.geom.*;
// AS3:DONE import gfx.core.*;
// AS3:DONE import gfx.controls.*;
// AS3:DONE import net.wargaming.*;
// AS3:DONE import net.wargaming.controls.*;
// AS3:DONE import net.wargaming.managers.*;
// AS3:DONE import net.wargaming.ingame.*;
// AS3:DONE import wot.Minimap.*;
// AS3:DONE import wot.PlayersPanel.*;
// AS3:DONE
// AS3:DONE class wot.PlayersPanel.PlayerListItemRenderer
// AS3:DONE {
// AS3:DONE     /////////////////////////////////////////////////////////////////
// AS3:DONE     // wrapped methods
// AS3:DONE
// AS3:DONE     public var wrapper:net.wargaming.ingame.PlayerListItemRenderer;
// AS3:DONE     private var base:net.wargaming.ingame.PlayerListItemRenderer;
// AS3:DONE
// AS3:DONE     public function PlayerListItemRenderer(wrapper:net.wargaming.ingame.PlayerListItemRenderer, base:net.wargaming.ingame.PlayerListItemRenderer)
// AS3:DONE     {
// AS3:DONE         this.wrapper = wrapper;
// AS3:DONE         this.base = base;
// AS3:DONE         wrapper.xvm_worker = this;
// AS3:DONE         PlayerListItemRendererCtor();
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function getColorTransform()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.getColorTransform.apply(base, arguments);
// AS3:DONE         return this.getColorTransformImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function setState()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.setState.apply(base, arguments);
// AS3:DONE         return this.setStateImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function update()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.update.apply(base, arguments);
// AS3:DONE         return this.updateImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function updateSquadIcons()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.updateSquadIcons.apply(base, arguments);
// AS3:DONE         return this.updateSquadIconsImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     // wrapped methods
// AS3:DONE     /////////////////////////////////////////////////////////////////

    public static var MENU_MC_NAME = "menu_mc";

// AS3:DONE     private static var TF_DEFAULT_WIDTH = 300;
// AS3:DONE     private static var TF_DEFAULT_HEIGHT = 25;

    private var cfg:Object;

    private var _initialized:Boolean = false;

    private var m_playerId:Number = 0;
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

// AS3:DONE     public function PlayerListItemRendererCtor()
// AS3:DONE     {
// AS3:DONE         Utils.TraceXvmModule("PlayersPanel");
// AS3:DONE
// AS3:DONE         if (wrapper._name == "renderer99")
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         extraFields = null;
// AS3:DONE         extraFieldsConfigured = false;
// AS3:DONE
// AS3:DONE         GlobalEventDispatcher.addEventListener(Events.E_CONFIG_LOADED, this, onConfigLoaded);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     // IMPL
// AS3:DONE
// AS3:DONE     function getColorTransformImpl(schemeName:String, force:Boolean)
// AS3:DONE     {
// AS3:DONE         if (Config.config.battle.highlightVehicleIcon == false && !force)
// AS3:DONE         {
// AS3:DONE             if (schemeName == "selected" || schemeName == "squad")
// AS3:DONE                 schemeName = "normal";
// AS3:DONE             else if (schemeName == "selected_offline" || schemeName == "squad_offline")
// AS3:DONE                 schemeName = "normal_offline";
// AS3:DONE             else if (schemeName == "selected_dead" || schemeName == "squad_dead")
// AS3:DONE                 schemeName = "normal_dead";
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         return base.getColorTransform(schemeName);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function setStateImpl()
// AS3:DONE     {
// AS3:DONE         var savedValue = wrapper.data.isPostmortemView;
// AS3:DONE
// AS3:DONE         if (Macros.FormatGlobalBooleanValue(cfg.removeSelectedBackground))
// AS3:DONE             wrapper.data.isPostmortemView = false;
// AS3:DONE
// AS3:DONE         base.setState();
// AS3:DONE
// AS3:DONE         if (wrapper.vehicleLevel != null)
// AS3:DONE             wrapper.vehicleLevel._alpha *= panel.state == "none" ? 0 : cfg[panel.state].vehicleLevelAlpha / 100.0;
// AS3:DONE
// AS3:DONE         wrapper.data.isPostmortemView = savedValue;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function updateImpl()
// AS3:DONE     {
// AS3:DONE         try
// AS3:DONE         {
// AS3:DONE             var data:Object = wrapper.data;
// AS3:DONE             //Logger.add("update: " + (data ? data.userName : "(null)"))
// AS3:DONE             //Logger.addObject(data);
// AS3:DONE
// AS3:DONE             var saved_icon:String;
// AS3:DONE             if (data == null)
// AS3:DONE             {
// AS3:DONE                 m_playerId = 0
// AS3:DONE                 m_name = null;
// AS3:DONE                 m_clan = null;
// AS3:DONE                 m_vehicleState = 0;
// AS3:DONE                 m_dead = true;
// AS3:DONE                 if (extraFields != null)
// AS3:DONE                     extraFields.none._visible = false;
// AS3:DONE             }
// AS3:DONE             else
// AS3:DONE             {
// AS3:DONE                 m_playerId = data.uid;
// AS3:DONE                 m_name = data.userName;
// AS3:DONE                 m_clan = data.clanAbbrev;
// AS3:DONE                 m_vehicleState = data.vehicleState;
// AS3:DONE                 m_dead = (data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) == 0;
// AS3:DONE
// AS3:DONE                 saved_icon = data.icon;
// AS3:DONE
// AS3:DONE                 // Alternative icon set
// AS3:DONE                 if (!m_iconset)
// AS3:DONE                     m_iconset = new IconLoader(this, completeLoad);
// AS3:DONE                 m_iconset.init(wrapper.iconLoader,
// AS3:DONE                     [ wrapper.data.icon.split(Defines.WG_CONTOUR_ICON_PATH).join(Defines.XVMRES_ROOT +
// AS3:DONE                     (isLeftPanel
// AS3:DONE                         ? Config.config.iconset.playersPanelAlly
// AS3:DONE                         : Config.config.iconset.playersPanelEnemy)),
// AS3:DONE                     saved_icon ]);
// AS3:DONE                 data.icon = m_iconset.currentIcon;
// AS3:DONE 
// AS3:DONE                 // Player/clan icons
// AS3:DONE                 attachClanIconToPlayer();
// AS3:DONE 
// AS3:DONE                 // Extra fields
// AS3:DONE                 if (Stat.s_loaded)
// AS3:DONE                 {
// AS3:DONE                     if (!extraFieldsConfigured)
// AS3:DONE                         configureExtraFields();
// AS3:DONE                     updateExtraFields();
// AS3:DONE                 }
// AS3:DONE             }
// AS3:DONE 
            if (wrapper.squadIcon != null)
                wrapper.squadIcon._visible = (panel.state != "none" && !cfg[panel.state].removeSquadIcon);
// AS3:DONE 
// AS3:DONE             base.update();
// AS3:DONE 
// AS3:DONE             wrapper.iconLoader.content._alpha = cfg.iconAlpha;
// AS3:DONE 
// AS3:DONE             if (data != null)
// AS3:DONE                 data.icon = saved_icon;
// AS3:DONE         }
// AS3:DONE         catch (ex:Error)
// AS3:DONE         {
// AS3:DONE             Logger.addObject(ex.toString());
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE 
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

// AS3:DONE     // PRIVATE
// AS3:DONE 
// AS3:DONE     // properties
// AS3:DONE 
// AS3:DONE     private var _team:Number = 0;
// AS3:DONE 
// AS3:DONE     private function get team():Number
// AS3:DONE     {
// AS3:DONE         if (_team == 0)
// AS3:DONE             _team = wrapper._parent._parent._itemRenderer == "LeftItemRendererIcon" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
// AS3:DONE         return _team;
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function get isLeftPanel():Boolean
// AS3:DONE     {
// AS3:DONE         return team == Defines.TEAM_ALLY;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private var _panel:net.wargaming.ingame.PlayersPanel = null;
// AS3:DONE     private function get panel():net.wargaming.ingame.PlayersPanel
// AS3:DONE     {
// AS3:DONE         if (_panel == null)
// AS3:DONE             _panel = net.wargaming.ingame.PlayersPanel(wrapper._parent._parent._parent);
// AS3:DONE         return _panel;
// AS3:DONE     }

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

// AS3:DONE     private function init()
// AS3:DONE     {
// AS3:DONE         if (_initialized)
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         _initialized = true;
// AS3:DONE
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         GlobalEventDispatcher.addEventListener(Events.E_STAT_LOADED, this, onStatLoaded);
// AS3:DONE
// AS3:DONE         if (isLeftPanel)
// AS3:DONE         {
// AS3:DONE             GlobalEventDispatcher.addEventListener(Events.E_UPDATE_STAGE, this, adjustExtraFieldsLeft);
// AS3:DONE             GlobalEventDispatcher.addEventListener(Events.E_LEFT_PANEL_SIZE_ADJUSTED, this, adjustExtraFieldsLeft);
// AS3:DONE         }
// AS3:DONE         else
// AS3:DONE         {
// AS3:DONE             GlobalEventDispatcher.addEventListener(Events.E_UPDATE_STAGE, this, adjustExtraFieldsRight);
// AS3:DONE             GlobalEventDispatcher.addEventListener(Events.E_RIGHT_PANEL_SIZE_ADJUSTED, this, adjustExtraFieldsRight);
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function onConfigLoaded()
// AS3:DONE     {
// AS3:DONE         //Logger.add(Config.arenaGuiType);
// AS3:DONE
// AS3:DONE         init();
// AS3:DONE
// AS3:DONE         try
// AS3:DONE         {
// AS3:DONE             this.cfg = Config.config.playersPanel;
// AS3:DONE
// AS3:DONE             //Logger.add("onConfigLoaded: " + m_name);
// AS3:DONE             if (extraFields == null)
// AS3:DONE             {
// AS3:DONE                 extraFields = {
// AS3:DONE                     none:    createFieldsHolderForNoneState(),
// AS3:DONE                     short:   createExtraFieldsHolder("short"),
// AS3:DONE                     medium:  createExtraFieldsHolder("medium"),
// AS3:DONE                     medium2: createExtraFieldsHolder("medium2"),
// AS3:DONE                     large:   createExtraFieldsHolder("large")
// AS3:DONE                 };
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             extraFieldsConfigured = false;
// AS3:DONE             if (m_name)
// AS3:DONE                 configureExtraFields();
// AS3:DONE         }
// AS3:DONE         catch (ex:Error)
// AS3:DONE         {
// AS3:DONE             Logger.add(ex.toString());
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function onStatLoaded()
// AS3:DONE     {
// AS3:DONE         update();
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function completeLoad()
// AS3:DONE     {
// AS3:DONE         if (m_iconLoaded)
// AS3:DONE             return;
// AS3:DONE         m_iconLoaded = true;
// AS3:DONE
// AS3:DONE         mirrorEnemyIcons();
// AS3:DONE
// AS3:DONE         wrapper.iconLoader._visible = true;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function mirrorEnemyIcons():Void
// AS3:DONE     {
// AS3:DONE         if (!Config.config.battle.mirroredVehicleIcons && !isLeftPanel)
// AS3:DONE         {
// AS3:DONE             wrapper.iconLoader._xscale = -wrapper.iconLoader._xscale;
// AS3:DONE             wrapper.iconLoader._x -= 80;
// AS3:DONE             wrapper.vehicleLevel._x = wrapper.iconLoader._x + 15;
// AS3:DONE
// AS3:DONE             updateExtraFields();
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function attachClanIconToPlayer():Void
// AS3:DONE     {
// AS3:DONE         var clanIconCfg:Object = cfg.clanIcon;
// AS3:DONE         if (!clanIconCfg.show)
// AS3:DONE             return;
// AS3:DONE 
// AS3:DONE         var statData:Object = Stat.s_data[m_name];
// AS3:DONE         if (statData == null)
// AS3:DONE             return;
// AS3:DONE         var x_emblem:String = (statData == null && statData.stat != null) ? null : statData.stat.x_emblem;
// AS3:DONE 
// AS3:DONE         if (m_clanIcon == null)
// AS3:DONE         {
// AS3:DONE             var x = (!m_iconLoaded || Config.config.battle.mirroredVehicleIcons || isLeftPanel)
// AS3:DONE                 ? wrapper.iconLoader._x : wrapper.iconLoader._x + 80;
// AS3:DONE             m_clanIcon = PlayerInfo.createIcon(wrapper, "clanicon", clanIconCfg, x, wrapper.iconLoader._y, team);
// AS3:DONE         }
// AS3:DONE         PlayerInfo.setSource(m_clanIcon, wrapper.data.uid, m_name, m_clan, x_emblem);
// AS3:DONE         m_clanIcon["holder"]._alpha = m_dead ? 50 : 100;
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     // Extra fields
// AS3:DONE
// AS3:DONE     private function createFieldsHolderForNoneState():MovieClip
// AS3:DONE     {
// AS3:DONE         extraFieldsLayout = cfg.none.layout;
// AS3:DONE         var cfg_xf:Object = cfg.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];
// AS3:DONE
// AS3:DONE         var mc:MovieClip = _internal_createExtraFieldsHolder(extraPanelsHolder, "none", cfg_xf.formats, cfg_xf);
// AS3:DONE         mc._visible = false;
// AS3:DONE
// AS3:DONE         return mc;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function createExtraFieldsHolder(state:String):MovieClip
// AS3:DONE     {
// AS3:DONE         var formats:Array = cfg[state]["extraFields" + (isLeftPanel ? "Left" : "Right")];
// AS3:DONE         return _internal_createExtraFieldsHolder(wrapper, state, formats, null);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _internal_createExtraFieldsHolder(owner:MovieClip, state:String, formats:Array, cfg:Object):MovieClip
// AS3:DONE     {
// AS3:DONE         var idx = parseInt(wrapper._name.split("renderer").join(""));
// AS3:DONE         var mc:MovieClip = owner.createEmptyMovieClip("extraField_" + team + "_" + state + "_" + idx, owner.getNextHighestDepth());
// AS3:DONE         mc._visible = false;
// AS3:DONE         mc.idx = idx;
// AS3:DONE         mc.orig_formats = formats;
// AS3:DONE         mc.cfg = cfg;
// AS3:DONE         return mc;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function configureExtraFields()
// AS3:DONE     {
// AS3:DONE         try
// AS3:DONE         {
// AS3:DONE             //Logger.add("configureExtraFields: " + m_name);
// AS3:DONE
// AS3:DONE             if (extraFields == null)
// AS3:DONE             {
// AS3:DONE                 Logger.add("WARNING: extraFields == null");
// AS3:DONE                 return;
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             if (extraFieldsConfigured)
// AS3:DONE                 return;
// AS3:DONE
// AS3:DONE             extraFieldsConfigured = true;
// AS3:DONE
// AS3:DONE             // remove old text fields
// AS3:DONE             Utils.removeChildren(extraFields.none);
// AS3:DONE             Utils.removeChildren(extraFields.short);
// AS3:DONE             Utils.removeChildren(extraFields.medium);
// AS3:DONE             Utils.removeChildren(extraFields.medium2);
// AS3:DONE             Utils.removeChildren(extraFields.large);
// AS3:DONE
// AS3:DONE             var cf:Object = cfg.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];
// AS3:DONE             _internal_createExtraFields("none", cf.width, cf.height);
// AS3:DONE             _internal_createExtraFields("short", TF_DEFAULT_WIDTH, TF_DEFAULT_HEIGHT);
// AS3:DONE             _internal_createExtraFields("medium", TF_DEFAULT_WIDTH, TF_DEFAULT_HEIGHT);
// AS3:DONE             _internal_createExtraFields("medium2", TF_DEFAULT_WIDTH, TF_DEFAULT_HEIGHT);
// AS3:DONE             _internal_createExtraFields("large", TF_DEFAULT_WIDTH, TF_DEFAULT_HEIGHT);
// AS3:DONE         }
// AS3:DONE         catch (ex:Error)
// AS3:DONE         {
// AS3:DONE             Logger.add(ex.message);
// AS3:DONE             return null;
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _internal_createExtraFields(state:String, width:Number, height:Number)
// AS3:DONE     {
// AS3:DONE         //Logger.add("_internal_createExtraFields: " + state);
// AS3:DONE         var mc:MovieClip = extraFields[state];
// AS3:DONE         if (mc == null)
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         var formats:Array = mc.orig_formats;
// AS3:DONE         if (formats == null || formats.length <= 0)
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         mc.formats = [];
// AS3:DONE         var n:Number = 0;
// AS3:DONE         var len:Number = formats.length;
// AS3:DONE         for (var i:Number = 0; i < len; ++i)
// AS3:DONE         {
// AS3:DONE             var format = formats[i];
// AS3:DONE
// AS3:DONE             if (format == null)
// AS3:DONE                 continue;
// AS3:DONE
// AS3:DONE             if (typeof format == "string")
// AS3:DONE             {
// AS3:DONE                 format = { format: format };
// AS3:DONE                 formats[i] = format;
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             if (typeof format != "object")
// AS3:DONE                 continue;
// AS3:DONE
// AS3:DONE             var isEmpty:Boolean = true;
// AS3:DONE             for (var nm in format)
// AS3:DONE             {
// AS3:DONE                 isEmpty = false;
// AS3:DONE                 break;
// AS3:DONE             }
// AS3:DONE             if (isEmpty)
// AS3:DONE                 continue;
// AS3:DONE
// AS3:DONE             if (format.enabled != null)
// AS3:DONE             {
// AS3:DONE                 var enabled:Boolean = Macros.FormatGlobalBooleanValue(format.enabled);
// AS3:DONE                 if (enabled == false)
// AS3:DONE                     continue;
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             // make a copy of format, because it will be changed
// AS3:DONE             var fmt:Object = { };
// AS3:DONE             for (var nm in format)
// AS3:DONE                 fmt[nm] = format[nm];
// AS3:DONE             mc.formats.push(fmt);
// AS3:DONE
// AS3:DONE             if (fmt.src != null)
// AS3:DONE             {
// AS3:DONE                 createExtraMovieClip(mc, fmt, n);
// AS3:DONE             }
// AS3:DONE             else
// AS3:DONE             {
// AS3:DONE                 createExtraTextField(mc, fmt, n, width, height);
// AS3:DONE             }
// AS3:DONE             n++;
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         if (state == "none")
// AS3:DONE             _internal_createMenuForNoneState(mc);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _internal_createMenuForNoneState(mc:MovieClip)
// AS3:DONE     {
// AS3:DONE         var cf:Object = cfg.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];
// AS3:DONE         if (cf.formats == null || cf.formats.length <= 0)
// AS3:DONE             return;
// AS3:DONE         var menu_mc:UIComponent = UIComponent.createInstance(mc, "HiddenButton", MENU_MC_NAME, mc.getNextHighestDepth(), {
// AS3:DONE             _x: isLeftPanel ? 0 : -cf.width,
// AS3:DONE             width: cf.width,
// AS3:DONE             height: cf.height,
// AS3:DONE             panel: isLeftPanel ? _root["leftPanel"] : _root["rightPanel"],
// AS3:DONE             owner: this } );
// AS3:DONE         menu_mc.addEventListener("rollOver", wrapper, "onItemRollOver");
// AS3:DONE         menu_mc.addEventListener("rollOut", wrapper, "onItemRollOut");
// AS3:DONE         menu_mc.addEventListener("releaseOutside", wrapper, "onItemReleaseOutside");
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function createExtraMovieClip(mc:MovieClip, format:Object, n:Number)
// AS3:DONE     {
// AS3:DONE         //Logger.addObject(format);
// AS3:DONE         var x:Number = Macros.FormatNumber(m_name, format, "x", null, 0, 0);
// AS3:DONE         var y:Number = Macros.FormatNumber(m_name, format, "y", null, 0, 0);
// AS3:DONE         var w:Number = Macros.FormatNumber(m_name, format, "w", null, NaN, 0);
// AS3:DONE         var h:Number = Macros.FormatNumber(m_name, format, "h", null, NaN, 0);
// AS3:DONE
// AS3:DONE         var img:UILoaderAlt = (UILoaderAlt)(mc.attachMovie("UILoaderAlt", "f" + n, mc.getNextHighestDepth()));
// AS3:DONE         img["data"] = {
// AS3:DONE             x: x, y: y, w: w, h: h,
// AS3:DONE             format: format,
// AS3:DONE             align: format.align != null ? format.align : (isLeftPanel ? "left" : "right"),
// AS3:DONE             scaleX: Macros.FormatNumber(m_name, format, "scaleX", null, 1, 1) * 100,
// AS3:DONE             scaleY: Macros.FormatNumber(m_name, format, "scaleY", null, 1, 1) * 100
// AS3:DONE         };
// AS3:DONE         //Logger.addObject(img["data"]);
// AS3:DONE
// AS3:DONE         img._alpha = Macros.FormatNumber(m_name, format, "alpha", null, 100, 100);
// AS3:DONE         img._rotation = Macros.FormatNumber(m_name, format, "rotation", null, 0, 0);
// AS3:DONE         img.autoSize = true;
// AS3:DONE         img.maintainAspectRatio = false;
// AS3:DONE         var me = this;
// AS3:DONE         img.visible = false;
// AS3:DONE         img.onLoadInit = function() { me.onExtraMovieClipLoadInit(img); }
// AS3:DONE
// AS3:DONE         cleanupFormat(img, format);
// AS3:DONE
// AS3:DONE         return img;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function onExtraMovieClipLoadInit(img:UILoaderAlt)
// AS3:DONE     {
// AS3:DONE         //Logger.add("onExtraMovieClipLoadInit: " + m_name + " " + img.source);
// AS3:DONE
// AS3:DONE         var data = img["data"];
// AS3:DONE         //Logger.addObject(data, 2, m_name);
// AS3:DONE
// AS3:DONE         img.visible = false;
// AS3:DONE         img._x = 0;
// AS3:DONE         img._y = 0;
// AS3:DONE         img.width = 0;
// AS3:DONE         img.height = 0;
// AS3:DONE         img._xscale = data.scaleX;
// AS3:DONE         img._yscale = data.scaleY;
// AS3:DONE         alignField(img);
// AS3:DONE
// AS3:DONE         _global.setTimeout(function() { img.visible = true; }, 1);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function createExtraTextField(mc:MovieClip, format:Object, n:Number, defW:Number, defH:Number)
// AS3:DONE     {
// AS3:DONE         //Logger.addObject(format);
// AS3:DONE         var x:Number = Macros.FormatNumber(m_name, format, "x", null, 0, 0);
// AS3:DONE         var y:Number = Macros.FormatNumber(m_name, format, "y", null, 0, 0);
// AS3:DONE         var w:Number = Macros.FormatNumber(m_name, format, "w", null, defW, 0);
// AS3:DONE         var h:Number = Macros.FormatNumber(m_name, format, "h", null, defH, 0);
// AS3:DONE         var tf:TextField = mc.createTextField("f" + n, n, 0, 0, 0, 0);
// AS3:DONE         tf.data = {
// AS3:DONE             x: x, y: y, w: w, h: h,
// AS3:DONE             align: format.align != null ? format.align : (isLeftPanel ? "left" : "right")
// AS3:DONE         };
// AS3:DONE
// AS3:DONE         tf._xscale = Macros.FormatNumber(m_name, format, "scaleX", null, 1, 1) * 100;
// AS3:DONE         tf._yscale = Macros.FormatNumber(m_name, format, "scaleY", null, 1, 1) * 100;
// AS3:DONE         tf._alpha = Macros.FormatNumber(m_name, format, "alpha", null, 100, 100);
// AS3:DONE         tf._rotation = Macros.FormatNumber(m_name, format, "rotation", null, 0, 0);
// AS3:DONE         tf.selectable = false;
// AS3:DONE         tf.html = true;
// AS3:DONE         tf.multiline = true;
// AS3:DONE         tf.wordWrap = false;
// AS3:DONE         tf.antiAliasType = format.antiAliasType != null ? format.antiAliasType : "advanced";
// AS3:DONE         tf.autoSize = "none";
// AS3:DONE         tf.verticalAlign = format.valign != null ? format.valign : "none";
// AS3:DONE         tf.styleSheet = Utils.createStyleSheet(Utils.createCSS("extraField", 0xFFFFFF, "$FieldFont", 14, "center", false, false));
// AS3:DONE
// AS3:DONE         tf.border = format.borderColor != null;
// AS3:DONE         tf.borderColor = Macros.FormatNumber(m_name, format, "borderColor", null, 0xCCCCCC, 0xCCCCCC, true);
// AS3:DONE         tf.background = format.bgColor != null;
// AS3:DONE         tf.backgroundColor = Macros.FormatNumber(m_name, format, "bgColor", null, 0x000000, 0x000000, true);
// AS3:DONE         if (tf.background && !tf.border)
// AS3:DONE         {
// AS3:DONE             format.borderColor = format.bgColor;
// AS3:DONE             tf.border = true;
// AS3:DONE             tf.borderColor = tf.backgroundColor;
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         if (format.shadow && format.shadow.alpha != 0 && format.shadow.strength != 0 && format.shadow.blur != 0)
// AS3:DONE         {
// AS3:DONE             var blur = format.shadow.blur != null ? format.shadow.blur : 2;
// AS3:DONE             tf.filters = [
// AS3:DONE                 new DropShadowFilter(
// AS3:DONE                     format.shadow.distance != null ? format.shadow.distance : 0,
// AS3:DONE                     format.shadow.angle != null ? format.shadow.angle : 0,
// AS3:DONE                     format.shadow.color != null ? parseInt(format.shadow.color) : 0x000000,
// AS3:DONE                     format.shadow.alpha != null ? format.shadow.alpha / 100.0 : 0.75,
// AS3:DONE                     blur,
// AS3:DONE                     blur,
// AS3:DONE                     format.shadow.strength != null ? format.shadow.strength : 1)
// AS3:DONE             ];
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         cleanupFormat(tf, format);
// AS3:DONE
// AS3:DONE         alignField(tf);
// AS3:DONE
// AS3:DONE         return tf;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     // cleanup formats without macros to remove extra checks
// AS3:DONE     private function cleanupFormat(field, format:Object)
// AS3:DONE     {
// AS3:DONE         if (format.x != null && (typeof format.x != "string" || format.x.indexOf("{{") < 0) && !format.bindToIcon)
// AS3:DONE             delete format.x;
// AS3:DONE         if (format.y != null && (typeof format.y != "string" || format.y.indexOf("{{") < 0))
// AS3:DONE             delete format.y;
// AS3:DONE         if (format.w != null && (typeof format.w != "string" || format.w.indexOf("{{") < 0))
// AS3:DONE             delete format.w;
// AS3:DONE         if (format.h != null && (typeof format.h != "string" || format.h.indexOf("{{") < 0))
// AS3:DONE             delete format.h;
// AS3:DONE         if (format.scaleX != null && (typeof format.scaleX != "string" || format.scaleX.indexOf("{{") < 0))
// AS3:DONE             delete format.scaleX;
// AS3:DONE         if (format.scaleY != null && (typeof format.scaleY != "string" || format.scaleY.indexOf("{{") < 0))
// AS3:DONE             delete format.scaleY;
// AS3:DONE         if (format.alpha != null && (typeof format.alpha != "string" || format.alpha.indexOf("{{") < 0))
// AS3:DONE             delete format.alpha;
// AS3:DONE         if (format.rotation != null && (typeof format.rotation != "string" || format.rotation.indexOf("{{") < 0))
// AS3:DONE             delete format.rotation;
// AS3:DONE         if (format.borderColor != null && (typeof format.borderColor != "string" || format.borderColor.indexOf("{{") < 0))
// AS3:DONE             delete format.borderColor;
// AS3:DONE         if (format.bgColor != null && (typeof format.bgColor != "string" || format.bgColor.indexOf("{{") < 0))
// AS3:DONE             delete format.bgColor;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function updateExtraFields():Void
// AS3:DONE     {
// AS3:DONE         //Logger.add("updateExtraFields");
// AS3:DONE         if (extraFields == null)
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         var state:String = panel.state;
// AS3:DONE
// AS3:DONE         if (extraFields.none != null)    extraFields.none._visible = state == "none" && wrapper.data != null;
// AS3:DONE         if (extraFields.short != null)   extraFields.short._visible = state == "short";
// AS3:DONE         if (extraFields.medium != null)  extraFields.medium._visible = state == "medium";
// AS3:DONE         if (extraFields.medium2 != null) extraFields.medium2._visible = state == "medium2";
// AS3:DONE         if (extraFields.large != null)   extraFields.large._visible = state == "large";
// AS3:DONE
// AS3:DONE         var mc:MovieClip = extraFields[state];
// AS3:DONE         if (mc == null)
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         var obj = BattleState.get(m_playerId);
// AS3:DONE         var formats:Array = mc.formats;
// AS3:DONE         var len:Number = formats.length;
// AS3:DONE         for (var i:Number = 0; i < len; ++i)
// AS3:DONE             _internal_update(mc["f" + i], formats[i], obj);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _internal_update(f, format, obj)
// AS3:DONE     {
// AS3:DONE         var value;
// AS3:DONE         var needAlign:Boolean = false;
// AS3:DONE         if (format.x != null)
// AS3:DONE         {
// AS3:DONE             value = !isNaN(format.x) ? format.x : (parseFloat(Macros.Format(m_name, format.x, obj)) || 0);
// AS3:DONE             if (format.bindToIcon)
// AS3:DONE             {
// AS3:DONE                 value += isLeftPanel
// AS3:DONE                     ? panel.m_list._x + panel.m_list.width
// AS3:DONE                     : App.appWidth - panel._x - panel.m_list._x + panel.m_list.width;
// AS3:DONE             }
// AS3:DONE             if (f.data.x != value)
// AS3:DONE             {
// AS3:DONE                 f.data.x = value;
// AS3:DONE                 //Logger.add("x=" + value);
// AS3:DONE                 needAlign = true;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE         if (format.y != null)
// AS3:DONE         {
// AS3:DONE             value = parseFloat(Macros.Format(m_name, format.y, obj)) || 0;
// AS3:DONE             if (f.data.y != value)
// AS3:DONE             {
// AS3:DONE                 f.data.y = value;
// AS3:DONE                 //Logger.add("y=" + value);
// AS3:DONE                 needAlign = true;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE         if (format.w != null)
// AS3:DONE         {
// AS3:DONE             value = parseFloat(Macros.Format(m_name, format.w, obj)) || 0;
// AS3:DONE             if (f.data.w != value)
// AS3:DONE             {
// AS3:DONE                 f.data.w = value;
// AS3:DONE                 //Logger.add("w=" + value);
// AS3:DONE                 needAlign = true;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE         if (format.h != null)
// AS3:DONE         {
// AS3:DONE             value = parseFloat(Macros.Format(m_name, format.h, obj)) || 0;
// AS3:DONE             if (f.data.h != value)
// AS3:DONE             {
// AS3:DONE                 f.data.h = value;
// AS3:DONE                 //Logger.add("h=" + value);
// AS3:DONE                 needAlign = true;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE         if (format.alpha != null)
// AS3:DONE         {
// AS3:DONE             var alpha = parseFloat(Macros.Format(m_name, format.alpha, obj));
// AS3:DONE             f._alpha = isNaN(alpha) ? 100 : alpha;
// AS3:DONE         }
// AS3:DONE         if (format.rotation != null)
// AS3:DONE             f._rotation = parseFloat(Macros.Format(m_name, format.rotation, obj)) || 0;
// AS3:DONE         if (format.scaleX != null)
// AS3:DONE             f._xscale = parseFloat(Macros.Format(m_name, format.scaleX, obj)) * 100 || 100;
// AS3:DONE         if (format.scaleY != null)
// AS3:DONE             f._yscale = parseFloat(Macros.Format(m_name, format.scaleY, obj)) * 100 || 100;
// AS3:DONE         if (format.borderColor != null)
// AS3:DONE             f.borderColor = parseInt(Macros.Format(m_name, format.borderColor, obj).split("#").join("0x")) || 0;
// AS3:DONE         if (format.bgColor != null)
// AS3:DONE             f.backgroundColor = parseInt(Macros.Format(m_name, format.bgColor, obj).split("#").join("0x")) || 0;
// AS3:DONE 
// AS3:DONE         if (format.format != null)
// AS3:DONE         {
// AS3:DONE             value = Macros.Format(m_name, format.format, obj);
// AS3:DONE             if (f.formattedValue != value)
// AS3:DONE             {
// AS3:DONE                 f.formattedValue = value;
// AS3:DONE                 f.htmlText = "<span class='extraField'>" + value + "</span>";
// AS3:DONE                 //Logger.add("txt=" + value);
// AS3:DONE                 needAlign = true;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE 
// AS3:DONE         if (format.src != null)
// AS3:DONE         {
// AS3:DONE             //var dead = (wrapper.data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) == 0;
// AS3:DONE             //Logger.add(dead + " " + obj.dead + " " + m_name);
// AS3:DONE             var src:String = Utils.fixImgTagSrc(Macros.Format(m_name, format.src, obj));
// AS3:DONE             if (f.source != src)
// AS3:DONE             {
// AS3:DONE                 //Logger.add(m_name + " " + f.source + " => " + src);
// AS3:DONE                 f._visible = false;
// AS3:DONE                 f.source = src;
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             var highlight = format.highlight;
// AS3:DONE             if (highlight != null && highlight != false)
// AS3:DONE             {
// AS3:DONE                 if (typeof(format.highlight) == 'string')
// AS3:DONE                     highlight = Utils.toBool(Macros.Format(m_name, format.highlight, obj).toLowerCase(), false);
// AS3:DONE                 var sn = PlayerStatus.getStatusColorSchemeNames(
// AS3:DONE                     (wrapper.data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.NOT_AVAILABLE) != 0,
// AS3:DONE                     true,
// AS3:DONE                     highlight != true ? false : wrapper.selected,
// AS3:DONE                     highlight != true ? false : wrapper.data.squad,
// AS3:DONE                     highlight != true ? false : wrapper.data.teamKiller,
// AS3:DONE                     highlight != true ? false : wrapper.data.VIP,
// AS3:DONE                     !obj.ready);
// AS3:DONE                 if (sn.vehicleSchemeName != format.__last_vehicleSchemeName)
// AS3:DONE                 {
// AS3:DONE                     format.__last_vehicleSchemeName = sn.vehicleSchemeName;
// AS3:DONE                     (new Transform(f)).colorTransform = this.getColorTransform(sn.vehicleSchemeName, true);
// AS3:DONE                     //Logger.add(f.source + " " + sn.vehicleSchemeName);
// AS3:DONE                 }
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         if (needAlign)
// AS3:DONE             alignField(f);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function alignField(field)
// AS3:DONE     {
// AS3:DONE         //Logger.add("alignField");
// AS3:DONE         var tf:TextField = TextField(field);
// AS3:DONE         var img:UILoaderAlt = UILoaderAlt(field);
// AS3:DONE
// AS3:DONE         var data:Object = field["data"];
// AS3:DONE         //Logger.addObject(data);
// AS3:DONE
// AS3:DONE         var x:Number = isLeftPanel ? data.x : -data.x;
// AS3:DONE         var y:Number = data.y;
// AS3:DONE         var w:Number = isNaN(data.w) ? img.content._width : data.w;
// AS3:DONE         var h:Number = isNaN(data.h) ? img.content._height : data.h;
// AS3:DONE
// AS3:DONE         if (tf != null)
// AS3:DONE         {
// AS3:DONE             if (tf.textWidth > 0)
// AS3:DONE                 w = tf.textWidth + 4; // 2 * 2-pixel gutter
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         if (data.align == "right")
// AS3:DONE             x -= w;
// AS3:DONE         else if (data.align == "center")
// AS3:DONE             x -= w / 2;
// AS3:DONE
// AS3:DONE         //Logger.add("x:" + x + " y:" + y + " w:" + w + " h:" + h + " align:" + data.align + " textWidth:" + tf.textWidth);
// AS3:DONE 
// AS3:DONE         if (tf != null)
// AS3:DONE         {
// AS3:DONE             if (tf._x != x)
// AS3:DONE                 tf._x = x;
// AS3:DONE             if (tf._y != y)
// AS3:DONE                 tf._y = y;
// AS3:DONE             if (tf._width != w)
// AS3:DONE                 tf._width = w;
// AS3:DONE             if (tf._height != h)
// AS3:DONE                 tf._height = h;
// AS3:DONE         }
// AS3:DONE        else
// AS3:DONE         {
// AS3:DONE             if (img._x != x)
// AS3:DONE                 img._x = x;
// AS3:DONE             if (img._y != y)
// AS3:DONE                 img._y = y;
// AS3:DONE             if (img.width != w || img.height != h)
// AS3:DONE             {
// AS3:DONE                 //Logger.add(img.width + "->" + w + " " + x + " " + y + " " + m_name + " " + wrapper._name);
// AS3:DONE                 img.setSize(w, h);
// AS3:DONE                 img.validateNow();
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE     }

    var _savedScreenWidth = 0;
    var _savedX = 0;
    private function adjustExtraFieldsLeft(e)
    {
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
                    mc._x = App.appWidth - cfg.x - mc.idx * cfg.width;
                    mc._y = cfg.y;
                    break;
                default:
                    mc._x = App.appWidth - cfg.x;
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
        //Logger.add(App.appWidth + " " + panel.m_list.width + " " + panel.m_list._x);

        if (_savedScreenWidth != App.appWidth || _savedX != panel.m_list._x)
        {
            //Logger.add('updateExtraFields');
            _savedScreenWidth = App.appWidth;
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
