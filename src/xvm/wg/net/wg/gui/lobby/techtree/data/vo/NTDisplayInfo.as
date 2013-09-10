package net.wg.gui.lobby.techtree.data.vo 
{
    import flash.geom.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class NTDisplayInfo extends Object implements net.wg.gui.lobby.techtree.interfaces.IValueObject
    {
        public function NTDisplayInfo(arg1:int=-1, arg2:int=-1, arg3:flash.geom.Point=null, arg4:Array=null)
        {
            super();
            this._row = arg1;
            this._column = arg2;
            this._position = arg3;
            this._lines = arg4;
            return;
        }

        public function get row():int
        {
            return this._row;
        }

        public function get column():int
        {
            return this._column;
        }

        public function get position():flash.geom.Point
        {
            return this._position;
        }

        public function get lines():Array
        {
            return this._lines;
        }

        public function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void
        {
            var loc1:*=null;
            if (arg1.length > 3) 
            {
                this._row = int(arg1[0]);
                this._column = int(arg1[1]);
                loc1 = arg1[2];
                this._position = new flash.geom.Point(loc1[0], loc1[1]);
                this._lines = arg1[3];
            }
            return;
        }

        public function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void
        {
            var loc1:*=null;
            if (arg1 == null) 
                return;
            if (arg1.row != null) 
                this._row = int(arg1.row);
            if (arg1.column != null) 
                this._column = int(arg1.column);
            if (arg1.position != null) 
            {
                loc1 = arg1.position;
                this._position = new flash.geom.Point(loc1[0], loc1[1]);
            }
            if (arg1.lines != null) 
                this._lines = arg1.lines;
            return;
        }

        public function clearUp():void
        {
            this._row = -1;
            this._column = -1;
            this._position = null;
            if (this._lines != null) 
                this._lines.splice(0, this._lines.length);
            return;
        }

        public function toString():String
        {
            return "[NTDisplayInfo: row = " + this._row + ", column = " + this._column + ", position = " + this._position + ", lines = " + this._lines + " ]";
        }

        internal var _row:int;

        internal var _column:int;

        internal var _position:flash.geom.Point;

        internal var _lines:Array;
    }
}
