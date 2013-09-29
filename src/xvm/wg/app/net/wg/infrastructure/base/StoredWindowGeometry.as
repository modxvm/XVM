package net.wg.infrastructure.base 
{
    import net.wg.infrastructure.interfaces.*;
    
    public class StoredWindowGeometry extends Object implements net.wg.infrastructure.interfaces.IWindowGeometry
    {
        public function StoredWindowGeometry(arg1:Number, arg2:Number, arg3:Number, arg4:Number)
        {
            super();
            this._x = arg1;
            this._y = arg2;
            this._width = arg3;
            this._height = arg4;
            this.doPositionOnce = false;
            return;
        }

        public function canOverwrite():Boolean
        {
            return false;
        }

        public function setSize(arg1:net.wg.infrastructure.interfaces.IWindow):Boolean
        {
            arg1.updateSize(this._width, this._height);
            return true;
        }

        public function setPosition(arg1:net.wg.infrastructure.interfaces.IWindow):Boolean
        {
            var loc1:*=false;
            if (!this.doPositionOnce && arg1) 
            {
                arg1.x = this._x;
                arg1.y = this._y;
                loc1 = true;
            }
            return loc1;
        }

        internal var _x:Number;

        internal var _y:Number;

        internal var _width:Number;

        internal var _height:Number;

        internal var doPositionOnce:Boolean;
    }
}
