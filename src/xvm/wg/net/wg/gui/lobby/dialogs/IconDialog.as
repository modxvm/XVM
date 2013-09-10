package net.wg.gui.lobby.dialogs 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    
    public class IconDialog extends net.wg.infrastructure.base.meta.impl.IconDialogMeta implements net.wg.infrastructure.base.meta.IIconDialogMeta
    {
        public function IconDialog()
        {
            super();
            return;
        }

        public function as_setIcon(arg1:String):void
        {
            this.icon.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.loadingCompleteHandler, false, 0, true);
            this.icon.source = arg1;
            return;
        }

        internal function loadingCompleteHandler(arg1:flash.events.Event):void
        {
            invalidateLayout();
            return;
        }

        protected override function getBackgroundActualHeight():Number
        {
            var loc1:*=this.icon ? this.icon.y + this.icon.height : 0;
            return Math.max(loc1, super.getBackgroundActualHeight());
        }

        protected override function onDispose():void
        {
            if (this.icon) 
            {
                this.icon.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.loadingCompleteHandler);
                this.icon.dispose();
                if (this.icon.parent) 
                {
                    this.icon.parent.removeChild(this.icon);
                }
                this.icon = null;
            }
            super.onDispose();
            return;
        }

        public var icon:net.wg.gui.components.controls.UILoaderAlt;
    }
}
