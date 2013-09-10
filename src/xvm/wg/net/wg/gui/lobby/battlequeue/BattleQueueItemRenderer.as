package net.wg.gui.lobby.battlequeue 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.interfaces.*;
    
    public class BattleQueueItemRenderer extends scaleform.clik.core.UIComponent implements scaleform.clik.interfaces.IListItemRenderer
    {
        public function BattleQueueItemRenderer()
        {
            super();
            return;
        }

        public function setData(arg1:Object):void
        {
            this.data = arg1;
            invalidate();
            return;
        }

        protected override function draw():void
        {
            if (this.data) 
            {
                if (this.textField && !(this.data.type == null)) 
                {
                    this.textField.text = typeof this.data.type != "number" ? this.data.type : String(this.data.type);
                }
                if (this.countField && !(this.data.count == null)) 
                {
                    this.countField.text = typeof this.data.count != "number" ? this.data.count : App.utils.locale.integer(this.data.count);
                }
            }
            super.draw();
            return;
        }

        public function setListData(arg1:scaleform.clik.data.ListData):void
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

        public function get owner():scaleform.clik.core.UIComponent
        {
            return this._owner;
        }

        public function set owner(arg1:scaleform.clik.core.UIComponent):void
        {
            this._owner = arg1;
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

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            if (this._selected == arg1) 
            {
                return;
            }
            this._selected = arg1;
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        public override function toString():String
        {
            return "[WG BattleQueueItemRenderer " + name + "]";
        }

        protected var _index:uint=0;

        protected var _owner:scaleform.clik.core.UIComponent=null;

        protected var _selectable:Boolean=false;

        protected var _selected:Boolean=false;

        protected var _data:Object;

        public var textField:flash.text.TextField;

        public var countField:flash.text.TextField;
    }
}
