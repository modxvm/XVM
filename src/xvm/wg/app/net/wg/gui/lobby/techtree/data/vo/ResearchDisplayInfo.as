package net.wg.gui.lobby.techtree.data.vo 
{
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class ResearchDisplayInfo extends Object implements net.wg.gui.lobby.techtree.interfaces.IValueObject
    {
        public function ResearchDisplayInfo(arg1:Array=null, arg2:String="", arg3:int=-1)
        {
            super();
            this._path = arg1;
            this._renderer = arg2;
            this._level = arg3;
            return;
        }

        public function get path():Array
        {
            return this._path;
        }

        public function get renderer():String
        {
            return this._renderer;
        }

        public function get level():int
        {
            return this._level;
        }

        public function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void
        {
            if (arg1.length > 2) 
            {
                this._path = arg1[0];
                this._renderer = arg1[1];
                this._level = arg1[2];
            }
            return;
        }

        public function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void
        {
            if (arg1 == null) 
            {
                return;
            }
            if (arg1.path) 
            {
                this._path = arg1.path;
            }
            if (arg1.renderer) 
            {
                this._renderer = arg1.renderer;
            }
            if (arg1.level) 
            {
                this._level = arg1.level;
            }
            return;
        }

        public function clearUp():void
        {
            this._renderer = "";
            this._level = -1;
            if (this._path != null) 
            {
                this._path.splice(0, this._path.length);
            }
            return;
        }

        public function isDrawItem():Boolean
        {
            return this._renderer == ITEM_RENDERER;
        }

        public function isDrawVehicle():Boolean
        {
            return this._renderer == VEHICLE_RENDERER;
        }

        public function getDepthOfPath():Number
        {
            return this._path == null ? 0 : this._path.length;
        }

        public function toString():String
        {
            return "[ResearchDisplayInfo: path = " + this._path + ", renderer = " + this._renderer + ", level = " + this._level + "]";
        }

        public static const ITEM_RENDERER:String="item";

        public static const VEHICLE_RENDERER:String="vehicle";

        internal var _path:Array;

        internal var _renderer:String;

        internal var _level:int;
    }
}
