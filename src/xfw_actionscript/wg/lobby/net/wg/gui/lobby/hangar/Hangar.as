package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.HangarMeta;
    import net.wg.gui.lobby.hangar.interfaces.IHangar;
    import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
    import net.wg.gui.tutorial.components.TutorialClip;
    import net.wg.gui.components.controls.CrewOperationBtn;
    import net.wg.gui.lobby.hangar.crew.Crew;
    import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
    import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
    import flash.display.Sprite;
    import net.wg.gui.lobby.post.Teaser;
    import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
    import net.wg.gui.lobby.rankedBattles19.components.widget.RankedBattlesHangarWidget;
    import net.wg.gui.lobby.hangar.alertMessage.AlertMessageBlock;
    import net.wg.gui.lobby.epicBattles.components.EpicBattlesWidget;
    import net.wg.gui.components.miniclient.HangarMiniClientComponent;
    import net.wg.utils.IGameInputManager;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.IUtils;
    import net.wg.utils.helpLayout.IHelpLayout;
    import flash.utils.Dictionary;
    import scaleform.clik.motion.Tween;
    import flash.display.Loader;
    import net.wg.gui.lobby.hangar.seniorityAwards.SeniorityAwardsEntryPointHangar;
    import net.wg.data.constants.generated.DAILY_QUESTS_WIDGET_CONSTANTS;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import flash.geom.Rectangle;
    import net.wg.data.Aliases;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import net.wg.gui.events.LobbyEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import flash.events.Event;
    import net.wg.gui.lobby.post.TeaserEvent;
    import scaleform.clik.events.ComponentEvent;
    import net.wg.gui.notification.events.NotificationLayoutEvent;
    import flash.geom.Point;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.AmmunitionPanelVO;
    import net.wg.gui.lobby.post.data.TeaserVO;
    import fl.motion.easing.Quadratic;
    import net.wg.data.constants.Linkages;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import flash.display.LoaderInfo;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.IOErrorEvent;
    import net.wg.gui.lobby.hangar.seniorityAwards.SeniorityAwardsEntryPoint;
    import flash.display.MovieClip;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;

    public class Hangar extends HangarMeta implements IHangar, ITutorialCustomComponent
    {

        private static const INVALIDATE_ENABLED_CREW:String = "InvalidateEnabledCrew";

        protected static const INVALIDATE_CAROUSEL_SIZE:String = "InvalidateCarouselSize";

        private static const CAROUSEL_NAME:String = "carousel";

        private static const PARAMS_TOP_MARGIN:int = 3;

        private static const PARAMS_BOTTOM_MARGIN:int = 80;

        private static const PARAMS_SMALL_SCREEN_BOTTOM_MARGIN:int = 36;

        private static const MESSENGER_BAR_PADDING:int = 45;

        private static const TOP_MARGIN:Number = 34;

        private static const MINI_CLIENT_GAP:Number = 1;

        private static const ANIM_SPEED_TIME:int = 600;

        private static const TEASER_SHOW_X_OFFSET:int = 10;

        private static const TEASER_SHOW_SMALL_X_OFFSET:int = -110;

        private static const TEASER_HIDE_SMALL_X_OFFSET:int = -355;

        private static const SM_CAROUSEL_PADDING:Number = 30;

        private static const SM_AMMUNITION_PANEL_PADDING:Number = 86;

        private static const SM_THRESHOLD_X:Number = 1360;

        private static const SM_PADDING_X:Number = 4;

        private static const ALERT_MESSAGE_GAP:int = 40;

        private static const RIGHT_MARGIN:int = 5;

        private static const SENIORITY_AWARDS_COMPONENTS_SWF:String = "seniorityAwardsComponents.swf";

        private static const DQ_WIDGET_NORMAL_HEIGHT:int = 184;

        private static const DQ_WIDGET_MINI_HEIGHT:int = 70;

        private static const DQ_WIDGET_MICRO_HEIGHT:int = 58;

        private static const DQ_WIDGET_NORMAL_LAYOUT_CAROUSEL_THRESHOLD:int = 675;

        private static const DQ_WIDGET_NORMAL_LAYOUT_WIDTH_THRESHOLD:int = 1600;

        private static const DQ_WIDGET_MICRO_LAYOUT_WIDTH_THRESHOLD:int = 1366;

        private static const DQ_WIDGET_VERTICAL_OFFSET:int = 15;

        private static const DQ_WIDGET_HORIZONTAL_MARGIN:int = 3;

        public var vehResearchPanel:ResearchPanel;

        public var vehResearchBG:TutorialClip;

        public var tmenXpPanel:TmenXpPanel;

        public var crewOperationBtn:CrewOperationBtn;

        public var crew:Crew;

        public var params:IVehicleParameters;

        public var ammunitionPanel:AmmunitionPanel;

        public var bottomBg:Sprite;

        public var carouselContainer:TutorialClip;

        public var switchModePanel:SwitchModePanel;

        public var crewBG:Sprite;

        public var teaser:Teaser;

        public var dqWidget:DailyQuestWidget;

        public function get xfw_header():HangarHeader
        {
            return _header;
        }

        private var _header:HangarHeader;

        private var _carousel:TankCarousel;

        private var _isControlsVisible:Boolean = false;

        private var _carouselAlias:String;

        private var _rankedWdgt:RankedBattlesHangarWidget;

        private var _alertMessageBlock:AlertMessageBlock;

        private var _epicBattlesWdgt:EpicBattlesWidget;

        private var _miniClient:HangarMiniClientComponent;

        private var _crewEnabled:Boolean = true;

        private var _gameInputMgr:IGameInputManager;

        private var _toolTipMgr:ITooltipMgr;

        private var _utils:IUtils;

        private var _helpLayout:IHelpLayout;

        private var _activeHeaderType:String = "";

        private var _headerTypeDict:Dictionary;

        private var _teaserX:int = 0;

        private var _teaserOffsetX:int = 0;

        private var _tweenTeaser:Tween;

        private var _isTeaserShow:Boolean;

        private var _seniorityAwardsLoader:Loader = null;

        private var _seniorityAwardsComponent:SeniorityAwardsEntryPointHangar = null;

        private var _currentWidgetLayout:int = 99;

        private var _widgetInitialized:Boolean;

        private var _widgetSizes:Dictionary;

        public function Hangar()
        {
            this._gameInputMgr = App.gameInputMgr;
            this._toolTipMgr = App.toolTipMgr;
            this._utils = App.utils;
            this._helpLayout = App.utils.helpLayout;
            super();
            _deferredDispose = true;
            this.switchModePanel.visible = false;
            this._headerTypeDict = new Dictionary();
            this._headerTypeDict[HANGAR_ALIASES.HEADER] = [this._header,HangarHeader,Linkages.HANGAR_HEADER];
            this._headerTypeDict[HANGAR_ALIASES.RANKED_WIDGET] = [this._rankedWdgt,RankedBattlesHangarWidget,Linkages.RANKED_BATTLES_WIDGET_UI];
            this._headerTypeDict[HANGAR_ALIASES.EPIC_WIDGET] = [this._epicBattlesWdgt,EpicBattlesWidget,Linkages.EPIC_WIDGET];
            this.setupWidgetSizes();
        }

        private function setupWidgetSizes() : void
        {
            this._widgetSizes = new Dictionary();
            this._widgetSizes[DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_NORMAL] = [340,186];
            this._widgetSizes[DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MINI] = [185,65];
            this._widgetSizes[DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MICRO] = [150,55];
        }

        override public function unregisterComponent(param1:String) : void
        {
            super.unregisterComponent(param1);
            if(param1 == HANGAR_ALIASES.SENIORITY_AWARDS_ENTRY_POINT)
            {
                removeChild(this._seniorityAwardsComponent);
                this._seniorityAwardsComponent = null;
            }
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc3_:Rectangle = null;
            _originalWidth = param1;
            _originalHeight = param2;
            setSize(param1,param2);
            if(this.carousel != null)
            {
                this.carousel.updateStage(param1,param2);
                this.updateCarouselPosition();
            }
            if(this.bottomBg != null)
            {
                this.bottomBg.x = 0;
                this.bottomBg.y = _originalHeight - this.bottomBg.height + MESSENGER_BAR_PADDING >> 0;
                this.bottomBg.width = _originalWidth;
            }
            this.alignToCenter(this.switchModePanel);
            this.alignToCenter(this._miniClient);
            if(this.header != null)
            {
                this.header.x = param1 >> 1;
            }
            if(this._rankedWdgt != null)
            {
                this._rankedWdgt.invalidateSize();
                this._rankedWdgt.x = _width >> 1;
            }
            if(this._alertMessageBlock)
            {
                this._alertMessageBlock.x = _width - this._alertMessageBlock.width >> 1;
            }
            if(this._epicBattlesWdgt != null)
            {
                this._epicBattlesWdgt.invalidateSize();
                this._epicBattlesWdgt.x = _width >> 1;
            }
            if(this.vehResearchPanel != null)
            {
                this.vehResearchPanel.x = param1;
                _loc3_ = this.vehResearchBG.getBounds(this.vehResearchBG);
                this.vehResearchBG.x = param1 - _loc3_.x - _loc3_.width - RIGHT_MARGIN >> 0;
            }
            this._helpLayout.hide();
            if(this._seniorityAwardsComponent)
            {
                this._seniorityAwardsComponent.updateSize(param1,param2);
                this.seniorityAwardsUpdatePosition();
            }
            this.checkToIfLayoutNeedsUpdate();
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponentS(this.crew,HANGAR_ALIASES.CREW);
            registerFlashComponentS(this.tmenXpPanel,HANGAR_ALIASES.TMEN_XP_PANEL);
            registerFlashComponentS(this.ammunitionPanel,HANGAR_ALIASES.AMMUNITION_PANEL);
            registerFlashComponentS(this.switchModePanel,Aliases.SWITCH_MODE_PANEL);
            registerFlashComponentS(this.params,HANGAR_ALIASES.VEHICLE_PARAMETERS);
            registerFlashComponentS(this.dqWidget,Aliases.DAILY_QUEST_WIDGET);
            addEventListener(CrewDropDownEvent.SHOW_DROP_DOWN,this.onHangarShowDropDownHandler);
            if(this.vehResearchPanel != null)
            {
                registerFlashComponentS(this.vehResearchPanel,HANGAR_ALIASES.RESEARCH_PANEL);
            }
            this.updateControlsVisibility();
            this.updateElementsPosition();
        }

        override protected function onBeforeDispose() : void
        {
            this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscapeHandler);
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
            removeEventListener(CrewDropDownEvent.SHOW_DROP_DOWN,this.onHangarShowDropDownHandler);
            this._gameInputMgr.clearKeyHandler(Keyboard.F1,KeyboardEvent.KEY_DOWN,this.showLayoutHandler);
            this._gameInputMgr.clearKeyHandler(Keyboard.F1,KeyboardEvent.KEY_UP,this.closeLayoutHandler);
            this.crewOperationBtn.removeEventListener(ButtonEvent.CLICK,this.onCrewOperationBtnClickHandler);
            this.ammunitionPanel.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onAmmunitionPanelRequestFocusHandler);
            this.vehResearchPanel.removeEventListener(Event.RESIZE,this.onVehResearchPanelResizeHandler);
            this.teaser.removeEventListener(TeaserEvent.TEASER_CLICK,this.onTeaserTeaserClickHandler);
            this.teaser.removeEventListener(TeaserEvent.HIDE,this.onTeaserHideHandler);
            this.switchModePanel.removeEventListener(ComponentEvent.SHOW,this.onSwitchModePanelShowHandler);
            this.switchModePanel.removeEventListener(ComponentEvent.HIDE,this.onSwitchModePanelHideHandler);
            this.carousel.removeEventListener(Event.RESIZE,this.onCarouselResizeHandler);
            this.removeSeniorityAwardsLoader();
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
            App.utils.counterManager.removeCounter(this.crewOperationBtn);
            this.crewOperationBtn.dispose();
            this.crewOperationBtn = null;
            this.bottomBg = null;
            this.crewBG = null;
            this.teaser.dispose();
            this.teaser = null;
            if(this._tweenTeaser)
            {
                this._tweenTeaser.paused = true;
                this._tweenTeaser.dispose();
                this._tweenTeaser = null;
            }
            this._miniClient = null;
            this.vehResearchPanel = null;
            this.vehResearchBG.dispose();
            this.vehResearchBG = null;
            this.tmenXpPanel = null;
            this.crew = null;
            this.params = null;
            this.ammunitionPanel = null;
            this._carousel = null;
            this.switchModePanel = null;
            this._header = null;
            this._rankedWdgt = null;
            this._alertMessageBlock = null;
            this._epicBattlesWdgt = null;
            this.dqWidget = null;
            this._widgetInitialized = false;
            this._gameInputMgr = null;
            this._toolTipMgr = null;
            this._utils = null;
            this._helpLayout = null;
            this.carouselContainer.dispose();
            this.carouselContainer = null;
            this.crewBG = null;
            if(this._seniorityAwardsComponent)
            {
                this._seniorityAwardsComponent = null;
            }
            this._currentWidgetLayout = 99;
            App.utils.data.cleanupDynamicObject(this._headerTypeDict);
            this._headerTypeDict = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.tutorialMgr.addListenersToCustomTutorialComponent(this);
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
            mouseEnabled = false;
            this.bottomBg.mouseEnabled = false;
            this._gameInputMgr.setKeyHandler(Keyboard.F1,KeyboardEvent.KEY_DOWN,this.showLayoutHandler,true);
            this._gameInputMgr.setKeyHandler(Keyboard.F1,KeyboardEvent.KEY_UP,this.closeLayoutHandler,true);
            this._gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscapeHandler,true);
            this.crewOperationBtn.tooltip = CREW_OPERATIONS.CREWOPERATIONS_BTN_TOOLTIP;
            this.crewOperationBtn.helpText = LOBBY_HELP.HANGAR_CREWOPERATIONBTN;
            this.crewOperationBtn.addEventListener(ButtonEvent.CLICK,this.onCrewOperationBtnClickHandler,false,0,true);
            this.crewOperationBtn.iconSource = RES_ICONS.MAPS_ICONS_TANKMEN_CREW_CREWOPERATIONS;
            this.ammunitionPanel.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onAmmunitionPanelRequestFocusHandler);
            this.switchModePanel.addEventListener(ComponentEvent.SHOW,this.onSwitchModePanelShowHandler);
            this.switchModePanel.addEventListener(ComponentEvent.HIDE,this.onSwitchModePanelHideHandler);
            this.vehResearchPanel.addEventListener(Event.RESIZE,this.onVehResearchPanelResizeHandler);
            this.teaser.addEventListener(TeaserEvent.TEASER_CLICK,this.onTeaserTeaserClickHandler);
            this.teaser.addEventListener(TeaserEvent.HIDE,this.onTeaserHideHandler);
            this.carouselContainer.mouseEnabled = false;
            this._teaserX = -this.teaser.over.width;
        }

        override protected function allowHandleInput() : Boolean
        {
            return false;
        }

        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            super.draw();
            if(isInvalid(INVALIDATE_ENABLED_CREW))
            {
                this.crew.enabled = this._crewEnabled;
                this.crewOperationBtn.enabled = this._crewEnabled;
            }
            if(isInvalid(INVALIDATE_CAROUSEL_SIZE))
            {
                this.carousel.visible = true;
                this.updateCarouselPosition();
                this.updateCrewSize();
                if(hasEventListener(Event.RESIZE))
                {
                    dispatchEvent(new Event(Event.RESIZE));
                }
                _loc1_ = SM_CAROUSEL_PADDING;
                if(width > SM_THRESHOLD_X)
                {
                    _loc1_ = SM_AMMUNITION_PANEL_PADDING;
                }
                this.updateTeaserSize();
                App.systemMessages.dispatchEvent(new NotificationLayoutEvent(NotificationLayoutEvent.UPDATE_LAYOUT,new Point(SM_PADDING_X,height - this.ammunitionPanel.y - _loc1_)));
                this.seniorityAwardsUpdatePosition();
                this.checkToIfLayoutNeedsUpdate();
            }
        }

        override protected function onSetModalFocus(param1:InteractiveObject) : void
        {
            if(param1 == null)
            {
                var param1:InteractiveObject = this;
            }
            super.onSetModalFocus(param1);
        }

        override protected function setupAmmunitionPanel(param1:AmmunitionPanelVO) : void
        {
            this.ammunitionPanel.updateAmmunitionPanel(param1.maintenanceEnabled,param1.maintenanceTooltip);
            this.ammunitionPanel.updateTuningButton(param1.customizationEnabled,param1.customizationTooltip);
            this.ammunitionPanel.updateChangeNationButton(param1.changeNationVisible,param1.changeNationEnable,param1.changeNationTooltip,param1.changeNationIsNew);
        }

        override protected function show3DSceneTooltip(param1:String, param2:Array) : void
        {
            this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[param1,null].concat(param2));
        }

        override protected function showTeaser(param1:TeaserVO) : void
        {
            this.teaser.setData(param1);
            this._isTeaserShow = true;
            if(!this._tweenTeaser)
            {
                this.teaser.alpha = 0;
                this._tweenTeaser = new Tween(ANIM_SPEED_TIME,this.teaser,{
                    "x":this._teaserOffsetX,
                    "alpha":1
                },{
                    "paused":false,
                    "onComplete":this.animationFinished,
                    "ease":Quadratic.easeInOut
                });
            }
        }

        public function as_closeHelpLayout() : void
        {
            this._helpLayout.hide();
        }

        public function as_hide3DSceneTooltip() : void
        {
            this.hideTooltip();
        }

        public function as_hideTeaserTimer() : void
        {
            this.teaser.hideTimer();
        }

        public function as_createDQWidget() : void
        {
            if(!this.dqWidget)
            {
                this.dqWidget = new DailyQuestWidget();
                addChild(this.dqWidget);
                registerFlashComponentS(this.dqWidget,Aliases.DAILY_QUEST_WIDGET);
                this.repositionWidget();
            }
        }

        public function as_destroyDQWidget() : void
        {
            if(this.dqWidget)
            {
                this.dqWidget.dispose();
            }
            this.dqWidget = null;
        }

        public function as_setAlertMessageBlockVisible(param1:Boolean) : void
        {
            var _loc2_:String = HANGAR_ALIASES.ALERT_MESSAGE_BLOCK;
            var _loc3_:Boolean = isFlashComponentRegisteredS(_loc2_);
            var _loc4_:Boolean = this._alertMessageBlock?contains(this._alertMessageBlock):false;
            if(param1)
            {
                if(this._alertMessageBlock == null)
                {
                    this._alertMessageBlock = App.instance.utils.classFactory.getComponent(Linkages.ALERT_MESSAGE_BLOCK,AlertMessageBlock);
                    this._alertMessageBlock.name = _loc2_;
                }
                if(!_loc4_)
                {
                    addChildAt(this._alertMessageBlock,getChildIndex(this.crewOperationBtn as DisplayObject) - 1);
                }
                if(!_loc3_)
                {
                    registerFlashComponentS(this._alertMessageBlock,_loc2_);
                }
            }
            else if(this._alertMessageBlock)
            {
                if(_loc3_)
                {
                    unregisterFlashComponentS(_loc2_);
                }
                if(_loc4_)
                {
                    removeChild(this._alertMessageBlock);
                }
                this._alertMessageBlock = null;
            }
            this.updateElementsPosition();
        }

        public function as_setCarousel(param1:String, param2:String) : void
        {
            if(this.carousel != null)
            {
                this.carousel.removeEventListener(Event.RESIZE,this.onCarouselResizeHandler);
                this.carouselContainer.removeChild(this.carousel);
                unregisterFlashComponentS(this._carouselAlias);
            }
            this._carouselAlias = param2;
            this._carousel = App.instance.utils.classFactory.getComponent(param1,TankCarousel);
            this.carousel.visible = false;
            this.carousel.addEventListener(Event.RESIZE,this.onCarouselResizeHandler);
            this.carousel.updateStage(_originalWidth,_originalHeight);
            this.carousel.name = CAROUSEL_NAME;
            this.carouselContainer.addChild(this.carousel);
            registerFlashComponentS(this.carousel,this._carouselAlias);
            this.carousel.validateNow();
            invalidate(INVALIDATE_CAROUSEL_SIZE);
        }

        public function as_setCarouselEnabled(param1:Boolean) : void
        {
            this.carousel.enabled = param1;
        }

        public function as_setControlsVisible(param1:Boolean) : void
        {
            if(param1 != this.isControlsVisible)
            {
                this._isControlsVisible = param1;
                this.updateControlsVisibility();
            }
        }

        public function as_setCrewEnabled(param1:Boolean) : void
        {
            this._crewEnabled = param1;
            invalidate(INVALIDATE_ENABLED_CREW);
        }

        public function as_setDefaultHeader() : void
        {
            var _loc3_:String = null;
            var _loc1_:BaseDAAPIComponent = this._headerTypeDict[HANGAR_ALIASES.HEADER][0];
            var _loc2_:DisplayObject = this.getHeaderElement(this._activeHeaderType);
            if(_loc1_ == null)
            {
                _loc1_ = App.instance.utils.classFactory.getComponent(this._headerTypeDict[HANGAR_ALIASES.HEADER][2],this._headerTypeDict[HANGAR_ALIASES.HEADER][1]);
                _loc1_.name = HANGAR_ALIASES.HEADER;
                addChildAt(_loc1_,getChildIndex(this.params as DisplayObject) - 1);
                registerFlashComponentS(_loc1_,HANGAR_ALIASES.HEADER);
            }
            if(_loc2_ != null)
            {
                _loc3_ = this._activeHeaderType;
                unregisterFlashComponentS(_loc3_);
                removeChild(_loc2_);
                _loc2_ = null;
            }
            this._activeHeaderType = HANGAR_ALIASES.HEADER;
            this._header = HangarHeader(_loc1_);
            this._rankedWdgt = null;
            this._epicBattlesWdgt = null;
            this.updateElementsPosition();
        }

        public function as_setHeaderType(param1:String) : void
        {
            var _loc4_:String = null;
            var _loc2_:BaseDAAPIComponent = this._headerTypeDict[param1][0];
            var _loc3_:DisplayObject = this.getHeaderElement(this._activeHeaderType);
            if(_loc2_ == null)
            {
                _loc2_ = App.instance.utils.classFactory.getComponent(this._headerTypeDict[param1][2],this._headerTypeDict[param1][1]);
                _loc2_.name = param1;
                addChildAt(_loc2_,getChildIndex(this.crewOperationBtn as DisplayObject) - 1);
                registerFlashComponentS(_loc2_,param1);
            }
            if(_loc3_ != null)
            {
                _loc4_ = this._activeHeaderType;
                unregisterFlashComponentS(_loc4_);
                removeChild(_loc3_);
                _loc3_ = null;
            }
            switch(param1)
            {
                case HANGAR_ALIASES.HEADER:
                    this._activeHeaderType = HANGAR_ALIASES.HEADER;
                    this._header = HangarHeader(_loc2_);
                    this._rankedWdgt = null;
                    this._epicBattlesWdgt = null;
                    this.ammunitionPanel.setBattleAbilitiesVisibility(false);
                    this.updateCarouselPosition();
                    break;
                case HANGAR_ALIASES.RANKED_WIDGET:
                    this._activeHeaderType = HANGAR_ALIASES.RANKED_WIDGET;
                    this._rankedWdgt = RankedBattlesHangarWidget(_loc2_);
                    this._rankedWdgt.useButtonMode(true);
                    this._header = null;
                    this._epicBattlesWdgt = null;
                    break;
                case HANGAR_ALIASES.EPIC_WIDGET:
                    this._header = null;
                    this._rankedWdgt = null;
                    this._activeHeaderType = HANGAR_ALIASES.EPIC_WIDGET;
                    this._epicBattlesWdgt = EpicBattlesWidget(_loc2_);
                    this.ammunitionPanel.setBattleAbilitiesVisibility(true);
                    this.updateCarouselPosition();
                    break;
            }
            this.updateElementsPosition();
        }

        public function as_setNotificationEnabled(param1:Boolean) : void
        {
            if(param1 && this.crewOperationBtn.visible)
            {
                App.utils.counterManager.setCounter(this.crewOperationBtn,MENU.HEADER_NOTIFICATIONSIGN);
            }
            else
            {
                App.utils.counterManager.removeCounter(this.crewOperationBtn);
            }
        }

        public function as_setTeaserTimer(param1:String) : void
        {
            this.teaser.setTime(param1);
        }

        public function as_setVisible(param1:Boolean) : void
        {
            this.visible = param1;
        }

        public function as_showHelpLayout() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            if(this.crewOperationBtn.visible)
            {
                _loc1_ = this.crewOperationBtn.width;
                _loc1_ = _loc1_ + (this.tmenXpPanel.panelVisible?this.tmenXpPanel.width:0);
                this.crewOperationBtn.showHelpLayoutEx(1,_loc1_);
            }
            if(this.params.visible)
            {
                _loc2_ = Math.max(this.params.getHelpLayoutWidth(),this.vehResearchPanel.getHelpLayoutWidth());
                this.params.showHelpLayoutEx(this.vehResearchPanel.x - this.params.x,_loc2_);
            }
            this._helpLayout.show();
        }

        public function as_showMiniClientInfo(param1:String, param2:String) : void
        {
            this._miniClient = HangarMiniClientComponent(this._utils.classFactory.getComponent(Linkages.HANGAR_MINI_CLIENT_COMPONENT,HangarMiniClientComponent));
            this._miniClient.update(param1,param2);
            addChild(this._miniClient);
            registerFlashComponentS(this._miniClient,Aliases.MINI_CLIENT_LINKED);
            this.updateElementsPosition();
        }

        public function as_updateSeniorityAwardsEntryPoint(param1:Boolean) : void
        {
            var _loc2_:LoaderInfo = null;
            if(param1)
            {
                if(!this._seniorityAwardsComponent && !this._seniorityAwardsLoader)
                {
                    this._seniorityAwardsLoader = new Loader();
                    this._seniorityAwardsLoader.load(new URLRequest(SENIORITY_AWARDS_COMPONENTS_SWF),new LoaderContext(false,ApplicationDomain.currentDomain));
                    _loc2_ = this._seniorityAwardsLoader.contentLoaderInfo;
                    _loc2_.addEventListener(Event.COMPLETE,this.onSeniorityAwardsLoadCompleteHandler);
                    _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onSeniorityAwardsLoadErrorHandler);
                }
            }
            else
            {
                if(this._seniorityAwardsComponent)
                {
                    this.unregisterComponent(HANGAR_ALIASES.SENIORITY_AWARDS_ENTRY_POINT);
                    this._seniorityAwardsComponent = null;
                }
                this.removeSeniorityAwardsLoader();
            }
        }

        public function generatedUnstoppableEvents() : Boolean
        {
            return true;
        }

        public function getHitArea() : DisplayObject
        {
            return this.crewOperationBtn;
        }

        public function getTargetButton() : DisplayObject
        {
            return this.crewOperationBtn;
        }

        public function getTutorialDescriptionName() : String
        {
            return name;
        }

        public function needPreventInnerEvents() : Boolean
        {
            return true;
        }

        public function updateAmmunitionPanelPosition() : void
        {
            if(this.carousel != null)
            {
                this.ammunitionPanel.x = _width - this.ammunitionPanel.width >> 1;
                if(!this.carouselContainer.visible)
                {
                    this.ammunitionPanel.y = height - this.ammunitionPanel.height | 0;
                }
                else
                {
                    this.ammunitionPanel.y = Math.min(this.carousel.y - this.ammunitionPanel.height + this.carouselContainer.y | 0,height - this.ammunitionPanel.height | 0);
                }
                this.ammunitionPanel.updateStage(_width,this.carousel.y);
            }
            this.updateParamsPosition();
        }

        private function checkToIfLayoutNeedsUpdate() : void
        {
            if(!this._widgetInitialized)
            {
                if(this.dqWidget == null || !isFlashComponentRegisteredS(Aliases.DAILY_QUEST_WIDGET))
                {
                    return;
                }
                this.dqWidget.x = DQ_WIDGET_HORIZONTAL_MARGIN;
                this._widgetInitialized = true;
            }
            if(!this._header || !this._carousel)
            {
                return;
            }
            var _loc1_:int = this.determineLayout();
            if(this._currentWidgetLayout != _loc1_)
            {
                this._currentWidgetLayout = _loc1_;
                this.dqWidget.updateWidgetLayout(this._currentWidgetLayout);
                this.dqWidget.setSize(this._widgetSizes[this._currentWidgetLayout][0],this._widgetSizes[this._currentWidgetLayout][1]);
            }
            this.repositionWidget();
        }

        private function repositionWidget() : void
        {
            switch(this._currentWidgetLayout)
            {
                case DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_NORMAL:
                    this.dqWidget.y = this.ammunitionPanel.y + this.ammunitionPanel.gun.y - DQ_WIDGET_NORMAL_HEIGHT + DQ_WIDGET_VERTICAL_OFFSET;
                    break;
                case DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MINI:
                    this.dqWidget.y = this.ammunitionPanel.y + this.ammunitionPanel.gun.y - DQ_WIDGET_MINI_HEIGHT + DQ_WIDGET_VERTICAL_OFFSET;
                    break;
                case DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MICRO:
                    this.dqWidget.y = this.ammunitionPanel.y + this.ammunitionPanel.gun.y - DQ_WIDGET_MICRO_HEIGHT;
                    break;
            }
        }

        private function determineLayout() : int
        {
            if(App.appWidth >= DQ_WIDGET_NORMAL_LAYOUT_WIDTH_THRESHOLD && this._carousel.y >= DQ_WIDGET_NORMAL_LAYOUT_CAROUSEL_THRESHOLD)
            {
                return DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_NORMAL;
            }
            if(App.appWidth > DQ_WIDGET_MICRO_LAYOUT_WIDTH_THRESHOLD)
            {
                return DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MINI;
            }
            return DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MICRO;
        }

        protected function updateControlsVisibility() : void
        {
            this.params.visible = this.isControlsVisible;
            this.crew.visible = this.isControlsVisible;
            this.crewOperationBtn.visible = this.isControlsVisible;
            this.ammunitionPanel.visible = this.isControlsVisible;
            this.bottomBg.visible = this.isControlsVisible;
            this.vehResearchPanel.visible = this.isControlsVisible;
            this.vehResearchBG.visible = this.isControlsVisible;
            this.crewBG.visible = this.isControlsVisible;
        }

        private function removeSeniorityAwardsLoader() : void
        {
            var _loc1_:LoaderInfo = null;
            if(this._seniorityAwardsLoader)
            {
                _loc1_ = this._seniorityAwardsLoader.loaderInfo;
                if(_loc1_)
                {
                    _loc1_.removeEventListener(Event.COMPLETE,this.onSeniorityAwardsLoadCompleteHandler);
                    _loc1_.removeEventListener(IOErrorEvent.IO_ERROR,this.onSeniorityAwardsLoadErrorHandler);
                }
                this._seniorityAwardsLoader.unload();
                this._seniorityAwardsLoader = null;
            }
        }

        private function hideTeaserAnim() : void
        {
            this._isTeaserShow = false;
            this._teaserX = this.teaser.x = -this.teaser.width;
            this.teaser.alpha = 0;
            hideTeaserS();
        }

        private function updateTeaserSize() : void
        {
            if(stage.stageWidth <= Teaser.STAGE_WIDTH_BOUNDARY)
            {
                this._teaserOffsetX = TEASER_SHOW_SMALL_X_OFFSET;
                this._teaserX = this._isTeaserShow?this._teaserOffsetX:TEASER_HIDE_SMALL_X_OFFSET;
            }
            else
            {
                this._teaserOffsetX = TEASER_SHOW_X_OFFSET;
                this._teaserX = this._isTeaserShow?this._teaserOffsetX:-this.teaser.over.width;
            }
            this.teaser.x = this._teaserX;
            this.teaser.y = this._carousel.y - this.teaser.height - TEASER_SHOW_X_OFFSET;
            this.teaser.invalidateSize();
        }

        private function animationFinished() : void
        {
            this._tweenTeaser = null;
            this._teaserX = this.teaser.x;
        }

        private function getHeaderElement(param1:String) : DisplayObject
        {
            switch(param1)
            {
                case HANGAR_ALIASES.HEADER:
                    return this._header;
                case HANGAR_ALIASES.RANKED_WIDGET:
                    return this._rankedWdgt;
                case HANGAR_ALIASES.EPIC_WIDGET:
                    return this._epicBattlesWdgt;
                default:
                    return null;
            }
        }

        private function updateParamsPosition() : void
        {
            this.params.x = _originalWidth - this.params.width - RIGHT_MARGIN ^ 0;
            this.params.y = this.vehResearchBG.y + this.vehResearchBG.height + PARAMS_TOP_MARGIN ^ 0;
            var _loc1_:int = _originalWidth <= 1280?PARAMS_SMALL_SCREEN_BOTTOM_MARGIN:0;
            if(this._seniorityAwardsComponent)
            {
                _loc1_ = _loc1_ + (this._seniorityAwardsComponent.bounds.height + SeniorityAwardsEntryPoint.TOP_OFFSET);
            }
            this.params.height = this.ammunitionPanel.y - this.params.y + PARAMS_BOTTOM_MARGIN - _loc1_;
        }

        private function hideTooltip() : void
        {
            this._toolTipMgr.hide();
        }

        private function updateCarouselPosition() : void
        {
            this._carousel.updateCarouselPosition(_height - this._carousel.getBottom() ^ 0);
            this.updateAmmunitionPanelPosition();
        }

        private function updateElementsPosition() : void
        {
            var _loc1_:int = TOP_MARGIN;
            if(this._miniClient != null)
            {
                this._miniClient.y = _loc1_;
                _loc1_ = _loc1_ + (this._miniClient.height + MINI_CLIENT_GAP);
            }
            if(this.header != null)
            {
                this.header.x = _width >> 1;
                this.header.y = _loc1_;
            }
            if(this.switchModePanel.visible)
            {
                this.switchModePanel.y = _loc1_;
            }
            if(this._alertMessageBlock)
            {
                this._alertMessageBlock.x = _width - this._alertMessageBlock.width >> 1;
                this._alertMessageBlock.y = _loc1_;
                _loc1_ = _loc1_ + ALERT_MESSAGE_GAP;
            }
            if(this._rankedWdgt != null)
            {
                this._rankedWdgt.x = _width >> 1;
                this._rankedWdgt.y = _loc1_;
            }
            if(this._epicBattlesWdgt != null)
            {
                this._epicBattlesWdgt.x = _width >> 1;
                this._epicBattlesWdgt.y = _loc1_;
            }
            if(this.switchModePanel.visible)
            {
                this.switchModePanel.y = _loc1_;
            }
        }

        private function alignToCenter(param1:DisplayObject) : void
        {
            if(param1)
            {
                param1.x = width - param1.width >> 1;
            }
        }

        private function closeLayoutHandler() : void
        {
            closeHelpLayoutS();
        }

        private function updateCrewSize() : void
        {
            var _loc1_:int = this.ammunitionPanel.y + this.ammunitionPanel.gun.y - this.crew.y;
            this.crew.updateSize(_loc1_);
        }

        private function seniorityAwardsUpdatePosition() : void
        {
            var _loc1_:MovieClip = null;
            var _loc2_:* = 0;
            if(this._seniorityAwardsComponent)
            {
                _loc1_ = this._seniorityAwardsComponent.bounds;
                this._seniorityAwardsComponent.x = width - _loc1_.width;
                if(width >= SeniorityAwardsEntryPoint.SMALL_TRESHOLD_X)
                {
                    this._seniorityAwardsComponent.y = height - _loc1_.height - this.carousel.getBottom() + SeniorityAwardsEntryPoint.BOTTOM_OFFSET;
                }
                else
                {
                    _loc2_ = AmmunitionPanel.SLOTS_HEIGHT + AmmunitionPanel.SLOTS_BOTTOM_OFFSET;
                    this._seniorityAwardsComponent.y = height - _loc1_.height - this.carousel.getBottom() - _loc2_ + SeniorityAwardsEntryPoint.BOTTOM_OFFSET;
                }
                this.updateParamsPosition();
            }
        }

        public function get carousel() : TankCarousel
        {
            return this._carousel;
        }

        public function get header() : HangarHeader
        {
            return this._header;
        }

        public function get isControlsVisible() : Boolean
        {
            return this._isControlsVisible;
        }

        private function onSeniorityAwardsLoadErrorHandler(param1:IOErrorEvent) : void
        {
            this.removeSeniorityAwardsLoader();
        }

        private function onSeniorityAwardsLoadCompleteHandler(param1:Event) : void
        {
            this._seniorityAwardsComponent = App.utils.classFactory.getComponent(Linkages.SENIORITY_AWARDS_HANGAR_ENTRY_POINT,SeniorityAwardsEntryPoint);
            addChild(this._seniorityAwardsComponent);
            this._seniorityAwardsComponent.visible = true;
            registerFlashComponentS(this._seniorityAwardsComponent,HANGAR_ALIASES.SENIORITY_AWARDS_ENTRY_POINT);
            this.seniorityAwardsUpdatePosition();
        }

        private function onTeaserTeaserClickHandler(param1:TeaserEvent) : void
        {
            onTeaserClickS();
        }

        private function onTeaserHideHandler(param1:TeaserEvent) : void
        {
            this.hideTeaserAnim();
        }

        private function onAmmunitionPanelRequestFocusHandler(param1:FocusRequestEvent) : void
        {
            setFocus(param1.focusContainer.getComponentForFocus());
        }

        private function onCrewOperationBtnClickHandler(param1:Event) : void
        {
            App.popoverMgr.show(this,Aliases.CREW_OPERATIONS_POPOVER);
        }

        private function handleEscapeHandler(param1:InputEvent) : void
        {
            if(!this._helpLayout.isShown())
            {
                onEscapeS();
            }
        }

        private function onHangarShowDropDownHandler(param1:CrewDropDownEvent) : void
        {
            var _loc2_:MovieClip = param1.dropDownref;
            var _loc3_:Point = globalToLocal(new Point(_loc2_.x,_loc2_.y));
            addChild(_loc2_);
            _loc2_.x = _loc3_.x;
            _loc2_.y = _loc3_.y;
        }

        private function showLayoutHandler(param1:InputEvent) : void
        {
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.altKey || _loc2_.ctrlKey || _loc2_.shiftKey)
            {
                return;
            }
            showHelpLayoutS();
        }

        private function onSwitchModePanelShowHandler(param1:ComponentEvent) : void
        {
            this.updateElementsPosition();
        }

        private function onSwitchModePanelHideHandler(param1:ComponentEvent) : void
        {
            this.updateElementsPosition();
        }

        private function onCarouselResizeHandler(param1:Event) : void
        {
            invalidate(INVALIDATE_CAROUSEL_SIZE);
        }

        private function onVehResearchPanelResizeHandler(param1:Event) : void
        {
            this.updateParamsPosition();
        }
    }
}
