package net.wg.gui.components.common.cursor.base 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    
    internal class ResizingCursor extends net.wg.gui.components.common.cursor.base.BaseCursor
    {
        public function ResizingCursor()
        {
            super();
            return;
        }

        public function useResizeCursor(arg1:flash.display.InteractiveObject):void
        {
            assertNotNull(arg1, "window" + net.wg.data.constants.Errors.CANT_NULL);
            arg1.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onResizableObjectRollOver, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onResizableObjectMouseDn, false, 0, true);
            if (arg1 is net.wg.infrastructure.interfaces.IView) 
            {
                arg1.addEventListener(net.wg.infrastructure.events.LifeCycleEvent.ON_BEFORE_DISPOSE, this.onBeforeResizableObjDispose, false, 0, true);
            }
            return;
        }

        public function unUseResizeCursor(arg1:flash.display.InteractiveObject):void
        {
            assertNotNull(arg1, "window" + net.wg.data.constants.Errors.CANT_NULL);
            arg1.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onResizableObjectRollOver);
            arg1.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onResizableObjectMouseDn);
            if (arg1 is net.wg.infrastructure.interfaces.IView) 
            {
                arg1.removeEventListener(net.wg.infrastructure.events.LifeCycleEvent.ON_BEFORE_DISPOSE, this.onBeforeResizableObjDispose);
            }
            return;
        }

        protected override function cursorIsFree():Boolean
        {
            return !this._isOnResizing;
        }

        internal function onResizableObjectRollOver(arg1:flash.events.MouseEvent):void
        {
            setCursor(net.wg.data.constants.Cursors.RESIZE);
            return;
        }

        internal function onResizableObjectMouseDn(arg1:flash.events.MouseEvent):void
        {
            if (this.isLeftButton(arg1)) 
            {
                stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onResizableObjectMouseUp);
                this.setResizing(true);
            }
            return;
        }

        protected final function isLeftButton(arg1:flash.events.MouseEvent):Boolean
        {
            return App.utils.commons.isLeftButton(arg1);
        }

        internal function onResizableObjectMouseUp(arg1:flash.events.MouseEvent):void
        {
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onResizableObjectMouseUp);
            this.setResizing(false);
            return;
        }

        internal function onBeforeResizableObjDispose(arg1:net.wg.infrastructure.events.LifeCycleEvent):void
        {
            var loc1:*=flash.display.InteractiveObject(arg1.target);
            this.unUseResizeCursor(loc1);
            return;
        }

        internal function setResizing(arg1:Boolean):void
        {
            if (arg1 != this._isOnResizing) 
            {
                this._isOnResizing = arg1;
                tryToResetCursor();
            }
            return;
        }

        internal var _isOnResizing:Boolean=false;
    }
}
