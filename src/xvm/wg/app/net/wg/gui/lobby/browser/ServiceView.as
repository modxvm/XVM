package net.wg.gui.lobby.browser
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    
    public class ServiceView extends UIComponentEx
    {
        
        public function ServiceView()
        {
            super();
        }
        
        private static var TEXT_HEIGHT_CORRECTION:Number = 5;
        
        public var headerTF:TextField;
        
        public var descriptionTF:TextField;
        
        public function setData(param1:String, param2:String) : void
        {
            this.headerTF.htmlText = param1;
            this.descriptionTF.htmlText = param2;
            this.descriptionTF.height = this.descriptionTF.textHeight + TEXT_HEIGHT_CORRECTION;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            this.headerTF = null;
            this.descriptionTF = null;
            super.onDispose();
        }
    }
}
