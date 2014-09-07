package net.wg.gui.components.advanced
{
    import scaleform.clik.core.UIComponent;
    
    public class InviteIndicator extends UIComponent
    {
        
        public function InviteIndicator()
        {
            super();
        }
        
        override public function get visible() : Boolean
        {
            return super.visible;
        }
        
        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            if(param1)
            {
                play();
            }
            else
            {
                stop();
            }
        }
    }
}
