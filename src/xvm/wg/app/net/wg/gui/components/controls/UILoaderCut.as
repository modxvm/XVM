package net.wg.gui.components.controls
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import flash.display.Loader;
    import flash.geom.Rectangle;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.geom.Matrix;
    import flash.display.Bitmap;
    
    public class UILoaderCut extends Sprite implements IDisposable
    {
        
        public function UILoaderCut()
        {
            super();
            scaleX = scaleY = 1;
            this.background.visible = false;
        }
        
        private static var ERROR_URL:String = "../maps/icons/vehicle/noImage.png";
        
        public var background:MovieClip;
        
        private var loader:Loader;
        
        private var _source:String = "";
        
        private var _cutRect:Rectangle;
        
        public function get cutRect() : Object
        {
            return this._cutRect;
        }
        
        public function set cutRect(param1:Object) : void
        {
            this._cutRect = new Rectangle(param1.x,param1.y,param1.width,param1.height);
        }
        
        public function get source() : String
        {
            return this._source;
        }
        
        public function set source(param1:String) : void
        {
            if(param1 == null || param1 == "" || param1 == this._source)
            {
                return;
            }
            this._source = param1;
            var _loc2_:URLRequest = new URLRequest(param1);
            var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this.loader.load(_loc2_,_loc3_);
        }
        
        private function completeHandler(param1:Event) : void
        {
            graphics.clear();
            var _loc2_:Matrix = new Matrix(1,0,0,1,-this._cutRect.x,-this._cutRect.y);
            graphics.beginBitmapFill(Bitmap(this.loader.content).bitmapData,_loc2_,false);
            graphics.moveTo(0,0);
            graphics.lineTo(this._cutRect.width,0);
            graphics.lineTo(this._cutRect.width,this._cutRect.height);
            graphics.lineTo(0,this._cutRect.height);
            graphics.lineTo(0,0);
            graphics.endFill();
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeHandler);
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this.loader = null;
        }
        
        private function onIOError(param1:IOErrorEvent) : void
        {
            this.loader.unloadAndStop(true);
            this.source = ERROR_URL;
        }
        
        public function dispose() : void
        {
            this._source = null;
            this._cutRect = null;
            if(this.loader)
            {
                this.loader.unloadAndStop(true);
            }
        }
    }
}
