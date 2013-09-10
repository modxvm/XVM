package net.wg.gui.components.controls 
{
    import scaleform.clik.core.*;
    
    public class ContextMenuItemSeparate extends scaleform.clik.core.UIComponent
    {
        public function ContextMenuItemSeparate()
        {
            this._items = [];
            this.subItems = [];
            super();
            return;
        }

        public function get items():Array
        {
            return this._items;
        }

        public var id:String="";

        public var index:Number=0;

        internal var _items:Array;

        public var subItems:Array;
    }
}
