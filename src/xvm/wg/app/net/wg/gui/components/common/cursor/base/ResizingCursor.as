package net.wg.gui.components.common.cursor.base
{
    import flash.display.InteractiveObject;
    import net.wg.data.constants.Errors;
    import flash.events.MouseEvent;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.data.constants.Cursors;
    
    public class ResizingCursor extends BaseCursor
    {
        
        public function ResizingCursor() {
            super();
        }
        
        private var _isOnResizing:Boolean = false;
        
        public function useResizeCursor(param1:InteractiveObject) : void {
            assertNotNull(param1,"window" + Errors.CANT_NULL);
            param1.addEventListener(MouseEvent.ROLL_OVER,this.onResizableObjectRollOver,false,0,true);
            param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onResizableObjectMouseDn,false,0,true);
            if(param1 is IView)
            {
                param1.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onBeforeResizableObjDispose,false,0,true);
            }
        }
        
        public function unUseResizeCursor(param1:InteractiveObject) : void {
            assertNotNull(param1,"window" + Errors.CANT_NULL);
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.onResizableObjectRollOver);
            param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onResizableObjectMouseDn);
            if(param1 is IView)
            {
                param1.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onBeforeResizableObjDispose);
            }
        }
        
        override protected function cursorIsFree() : Boolean {
            return !this._isOnResizing;
        }
        
        private function onResizableObjectRollOver(param1:MouseEvent) : void {
            setCursor(Cursors.RESIZE);
        }
        
        private function onResizableObjectMouseDn(param1:MouseEvent) : void {
            if(this.isLeftButton(param1))
            {
                stage.addEventListener(MouseEvent.MOUSE_UP,this.onResizableObjectMouseUp);
                this.setResizing(true);
            }
        }
        
        protected final function isLeftButton(param1:MouseEvent) : Boolean {
            return App.utils.commons.isLeftButton(param1);
        }
        
        private function onResizableObjectMouseUp(param1:MouseEvent) : void {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onResizableObjectMouseUp);
            this.setResizing(false);
        }
        
        private function onBeforeResizableObjDispose(param1:LifeCycleEvent) : void {
            var _loc2_:InteractiveObject = InteractiveObject(param1.target);
            this.unUseResizeCursor(_loc2_);
        }
        
        private function setResizing(param1:Boolean) : void {
            if(param1 != this._isOnResizing)
            {
                this._isOnResizing = param1;
                tryToResetCursor();
            }
        }
    }
}
