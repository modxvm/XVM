package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.HangarMeta;
    import net.wg.gui.lobby.hangar.interfaces.IHangar;
    import net.wg.gui.components.controls.IconButton;
    import net.wg.gui.lobby.hangar.crew.Crew;
    import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
    import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
    import flash.display.Sprite;
    import net.wg.gui.lobby.header.QuestsControl;
    import flash.display.DisplayObject;
    import net.wg.data.Aliases;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.events.LobbyEvent;
    import scaleform.clik.events.ButtonEvent;
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
        }
        
        private static var CAROUSEL_AMMUNITION_PADDING:int = 7;
        
        private static var PARAMS_RIGHT_MARGIN:int = 0;
        
        private static var RESEARCH_PANEL_RIGHT_MARGIN:int = 290;
        
        private static var MESSENGER_BAR_PADDING:int = 45;
        
        private static var INVALIDATE_ENABLED_CREW:String = "InvalidateEnabledCrew";
        
        public var vehResearchPanel:ResearchPanel;
        
        public var tmenXpPanel:TmenXpPanel;
        
        public var crewOperationBtn:IconButton;
        
        public var crew:Crew;
        
        public var params:Params;
        
        public var carousel:TankCarousel;
        
        public var ammunitionPanel:AmmunitionPanel;
        
        public var bottomBg:Sprite;
        
        public var igrLabel:IgrLabel;
        
        public var questsControl:QuestsControl;
        
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
            this.updateIgrPosition();
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
        
        public function as_setCrewEnabled(param1:Boolean) : void
        {
            this.crewEnabled = param1;
            invalidate(INVALIDATE_ENABLED_CREW);
        }
        
        public function as_setCarouselEnabled(param1:Boolean) : void
        {
            this.carousel.enabled = param1;
        }
        
        public function as_setupAmmunitionPanel(param1:String, param2:String, param3:Boolean, param4:Boolean) : void
        {
            this.ammunitionPanel.setVehicleStatus(param1,param2);
            this.ammunitionPanel.disableAmmunitionPanel(!param3);
            this.ammunitionPanel.disableTuningButton(!param4);
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
            if(!this._isShowHelpLayout)
            {
                this._isShowHelpLayout = true;
                if(this.crew.visible)
                {
                    this.crew.showHelpLayout();
                }
                if(this.params.visible)
                {
                    this.params.showHelpLayout();
                }
                if(this.ammunitionPanel.visible)
                {
                    this.ammunitionPanel.showHelpLayout();
                }
                if(this.carousel.visible)
                {
                    this.carousel.showHelpLayout();
                }
                if(this.vehResearchPanel.visible)
                {
                    this.vehResearchPanel.showHelpLayout();
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
                this.vehResearchPanel.closeHelpLayout();
            }
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
        }
        
        override protected function onDispose() : void
        {
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
            this.ammunitionPanel = null;
            this.carousel = null;
            this.bottomBg = null;
            this.igrLabel.dispose();
            this.igrLabel = null;
            this.questsControl = null;
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
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
            this.crewOperationBtn.addEventListener(ButtonEvent.CLICK,this.retrainBtnClickHandler,false,0,true);
            this.crewOperationBtn.iconSource = RES_ICONS.MAPS_ICONS_TANKMEN_CREW_CREWOPERATIONS;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALIDATE_ENABLED_CREW))
            {
                this.crew.enabled = this.crewEnabled;
                this.crewOperationBtn.enabled = this.crewEnabled;
            }
        }
        
        private function updateIgrPosition() : void
        {
            if(this.igrLabel)
            {
                this.igrLabel.x = width - this.igrLabel.width >> 1;
            }
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
