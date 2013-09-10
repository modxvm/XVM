package scaleform.clik.controls 
{
    import scaleform.clik.data.*;
    import scaleform.clik.interfaces.*;
    
    public class ListItemRenderer extends scaleform.clik.controls.Button implements scaleform.clik.interfaces.IListItemRenderer
    {
        public function ListItemRenderer()
        {
            super();
            return;
        }

        public override function get focusable():Boolean
        {
            return _focusable;
        }

        public override function set focusable(arg1:Boolean):void
        {
            return;
        }

        public function get index():uint
        {
            return this._index;
        }

        public function set index(arg1:uint):void
        {
            this._index = arg1;
            return;
        }

        public function get selectable():Boolean
        {
            return this._selectable;
        }

        public function set selectable(arg1:Boolean):void
        {
            this._selectable = arg1;
            return;
        }

        public function setListData(arg1:scaleform.clik.data.ListData):void
        {
            this.index = arg1.index;
            selected = arg1.selected;
            label = arg1.label || "";
            return;
        }

        public function setData(arg1:Object):void
        {
            this.data = arg1;
            return;
        }

        public override function toString():String
        {
            return "[CLIK ListItemRenderer " + this.index + ", " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            focusTarget = owner;
            var loc1:*;
            mouseChildren = loc1 = false;
            tabChildren = loc1 = loc1;
            tabEnabled = loc1 = loc1;
            _focusable = loc1;
            return;
        }

        protected var _index:uint=0;

        protected var _selectable:Boolean=true;
    }
}
