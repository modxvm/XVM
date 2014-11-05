package net.wg.gui.lobby.hangar
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.data.constants.Values;
    
    public class IgrActionDaysLeft extends UIComponent
    {
        
        public function IgrActionDaysLeft()
        {
            super();
        }
        
        public var igrActionDaysLeft:TextField = null;
        
        public function updateText(param1:String) : void
        {
            this.igrActionDaysLeft.htmlText = param1;
            this.visible = !(param1 == null) && !(param1 == Values.EMPTY_STR);
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
    }
}
