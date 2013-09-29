package net.wg.gui.lobby.customization.renderers 
{
    import flash.display.*;
    
    public class RendererBorder extends flash.display.MovieClip
    {
        public function RendererBorder()
        {
            super();
            return;
        }

        public function get state():String
        {
            return this._state;
        }

        public function set state(arg1:String):void
        {
            if (this.state == arg1) 
            {
                return;
            }
            this._state = arg1;
            gotoAndPlay(this.state);
            return;
        }

        internal var _state:String="up";
    }
}
