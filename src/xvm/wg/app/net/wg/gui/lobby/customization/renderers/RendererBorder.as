package net.wg.gui.lobby.customization.renderers
{
    import flash.display.MovieClip;
    
    public class RendererBorder extends MovieClip
    {
        
        public function RendererBorder()
        {
            super();
        }
        
        private var _state:String = "up";
        
        public function get state() : String
        {
            return this._state;
        }
        
        public function set state(param1:String) : void
        {
            if(this.state == param1)
            {
                return;
            }
            this._state = param1;
            gotoAndPlay(this.state);
        }
    }
}
