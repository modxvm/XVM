package net.wg.gui.components.tooltips.VO 
{
    public class Dimension extends Object
    {
        public function Dimension()
        {
            super();
            return;
        }

        public function get width():Number
        {
            return this._width;
        }

        public function set width(arg1:Number):void
        {
            this._width = arg1;
            return;
        }

        public function get height():Number
        {
            return this._height;
        }

        public function set height(arg1:Number):void
        {
            this._height = arg1;
            return;
        }

        internal var _width:Number=0;

        internal var _height:Number=0;
    }
}
