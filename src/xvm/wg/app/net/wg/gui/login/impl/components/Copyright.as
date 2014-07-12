package net.wg.gui.login.impl.components
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButton;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    
    public class Copyright extends UIComponent
    {
        
        public function Copyright() {
            super();
        }
        
        public var logotypes:MovieClip = null;
        
        public var textField:TextField = null;
        
        public var legalLink:SoundButton = null;
        
        private var LINK_MARGIN:Number = 5;
        
        override protected function configUI() : void {
            super.configUI();
            this.legalLink.addEventListener(MouseEvent.MOUSE_OVER,this.showToolTip);
            this.legalLink.addEventListener(MouseEvent.MOUSE_DOWN,this.hideToolTip);
            this.legalLink.addEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
            this.legalLink.addEventListener(ButtonEvent.CLICK,this.showLegal);
        }
        
        private function showLegal(param1:ButtonEvent) : void {
            dispatchEvent(new CopyrightEvent(CopyrightEvent.TO_LEGAL));
        }
        
        private function hideToolTip(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        private function showToolTip(param1:MouseEvent) : void {
            App.toolTipMgr.showComplex(TOOLTIPS.LOGIN_LEGAL);
        }
        
        override protected function draw() : void {
            super.draw();
        }
        
        public function updateLabel(param1:String, param2:String = "") : void {
            if(param2 == "" || !param2)
            {
                this.textField.text = param1;
                this.legalLink.visible = false;
            }
            else
            {
                this.textField.text = param1 + " | " + param2;
                this.legalLink.visible = true;
                this.updateLinkPosition();
            }
        }
        
        private function updateLinkPosition() : void {
            this.legalLink.x = this.textField.x + (this.textField.width - this.textField.textWidth >> 1) + this.textField.textWidth + this.LINK_MARGIN;
        }
        
        public function get logos() : MovieClip {
            return this.logotypes;
        }
        
        override protected function onDispose() : void {
            this.legalLink.removeEventListener(MouseEvent.MOUSE_OVER,this.showToolTip);
            this.legalLink.removeEventListener(MouseEvent.MOUSE_DOWN,this.hideToolTip);
            this.legalLink.removeEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
            this.legalLink.removeEventListener(ButtonEvent.CLICK,this.showLegal);
            super.onDispose();
        }
    }
}
