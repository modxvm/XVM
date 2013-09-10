package net.wg.gui.components.common 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    
    public class WaitingManagedContainer extends net.wg.gui.components.common.ManagedContainer
    {
        public function WaitingManagedContainer()
        {
            super();
            manageFocus = false;
            enabled = false;
            focusable = false;
            type = net.wg.data.constants.ContainerTypes.WAITING;
            return;
        }

        public override function setFocusedView(arg1:flash.display.DisplayObject):void
        {
            return;
        }
    }
}
