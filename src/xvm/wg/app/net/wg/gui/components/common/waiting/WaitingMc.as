package net.wg.gui.components.common.waiting
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    
    public class WaitingMc extends UIComponent
    {
        
        public function WaitingMc()
        {
            super();
            id++;
            this.uid = id;
        }
        
        public static var id:int = 0;
        
        public static var TEXT_INVALID:String = "textInv";
        
        public var textField:TextField;
        
        public var uid:int = 0;
        
        private var _text:String = "";
        
        override protected function onDispose() : void
        {
            this.textField = null;
            super.onDispose();
        }
        
        public function setMessage(param1:String) : void
        {
            this._text = param1;
            invalidate(TEXT_INVALID);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(TEXT_INVALID))
            {
                this.textField.text = this._text;
            }
        }
    }
}
