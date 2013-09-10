package net.wg.data.components 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class ContextItem extends Object implements net.wg.infrastructure.interfaces.IContextItem
    {
        public function ContextItem(arg1:String, arg2:String, arg3:Object=null, arg4:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>=null)
        {
            super();
            this._id = arg1;
            this._label = arg2;
            this._submenu = arg4;
            this._initData = arg3;
            return;
        }

        public function get id():String
        {
            return this._id;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            return;
        }

        public function get submenu():__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>
        {
            return this._submenu;
        }

        public function set submenu(arg1:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>):void
        {
            this._submenu = arg1;
            return;
        }

        public function get initData():Object
        {
            return this._initData;
        }

        public function set initData(arg1:Object):void
        {
            this._initData = arg1;
            return;
        }

        internal var _id:String;

        internal var _label:String;

        internal var _submenu:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>;

        internal var _initData:Object=null;
    }
}
