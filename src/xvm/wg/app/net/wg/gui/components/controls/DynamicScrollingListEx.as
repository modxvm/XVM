package net.wg.gui.components.controls 
{
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class DynamicScrollingListEx extends net.wg.gui.components.controls.ScrollingListEx implements net.wg.infrastructure.interfaces.IDynamicContent
    {
        public function DynamicScrollingListEx()
        {
            super();
            return;
        }

        protected override function cleanData():void
        {
            if (_dataProvider) 
            {
                _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange, false);
                _dataProvider = null;
            }
            return;
        }
    }
}
