package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.FrameLabel;
    
    public class InfoIcon extends UIComponent
    {
        
        public function InfoIcon()
        {
            this._icoType = TYPE_INFO;
            super();
        }
        
        public static var TYPE_INFO:String = "info";
        
        public static var CHECK_BOX_MARGIN:Number = 10;
        
        private var INVALIDATE_ICO:String = "ico_invalid";
        
        private var _icoType:String;
        
        private var _tooltip:String = "";
        
        public var hit:MovieClip = null;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.hit.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.hit.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.hit.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.hit.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.hit.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.hit.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
        }
        
        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            if(!(this._tooltip == "") && (enabled))
            {
                App.toolTipMgr.showComplex(this._tooltip);
            }
        }
        
        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onMouseClickHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(this.INVALIDATE_ICO))
            {
                this.gotoAndStop(this.icoType);
            }
        }
        
        public function set icoType(param1:String) : void
        {
            if(param1 == this._icoType || !this.isIcoAvailable(param1))
            {
                return;
            }
            this._icoType = param1;
            invalidate(this.INVALIDATE_ICO);
        }
        
        public function get icoType() : String
        {
            return this._icoType;
        }
        
        public function set tooltip(param1:String) : void
        {
            if(param1 == this._tooltip)
            {
                return;
            }
            this._tooltip = param1;
        }
        
        public function get tooltip() : String
        {
            return this._tooltip;
        }
        
        private function isIcoAvailable(param1:String) : Boolean
        {
            var _loc4_:FrameLabel = null;
            var _loc2_:* = false;
            var _loc3_:uint = 0;
            while(_loc3_ < currentLabels.length)
            {
                _loc4_ = currentLabels[_loc3_];
                if(_loc4_.name == param1)
                {
                    _loc2_ = true;
                    break;
                }
                _loc3_++;
            }
            return _loc2_;
        }
    }
}
