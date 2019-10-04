package net.wg.gui.lobby.epicBattles.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;

    public class BackgroundComponent extends MovieClip implements IDisposable
    {

        private static const BG_LOADER_NAME:String = "BgLoader";

        public var vignetteMC:MovieClip = null;

        private var _width:int = 0;

        private var _height:int = 0;

        private var _loader:Loader = null;

        private var _bgIsLoaded:Boolean = false;

        public function BackgroundComponent()
        {
            super();
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
            this._loader.name = BG_LOADER_NAME;
            addChildAt(this._loader,0);
        }

        public final function dispose() : void
        {
            if(this._loader != null)
            {
                if(this._bgIsLoaded)
                {
                    this._loader.unload();
                }
                this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
                this._loader = null;
            }
            this.vignetteMC = null;
        }

        public function setBackground(param1:String) : void
        {
            this._bgIsLoaded = false;
            var _loc2_:URLRequest = new URLRequest(param1);
            var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
            this._loader.scaleX = 1;
            this._loader.scaleY = 1;
            this._loader.load(_loc2_,_loc3_);
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            this._width = param1;
            this._height = param2;
            this.resize();
            this.vignetteMC.width = param1;
            this.vignetteMC.height = param2;
        }

        private function resize() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            if(this._bgIsLoaded)
            {
                _loc1_ = this._loader.width / this._loader.scaleX;
                _loc2_ = this._loader.height / this._loader.scaleY;
                if(this._height < _loc2_ * this._width / _loc1_)
                {
                    this._loader.width = this._width;
                    this._loader.scaleY = this._loader.scaleX;
                }
                else
                {
                    this._loader.height = this._height;
                    this._loader.scaleX = this._loader.scaleY;
                }
                this._loader.y = -y | 0;
            }
        }

        private function onLoaderCompleteHandler(param1:Event) : void
        {
            this._bgIsLoaded = true;
            this.resize();
        }
    }
}
