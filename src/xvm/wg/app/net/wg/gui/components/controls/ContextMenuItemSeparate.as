package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    
    public class ContextMenuItemSeparate extends UIComponent
    {
        
        public function ContextMenuItemSeparate() {
            this._items = [];
            this.subItems = [];
            super();
        }
        
        public var id:String = "";
        
        public var index:Number = 0;
        
        private var _items:Array;
        
        public var subItems:Array;
        
        public function get items() : Array {
            return this._items;
        }
    }
}
