package net.wg.gui.lobby.header.ny
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.geom.Rectangle;
    
    public class SnowPlace extends Sprite implements IDisposable
    {
        
        public function SnowPlace()
        {
            super();
            this._width = super.width;
            this.init();
        }
        
        private static var SNOW_FLAKES:Number = 20;
        
        private static var FLAKE_LINKAGE:String = "FlakeUI";
        
        private static var FLAKE_ANIM_LINKAGE:String = "FlakeAnimLinkageUI";
        
        private var _flakes:Vector.<FlakeAnim> = null;
        
        private var _rect:Rectangle = null;
        
        private var _width:Number = 0;
        
        override public function get width() : Number
        {
            return this._width;
        }
        
        private function init() : void
        {
            this._flakes = new Vector.<FlakeAnim>();
            this._rect = new Rectangle(0,0,200,150);
            this.mouseEnabled = false;
            this.mouseChildren = false;
        }
        
        private function createFlake(param1:Number) : void
        {
            var _loc2_:FlakeAnim = App.utils.classFactory.getComponent(FLAKE_ANIM_LINKAGE,FlakeAnim);
            this._flakes.push(_loc2_);
            _loc2_.start(this._rect);
            this.addChild(_loc2_);
        }
        
        public function dispose() : void
        {
            this.clearFlakes();
            this._flakes = null;
        }
        
        private function clearFlakes() : void
        {
            var _loc1_:FlakeAnim = null;
            if(this._flakes)
            {
                while(this._flakes.length)
                {
                    _loc1_ = this._flakes.pop();
                    _loc1_.dispose();
                    this.removeChild(_loc1_);
                }
            }
        }
        
        public function start() : void
        {
            var _loc1_:Number = 0;
            while(_loc1_ < SNOW_FLAKES)
            {
                this.createFlake(_loc1_);
                _loc1_++;
            }
        }
        
        public function stop() : void
        {
            this.clearFlakes();
        }
    }
}
