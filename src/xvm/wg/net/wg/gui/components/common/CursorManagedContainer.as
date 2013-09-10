package net.wg.gui.components.common 
{
    import net.wg.data.constants.*;
    
    public class CursorManagedContainer extends net.wg.gui.components.common.ManagedContainer
    {
        public function CursorManagedContainer()
        {
            super();
            manageFocus = false;
            enabled = false;
            mouseEnabled = false;
            mouseChildren = false;
            type = net.wg.data.constants.ContainerTypes.CURSOR;
            return;
        }
    }
}
