package net.wg.gui.lobby.profile.components.chart.layout 
{
    public class LayoutBase extends Object implements net.wg.gui.lobby.profile.components.chart.layout.IChartLayout
    {
        public function LayoutBase()
        {
            super();
            return;
        }

        public function set gap(arg1:Number):void
        {
            this._gap = arg1;
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        public function set paddingRight(arg1:Number):void
        {
            this._paddingRight = arg1;
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function set paddingLeft(arg1:Number):void
        {
            this._paddingLeft = arg1;
            return;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingTop(arg1:Number):void
        {
            this._paddingTop = arg1;
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingBottom(arg1:Number):void
        {
            this._paddingBottom = arg1;
            return;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public function layout(arg1:uint, arg2:Object):void
        {
            return;
        }

        internal var _gap:Number;

        internal var _paddingRight:Number=0;

        internal var _paddingLeft:Number=0;

        internal var _paddingTop:Number=0;

        internal var _paddingBottom:Number=0;
    }
}
