package net.wg.infrastructure.events
{
    import flash.events.Event;
    import flash.display.InteractiveObject;
    
    public class DragEvent extends Event
    {
        
        public function DragEvent(param1:String, param2:InteractiveObject, param3:Number, param4:Number) {
            super(param1,bubbles,cancelable);
            this._dragItem = param2;
            this._x = param3;
            this._y = param4;
        }
        
        public static var ON_DRAGGING:String = "onDragging";
        
        public static var START_DRAG:String = "onStartDrag";
        
        public static var END_DRAG:String = "onEndDrag";
        
        private var _dragItem:InteractiveObject = null;
        
        private var _x:Number = 0;
        
        private var _y:Number = 0;
        
        public function get dragItem() : InteractiveObject {
            return this._dragItem;
        }
        
        public function get x() : Number {
            return this._x;
        }
        
        public function get y() : Number {
            return this._y;
        }
    }
}
