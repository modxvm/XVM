package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.HangarMeta;
    import net.wg.gui.lobby.hangar.interfaces.IHangar;
    import net.wg.gui.components.controls.CrewOperationBtn;
    import net.wg.gui.lobby.hangar.crew.Crew;
    import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
    import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
    import flash.display.Sprite;
    import net.wg.gui.lobby.header.QuestsControl;
    import net.wg.gui.components.common.serverStats.ServerInfo;
    import flash.display.DisplayObject;
    import net.wg.data.Aliases;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.events.LobbyEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import flash.events.Event;
    import scaleform.clik.events.InputEvent;
    import flash.geom.Point;
    import net.wg.utils.IEventCollector;
    import net.wg.data.constants.Tooltips;
    
    public class Hangar extends HangarMeta implements IHangar
    {
        
        public function Hangar()
        {
            super();
            this.serverInfo.visible = this.serverInfoBg.visible = App.globalVarsMgr.isShowServerStatsS();
        }
        
        private static var CAROUSEL_AMMUNITION_PADDING:int = 7;
        
        private static var PARAMS_RIGHT_MARGIN:int = 7;
        
        private static var RESEARCH_PANEL_RIGHT_MARGIN:int = 304;
        
        private static var MESSENGER_BAR_PADDING:int = 45;
        
        public static var INVALIDATE_SERVER_INFO:String = "serverInfo";
        
        private static var START_IGR_Y_POS:Number = 34;
        
        private static var INVALIDATE_ENABLED_CREW:String = "InvalidateEnabledCrew";
        
        public var vehResearchPanel:ResearchPanel;
        
        public var tmenXpPanel:TmenXpPanel;
        
        public var crewOperationBtn:CrewOperationBtn;
        
        public var crew:Crew;
        
        public var params:Params;
        
        public var carousel:TankCarousel;
        
        public var ammunitionPanel:AmmunitionPanel;
        
        public var bottomBg:Sprite;
        
        public var igrLabel:IgrLabel;
        
        public var igrActionDaysLeft:IgrActionDaysLeft;
        
        public var questsControl:QuestsControl;
        
        public var serverInfo:ServerInfo;
        
        public var serverInfoBg:Sprite;
        
        private var _serverInfoData:Object = null;
        
        private var _isShowHelpLayout:Boolean = false;
        
        private var crewEnabled:Boolean = true;
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc3_:* = NaN;
            _originalWidth = param1;
            _originalHeight = param2;
            setSize(param1,param2);
            if(this.carousel)
            {
                this.carousel.updateSize(param1,this.carousel.height);
                this.carousel.y = param2 - this.carousel.height;
            }
            if(this.bottomBg)
            {
                this.bottomBg.x = 0;
                this.bottomBg.y = _originalHeight - this.bottomBg.height + MESSENGER_BAR_PADDING;
                this.bottomBg.width = _originalWidth;
            }
            this.alignToCenter(this.igrLabel);
            this.alignToCenter(this.igrActionDaysLeft);
            this.updatePlayerCounterPosition();
            if(this.params)
            {
                this.params.x = param1 - this.params.width - PARAMS_RIGHT_MARGIN;
            }
            if(this.ammunitionPanel)
            {
                this.ammunitionPanel.x = param1 - this.ammunitionPanel.width >> 1;
                _loc3_ = this.carousel.height + CAROUSEL_AMMUNITION_PADDING;
                this.ammunitionPanel.y = param2 - this.ammunitionPanel.height - _loc3_;
                this.ammunitionPanel.updateStage(param1,param2 - _loc3_);
            }
            if(this.vehResearchPanel != null)
            {
                this.vehResearchPanel.x = param1 - RESEARCH_PANEL_RIGHT_MARGIN;
            }
            if(this._isShowHelpLayout)
            {
                this.as_closeHelpLayout();
            }
        }
        
        public function as_setServerStats(param1:Object) : void
        {
            this._serverInfoData = param1;
            invalidate(INVALIDATE_SERVER_INFO);
        }
        
        public function as_setServerStatsInfo(param1:String) : void
        {
            this.serverInfo.tooltipFullData = param1;
        }
        
        public function as_setCrewEnabled(param1:Boolean) : void
        {
            this.crewEnabled = param1;
            invalidate(INVALIDATE_ENABLED_CREW);
        }
        
        public function as_setCarouselEnabled(param1:Boolean) : void
        {
            this.carousel.enabled = param1;
        }
        
        public function as_setupAmmunitionPanel(param1:Boolean, param2:Boolean) : void
        {
            this.ammunitionPanel.disableAmmunitionPanel(!param1);
            this.ammunitionPanel.disableTuningButton(!param2);
        }
        
        public function as_setControlsVisible(param1:Boolean) : void
        {
            this.params.visible = param1;
            this.crew.visible = param1;
            this.ammunitionPanel.visible = param1;
            this.carousel.visible = param1;
            this.bottomBg.visible = param1;
            this.vehResearchPanel.visible = param1;
        }
        
        public function as_showHelpLayout() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            if(!this._isShowHelpLayout)
            {
                this._isShowHelpLayout = true;
                if(this.crew.visible)
                {
                    this.crew.showHelpLayout();
                }
                if(this.ammunitionPanel.visible)
                {
                    this.ammunitionPanel.showHelpLayout();
                }
                if(this.carousel.visible)
                {
                    this.carousel.showHelpLayout();
                }
                if(this.questsControl.visible)
                {
                    this.questsControl.showHelpLayout();
                }
                if(this.crewOperationBtn.visible)
                {
                    _loc2_ = this.crewOperationBtn.width;
                    _loc2_ = _loc2_ + (this.tmenXpPanel.panelVisible?this.tmenXpPanel.width:0);
                    this.crewOperationBtn.showHelpLayoutEx(1,_loc2_);
                }
                _loc1_ = Math.max(this.params.getHelpLayoutWidth(),this.vehResearchPanel.getHelpLayoutWidth());
                if(this.params.visible)
                {
                    this.params.showHelpLayoutEx(this.vehResearchPanel.x - this.params.x,_loc1_);
                }
                if(this.vehResearchPanel.visible)
                {
                    this.vehResearchPanel.showHelpLayoutEx(this.params.x - this.vehResearchPanel.x,_loc1_);
                }
            }
        }
        
        public function as_closeHelpLayout() : void
        {
            if(this._isShowHelpLayout)
            {
                this._isShowHelpLayout = false;
                App.instance.utils.helpLayout.destroyBackground();
                this.crew.closeHelpLayout();
                this.params.closeHelpLayout();
                this.ammunitionPanel.closeHelpLayout();
                this.carousel.closeHelpLayout();
                this.questsControl.closeHelpLayout();
                this.crewOperationBtn.closeHelpLayout();
                this.vehResearchPanel.closeHelpLayout();
            }
        }
        
        public function as_setVehicleIGR(param1:String) : void
        {
            this.igrActionDaysLeft.updateText(param1);
            this.updateElementsPosition();
        }
        
        public function as_setIsIGR(param1:Boolean, param2:String) : void
        {
            if(param1)
            {
                this.igrLabel.visible = true;
                this.igrLabel.mouseChildren = false;
                this.igrLabel.useHandCursor = this.igrLabel.buttonMode = true;
                this.igrLabel.igrText.htmlText = param2;
            }
            else
            {
                this.igrLabel.visible = false;
            }
            this.updateElementsPosition();
        }
        
        private function updateElementsPosition() : void
        {
            var _loc1_:Number = App.globalVarsMgr.isShowServerStatsS()?this.serverInfo.y + this.serverInfo.height - 5:START_IGR_Y_POS;
            if(this.igrLabel.visible)
            {
                this.igrLabel.y = _loc1_;
                _loc1_ = _loc1_ + (this.igrLabel.height + 1);
            }
            if(this.igrActionDaysLeft.visible)
            {
                this.igrActionDaysLeft.y = _loc1_;
            }
        }
        
        public function getTargetButton() : DisplayObject
        {
            return this.crewOperationBtn;
        }
        
        public function getHitArea() : DisplayObject
        {
            return this.crewOperationBtn;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerComponent(this.crew,Aliases.CREW);
            registerComponent(this.tmenXpPanel,Aliases.TMEN_XP_PANEL);
            registerComponent(this.params,Aliases.PARAMS);
            registerComponent(this.carousel,Aliases.TANK_CAROUSEL);
            registerComponent(this.ammunitionPanel,Aliases.AMMUNITION_PANEL);
            registerFlashComponentS(this.questsControl,Aliases.QUESTS_CONTROL);
            addEventListener(CrewDropDownEvent.SHOW_DROP_DOWN,this.onShowCrewDropwDownHandler);
            if(this.vehResearchPanel != null)
            {
                registerComponent(this.vehResearchPanel,Aliases.RESEARCH_PANEL);
            }
            this.updateElementsPosition();
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:String = null;
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
            this.igrLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onIgrRollOver);
            this.igrLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onIgrRollOut);
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
            removeEventListener(CrewDropDownEvent.SHOW_DROP_DOWN,this.onShowCrewDropwDownHandler);
            App.gameInputMgr.clearKeyHandler(Keyboard.F1,KeyboardEvent.KEY_DOWN);
            App.gameInputMgr.clearKeyHandler(Keyboard.F1,KeyboardEvent.KEY_UP);
            this.crewOperationBtn.removeEventListener(ButtonEvent.CLICK,this.retrainBtnClickHandler);
            if(App.globalVarsMgr.isDevelopmentS())
            {
                App.gameInputMgr.clearKeyHandler(Keyboard.F2,KeyboardEvent.KEY_UP);
            }
            this.vehResearchPanel = null;
            this.tmenXpPanel = null;
            this.crew = null;
            this.params = null;
            this.ammunitionPanel.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
            this.ammunitionPanel = null;
            this.carousel = null;
            this.bottomBg = null;
            this.igrLabel.dispose();
            this.igrLabel = null;
            this.igrActionDaysLeft.dispose();
            this.igrActionDaysLeft = null;
            this.questsControl = null;
            for(_loc1_ in this._serverInfoData)
            {
                delete this._serverInfoData[_loc1_];
                true;
            }
            this._serverInfoData = null;
            this.serverInfo.dispose();
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.serverInfo.relativelyOwner = this.serverInfoBg;
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
            this.updateStage(parent.width,parent.height);
            this.params.mouseEnabled = false;
            this.params.mouseChildren = false;
            mouseEnabled = false;
            this.bottomBg.mouseEnabled = false;
            this.igrLabel.addEventListener(MouseEvent.ROLL_OVER,this.onIgrRollOver);
            this.igrLabel.addEventListener(MouseEvent.ROLL_OUT,this.onIgrRollOut);
            App.gameInputMgr.setKeyHandler(Keyboard.F1,KeyboardEvent.KEY_DOWN,this.showLayoutHandler,true);
            App.gameInputMgr.setKeyHandler(Keyboard.F1,KeyboardEvent.KEY_UP,this.closeLayoutHandler,true);
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
            if(App.globalVarsMgr.isDevelopmentS())
            {
                App.gameInputMgr.setKeyHandler(Keyboard.F2,KeyboardEvent.KEY_UP,this.toggleGUIEditorHandler,true);
            }
            this.crewOperationBtn.tooltip = CREW_OPERATIONS.CREWOPERATIONS_BTN_TOOLTIP;
            this.crewOperationBtn.helpText = LOBBY_HELP.HANGAR_CREWOPERATIONBTN;
            this.crewOperationBtn.addEventListener(ButtonEvent.CLICK,this.retrainBtnClickHandler,false,0,true);
            this.crewOperationBtn.iconSource = RES_ICONS.MAPS_ICONS_TANKMEN_CREW_CREWOPERATIONS;
            this.ammunitionPanel.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
        }
        
        private function onRequestFocusHandler(param1:FocusRequestEvent) : void
        {
            setFocus(param1.focusContainer.getComponentForFocus());
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALIDATE_ENABLED_CREW))
            {
                this.crew.enabled = this.crewEnabled;
                this.crewOperationBtn.enabled = this.crewEnabled;
            }
            if(isInvalid(INVALIDATE_SERVER_INFO))
            {
                this.serverInfo.setValues(this._serverInfoData);
            }
        }
        
        private function alignToCenter(param1:DisplayObject) : void
        {
            if(param1)
            {
                param1.x = width - param1.width >> 1;
            }
        }
        
        private function updatePlayerCounterPosition() : void
        {
            this.serverInfoBg.x = width - this.serverInfoBg.width >> 1;
            this.serverInfo.invalidateSize();
        }
        
        private function closeLayoutHandler() : void
        {
            closeHelpLayoutS();
        }
        
        private function retrainBtnClickHandler(param1:Event) : void
        {
            App.popoverMgr.show(this,Aliases.CREW_OPERATIONS_POPOVER);
        }
        
        private function toggleGUIEditorHandler(param1:InputEvent) : void
        {
            toggleGUIEditorS();
        }
        
        private function handleEscape(param1:InputEvent) : void
        {
            App.contextMenuMgr.hide();
            if(App.helpLayout.isShowed())
            {
                onEscapeS();
            }
        }
        
        private function onShowCrewDropwDownHandler(param1:CrewDropDownEvent) : void
        {
            var _loc2_:Point = globalToLocal(new Point(param1.dropDownref.x,param1.dropDownref.y));
            var _loc3_:IEventCollector = App.utils.events;
            _loc3_.disableDisposingForObj(param1.dropDownref);
            addChild(param1.dropDownref);
            _loc3_.enableDisposingForObj(param1.dropDownref);
            param1.dropDownref.x = _loc2_.x;
            param1.dropDownref.y = _loc2_.y;
        }
        
        private function showLayoutHandler(param1:InputEvent) : void
        {
            if((param1.details.altKey) || (param1.details.ctrlKey) || (param1.details.shiftKey))
            {
                return;
            }
            showHelpLayoutS();
        }
        
        private function onIgrRollOver(param1:MouseEvent) : void
        {
            App.toolTipMgr.showSpecial(Tooltips.IGR_INFO,null);
        }
        
        private function onIgrRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
