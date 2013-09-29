package net.wg.gui.lobby.hangar.crew 
{
    public class IconsProps extends Object
    {
        public function IconsProps()
        {
            super();
            return;
        }

        public function get alpha():Number
        {
            return this._alpha;
        }

        public function set alpha(arg1:Number):void
        {
            this._alpha = arg1;
            return;
        }

        public function get visible():Boolean
        {
            return this._visible;
        }

        public function set visible(arg1:Boolean):void
        {
            this._visible = arg1;
            return;
        }

        public function get autoSize():String
        {
            return this._autoSize;
        }

        public function set autoSize(arg1:String):void
        {
            this._autoSize = arg1;
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            return;
        }

        internal var _alpha:Number;

        internal var _visible:Boolean;

        internal var _autoSize:String;

        internal var _text:String;
    }
}
