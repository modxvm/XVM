package net.wg.gui.components.advanced
{
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    import net.wg.data.managers.IToolTipParams;
    
    public class LineDescrIconText extends LineIconText
    {
        
        public function LineDescrIconText()
        {
            this.hitSprite = new Sprite();
            super();
        }
        
        public static var DESCRIPTION_TEXT_INVALID:String = "dInvalid";
        
        private static function hideToolTip() : void
        {
            App.toolTipMgr.hide();
        }
        
        private var _description:String = "";
        
        private var _tooltip:String = null;
        
        public var textField:TextField;
        
        private var _myEnabled:Boolean = true;
        
        private var _isToolTipShowing:Boolean;
        
        private var hitSprite:Sprite;
        
        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:Graphics = this.hitSprite.graphics;
            _loc1_.beginFill(1,0);
            _loc1_.drawRect(0,0,1,1);
            _loc1_.endFill();
            addChild(this.hitSprite);
            this.hitArea = this.hitSprite;
        }
        
        public function get description() : String
        {
            return this._description;
        }
        
        public function set description(param1:String) : void
        {
            if(this._description != param1)
            {
                this._description = param1;
                invalidate(DESCRIPTION_TEXT_INVALID);
            }
        }
        
        override public function get width() : Number
        {
            return this.textField.x + this.textField.width;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(DESCRIPTION_TEXT_INVALID))
            {
                this.textField.multiline = true;
                this.textField.mouseEnabled = false;
                this.textField.text = this._description;
                invalidateSize();
                dispatchEvent(new Event(Event.RESIZE,true));
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.hitSprite.width = this.width;
                this.hitSprite.height = this.textField.y + this.textField.textHeight;
            }
        }
        
        override protected function applyText(param1:String) : void
        {
            if(this._myEnabled)
            {
                gotoAndPlay("up");
                super.applyText(param1);
            }
            else
            {
                gotoAndPlay("disabled");
                super.applyText("--");
            }
            invalidateSize();
            invalidate(DESCRIPTION_TEXT_INVALID);
        }
        
        protected function mouseRollOverHandler(param1:MouseEvent) : void
        {
            this._isToolTipShowing = true;
            this.showToolTip(null);
        }
        
        protected function mouseRollOutHandler(param1:MouseEvent) : void
        {
            this._isToolTipShowing = false;
            hideToolTip();
        }
        
        protected function showToolTip(param1:IToolTipParams) : void
        {
            if(this._tooltip)
            {
                App.toolTipMgr.showComplex(this._tooltip);
            }
        }
        
        private function disposeHandlers() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
        }
        
        public function get tooltip() : String
        {
            return this._tooltip;
        }
        
        public function set tooltip(param1:String) : void
        {
            this._tooltip = param1;
            this.disposeHandlers();
            if(this._isToolTipShowing)
            {
                hideToolTip();
                this.showToolTip(null);
            }
            if(this._tooltip)
            {
                addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
                addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
            }
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            if(param1 != this._myEnabled)
            {
                this._myEnabled = param1;
                invalidate(TEXT_INVALID);
            }
        }
        
        override public function get enabled() : Boolean
        {
            return this._myEnabled;
        }
        
        override protected function onDispose() : void
        {
            this.disposeHandlers();
            super.onDispose();
        }
    }
}
