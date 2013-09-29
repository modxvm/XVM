package net.wg.gui.notification 
{
    import flash.display.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.interfaces.*;
    
    public class ServiceMessageItemRenderer extends net.wg.gui.notification.ServiceMessage implements scaleform.clik.interfaces.IListItemRenderer
    {
        public function ServiceMessageItemRenderer()
        {
            super();
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
            return;
        }

        public function setData(arg1:Object):void
        {
            this.data = arg1;
            return;
        }

        public override function toString():String
        {
            return "[Service message ListItemRenderer " + this.index + ", " + name + "]";
        }

        protected override function configUI():void
        {
            var loc2:*=null;
            super.configUI();
            focusTarget = this._owner;
            var loc3:*;
            tabChildren = loc3 = false;
            tabEnabled = loc3 = loc3;
            _focusable = loc3;
            var loc1:*=0;
            while (loc1 < numChildren) 
            {
                loc2 = getChildAt(loc1) as flash.display.InteractiveObject;
                if (loc2 && !(loc2 == textField) && !(loc2 == btnMoreInfo)) 
                {
                    loc2.mouseEnabled = false;
                }
                ++loc1;
            }
            return;
        }

        public function get owner():scaleform.clik.core.UIComponent
        {
            return this._owner;
        }

        public function set owner(arg1:scaleform.clik.core.UIComponent):void
        {
            this._owner = arg1;
            this.focusTarget = this._owner;
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            this._selected = arg1;
            return;
        }

        internal var _index:uint;

        internal var _selectable:Boolean;

        internal var _selected:Boolean;

        internal var _owner:scaleform.clik.core.UIComponent;
    }
}
