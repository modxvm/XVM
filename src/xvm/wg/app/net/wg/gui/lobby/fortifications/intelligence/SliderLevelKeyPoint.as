package net.wg.gui.lobby.fortifications.intelligence
{
    import flash.display.Sprite;
    import net.wg.gui.components.controls.interfaces.ISliderKeyPoint;
    import flash.display.MovieClip;
    
    public class SliderLevelKeyPoint extends Sprite implements ISliderKeyPoint
    {
        
        public function SliderLevelKeyPoint()
        {
            super();
        }
        
        public var levels:MovieClip;
        
        private var _index:int;
        
        private var _tooltip:String;
        
        public function dispose() : void
        {
            this.levels = null;
        }
        
        public function get tooltip() : String
        {
            return this._tooltip;
        }
        
        public function set tooltip(param1:String) : void
        {
            this._tooltip = param1;
        }
        
        public function get index() : int
        {
            return this._index;
        }
        
        public function set index(param1:int) : void
        {
            this._index = param1;
        }
        
        public function get label() : String
        {
            return String(this.levels.currentFrame);
        }
        
        public function set label(param1:String) : void
        {
            this.levels.gotoAndStop(parseInt(param1));
            this.levels.x = -this.levels.width >> 1;
        }
    }
}
