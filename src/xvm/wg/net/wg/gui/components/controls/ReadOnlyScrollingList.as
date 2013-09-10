package net.wg.gui.components.controls 
{
    import scaleform.clik.events.*;
    
    public class ReadOnlyScrollingList extends net.wg.gui.components.controls.ScrollingListEx
    {
        public function ReadOnlyScrollingList()
        {
            super();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            return;
        }

        public override function toString():String
        {
            return "[WG ReadOnlyScrollingList " + name + "]";
        }
    }
}
