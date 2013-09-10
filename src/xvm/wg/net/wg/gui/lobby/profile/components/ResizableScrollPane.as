package net.wg.gui.lobby.profile.components 
{
    import flash.events.*;
    
    public class ResizableScrollPane extends net.wg.gui.lobby.profile.components.ScrollPane
    {
        public function ResizableScrollPane()
        {
            super();
            return;
        }

        protected override function applyTargetChanges():void
        {
            if (target) 
                target.removeEventListener(flash.events.Event.RESIZE, this.resizeHandler);
            target.addEventListener(flash.events.Event.RESIZE, this.resizeHandler, false, 0, true);
            super.applyTargetChanges();
            return;
        }

        internal function resizeHandler(arg1:flash.events.Event):void
        {
            _scrollPosition = Math.max(0, Math.min(maxScroll, Math.round(_scrollPosition)));
            invalidateSize();
            return;
        }

        public override function dispose():void
        {
            if (target) 
                target.removeEventListener(flash.events.Event.RESIZE, this.resizeHandler);
            super.dispose();
            return;
        }
    }
}
