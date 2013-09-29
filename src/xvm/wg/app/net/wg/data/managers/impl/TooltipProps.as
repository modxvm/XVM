package net.wg.data.managers.impl 
{
    import net.wg.data.constants.*;
    import net.wg.data.managers.*;
    
    public class TooltipProps extends Object implements net.wg.data.managers.ITooltipProps
    {
        public function TooltipProps(arg1:String, arg2:Number, arg3:Number, arg4:Number=0, arg5:Number=-1, arg6:Number=0, arg7:Number=0)
        {
            super();
            this._type = arg1;
            this._x = arg2;
            this._y = arg3;
            this._minWidth = arg4;
            this._drawDelay = arg5;
            this._showDelay = arg6;
            this._maxWidth = arg7;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function get x():Number
        {
            return this._x;
        }

        public function get y():Number
        {
            return this._y;
        }

        public function get minWidth():Number
        {
            return this._minWidth;
        }

        public function get drawDelay():Number
        {
            return this._drawDelay;
        }

        public function get showDelay():Number
        {
            return this._showDelay;
        }

        public function get maxWidth():Number
        {
            return this._maxWidth;
        }

        public static const WARNING:net.wg.data.managers.impl.TooltipProps=new TooltipProps(net.wg.data.constants.Tooltips.TYPE_WARNING, 0, 0, 0, -1, 0, 0);

        public static const DEFAULT:net.wg.data.managers.impl.TooltipProps=new TooltipProps(net.wg.data.constants.Tooltips.TYPE_INFO, 0, 0, 0, -1, 0, 0);

        internal var _type:String=null;

        internal var _x:Number=0;

        internal var _y:Number=0;

        internal var _minWidth:Number=0;

        internal var _drawDelay:Number=-1;

        internal var _showDelay:Number=0;

        internal var _maxWidth:Number=0;
    }
}
