package net.wg.gui.lobby.fortifications.popovers.impl
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.fortifications.data.BuildingPopoverActionVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.Values;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.fortifications.events.FortBuildingCardPopoverEvent;
    
    public class FortPopoverControlPanel extends UIComponentEx
    {
        
        public function FortPopoverControlPanel() {
            super();
            this.orderIcon.visible = false;
        }
        
        public static var TIMER_STATE:String = "orderCommanderState";
        
        public static var ACTION_STATE:String = "commanderState";
        
        public static var DEFAULT_STATE:String = "allPlayersState";
        
        public static var NOT_BASE_NOT_COMMANDER:uint = 3;
        
        private static var BASE_NOT_COMMANDER:uint = 1;
        
        private static var BASE_COMMANDER:uint = 2;
        
        private static var NOT_BASE_COMMANDER_ORDERED:uint = 4;
        
        private static var NOT_BASE_COMMANDER_NOT_ORDERED:uint = 5;
        
        private static var INVALIDATE_BUTTON:String = "invalidateButton";
        
        public var orderTimer:TextField;
        
        public var timeOver:TextField;
        
        public var generalLabel:TextField;
        
        public var actionButton:SoundButtonEx;
        
        public var orderIcon:UILoaderAlt;
        
        private var model:BuildingPopoverActionVO;
        
        private var _currentState:String = "allPlayersState";
        
        public function setData(param1:BuildingPopoverActionVO) : void {
            this.model = param1;
            this.orderIcon.visible = false;
            this.orderTimer.visible = false;
            this.timeOver.visible = false;
            if(this.model.currentState == BASE_COMMANDER || this.model.currentState == NOT_BASE_COMMANDER_NOT_ORDERED)
            {
                gotoAndStop(ACTION_STATE);
                if(this.actionButton)
                {
                    this._currentState = ACTION_STATE;
                    this.generalLabel.htmlText = this.model.generalLabel;
                    invalidate(INVALIDATE_BUTTON);
                }
            }
            else if(this.model.currentState == BASE_NOT_COMMANDER)
            {
                gotoAndStop(DEFAULT_STATE);
                this._currentState = DEFAULT_STATE;
                this.generalLabel.htmlText = this.model.generalLabel;
            }
            else if(this.model.currentState == NOT_BASE_COMMANDER_ORDERED)
            {
                gotoAndStop(TIMER_STATE);
                this._currentState = TIMER_STATE;
                this.orderTimer.visible = true;
                this.orderTimer.autoSize = TextFieldAutoSize.RIGHT;
                this.orderTimer.htmlText = this.model.orderTimer;
                this.orderIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_RESERVE_INPROGRESS_24;
                this.orderIcon.x = this.orderTimer.x - this.orderIcon.width;
                this.orderIcon.visible = true;
                this.timeOver.visible = true;
                this.timeOver.htmlText = this.model.timeOver;
                this.generalLabel.htmlText = this.model.generalLabel;
            }
            
            
        }
        
        public function get currentState() : String {
            return this._currentState;
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(INVALIDATE_BUTTON)) && (this.model))
            {
                this.updateActionButton();
            }
        }
        
        private function updateActionButton() : void {
            this.actionButton.label = this.model.actionButtonLbl;
            this.actionButton.enabled = this.model.enableActionButton;
            if((this.actionButton.visible) && (this.actionButton.enabled))
            {
                this.actionButton.addEventListener(ButtonEvent.CLICK,this.onClickActionButtonHandler);
            }
            if(!(this.model.toolTipData == Values.EMPTY_STR) && (this.actionButton.visible))
            {
                this.actionButton.mouseEnabled = this.actionButton.mouseChildren = true;
                this.actionButton.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                this.actionButton.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            }
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.actionButton.UIID = 80;
        }
        
        override protected function onDispose() : void {
            if(this.actionButton)
            {
                this.actionButton.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                this.actionButton.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
                this.actionButton.removeEventListener(ButtonEvent.CLICK,this.onClickActionButtonHandler);
                this.actionButton.dispose();
                this.actionButton = null;
            }
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            if(this.orderIcon)
            {
                this.orderIcon.dispose();
                this.orderIcon = null;
            }
            super.onDispose();
        }
        
        private function onRollOverHandler(param1:MouseEvent) : void {
            if(!this.actionButton && !this.actionButton.visible)
            {
                return;
            }
            if(this.actionButton.enabled)
            {
                App.toolTipMgr.show(this.model.toolTipData);
            }
            else
            {
                App.toolTipMgr.showComplex(this.model.toolTipData);
            }
        }
        
        private function onRollOutHandler(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        private function onClickActionButtonHandler(param1:ButtonEvent) : void {
            var _loc2_:String = null;
            var _loc3_:uint = 0;
            if(this._currentState == ACTION_STATE && this.model.currentState == BASE_COMMANDER)
            {
                _loc2_ = FortBuildingCardPopoverEvent.DIRECTION_CONTROLL;
                _loc3_ = 1;
            }
            else if(this._currentState == ACTION_STATE && this.model.currentState == NOT_BASE_COMMANDER_NOT_ORDERED)
            {
                _loc2_ = FortBuildingCardPopoverEvent.BUY_ORDER;
            }
            
            if(_loc2_ != null)
            {
                App.eventLogManager.logUIEvent(param1,_loc3_);
                dispatchEvent(new FortBuildingCardPopoverEvent(_loc2_));
            }
        }
    }
}
