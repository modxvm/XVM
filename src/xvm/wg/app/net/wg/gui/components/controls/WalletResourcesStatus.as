package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    
    public class WalletResourcesStatus extends UIComponent implements IDisposable
    {
        
        public function WalletResourcesStatus() {
            super();
            this.alertIco.visible = false;
            this.alertIco.alpha = 1;
            this.hit.buttonMode = false;
            this.hit.addEventListener(MouseEvent.ROLL_OVER,this.onOver);
            this.hit.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
        }
        
        public static var STATE_EMPTY:String = "empty";
        
        public static var RESOURCE_ICO_ALIGN_LEFT:String = "resIcoLeft";
        
        public static var RESOURCE_ICO_ALIGN_LEFT_ALERT_RIGHT:String = "resIcoLeftAlertRight";
        
        public static var RESOURCE_ICO_ALIGN_RIGHT:String = "resIcoRight";
        
        public static var RESOURCE_ICO_FOR_TECH_TREE:String = "resIcoForTechTree";
        
        public static var ICO_TYPE_EMPTY:String = "empty";
        
        public static var ICO_TYPE_GOLD:String = "gold";
        
        public static var ICO_TYPE_FREEXP:String = "freeXp";
        
        public static var IN_PROGRESS:uint = 0;
        
        public static var NOT_AVAILABLE:uint = 1;
        
        public static var AVAILABLE:uint = 2;
        
        public var ico:IconText = null;
        
        public var hit:Sprite = null;
        
        public var alertIco:AlertIco = null;
        
        private var _state:String = "";
        
        private var _icoType:String = "";
        
        private function onOut(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        private function onOver(param1:MouseEvent) : void {
            var _loc2_:String = this.getToolTipId();
            if(_loc2_ != "")
            {
                App.toolTipMgr.showComplex(_loc2_);
            }
        }
        
        override protected function onDispose() : void {
            this.hit.removeEventListener(MouseEvent.ROLL_OVER,this.onOver);
            this.hit.removeEventListener(MouseEvent.ROLL_OUT,this.onOut);
            App.toolTipMgr.hide();
        }
        
        public function set state(param1:String) : void {
            if(param1 == this._state)
            {
                return;
            }
            this._state = param1;
            this.visible = !(this._state == STATE_EMPTY);
            invalidateState();
        }
        
        public function get state() : String {
            return this._state;
        }
        
        public function set icoType(param1:String) : void {
            if(param1 == this._icoType)
            {
                return;
            }
            this._icoType = param1;
            invalidateData();
        }
        
        public function get icoType() : String {
            return this._icoType;
        }
        
        public function updateStatus(param1:uint) : Boolean {
            this.visible = !(param1 == AVAILABLE);
            this.alertIco.visible = param1 == NOT_AVAILABLE;
            return this.visible;
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(InvalidationType.STATE)) && !(this._state == STATE_EMPTY))
            {
                gotoAndStop(this._state);
                this.alertIco.x = this._state == RESOURCE_ICO_ALIGN_LEFT_ALERT_RIGHT?35:0;
            }
            if((isInvalid(InvalidationType.DATA)) && !(this._icoType == ""))
            {
                this.ico.icon = this._icoType;
            }
        }
        
        private function getToolTipId() : String {
            var _loc1_:* = "";
            switch(this.icoType)
            {
                case ICO_TYPE_GOLD:
                    _loc1_ = TOOLTIPS.WALLET_NOT_AVAILABLE_GOLD;
                    break;
                case ICO_TYPE_FREEXP:
                    _loc1_ = TOOLTIPS.WALLET_NOT_AVAILABLE_FREEXP;
                    break;
            }
            return _loc1_;
        }
    }
}
