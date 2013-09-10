package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class UILoaderCut extends flash.display.Sprite implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function UILoaderCut()
        {
            super();
            var loc1:*;
            scaleY = loc1 = 1;
            scaleX = loc1;
            this.background.visible = false;
            return;
        }

        public function get cutRect():Object
        {
            return this._cutRect;
        }

        public function set cutRect(arg1:Object):void
        {
            this._cutRect = new flash.geom.Rectangle(arg1.x, arg1.y, arg1.width, arg1.height);
            return;
        }

        public function get source():String
        {
            return this._source;
        }

        public function set source(arg1:String):void
        {
            if (arg1 == null || arg1 == "" || arg1 == this._source) 
                return;
            this._source = arg1;
            var loc1:*=new flash.net.URLRequest(arg1);
            var loc2:*=new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain);
            this.loader = new flash.display.Loader();
            this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.completeHandler);
            this.loader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            this.loader.load(loc1, loc2);
            return;
        }

        internal function completeHandler(arg1:flash.events.Event):void
        {
            graphics.clear();
            var loc1:*=new flash.geom.Matrix(1, 0, 0, 1, -this._cutRect.x, -this._cutRect.y);
            graphics.beginBitmapFill(flash.display.Bitmap(this.loader.content).bitmapData, loc1, false);
            graphics.moveTo(0, 0);
            graphics.lineTo(this._cutRect.width, 0);
            graphics.lineTo(this._cutRect.width, this._cutRect.height);
            graphics.lineTo(0, this._cutRect.height);
            graphics.lineTo(0, 0);
            graphics.endFill();
            this.loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, this.completeHandler);
            this.loader.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            this.loader = null;
            return;
        }

        internal function onIOError(arg1:flash.events.IOErrorEvent):void
        {
            this.loader.unloadAndStop(true);
            this.source = ERROR_URL;
            return;
        }

        public function dispose():void
        {
            this._source = null;
            this._cutRect = null;
            if (this.loader) 
                this.loader.unloadAndStop(true);
            return;
        }

        internal static const ERROR_URL:String="../maps/icons/vehicle/noImage.png";

        public var background:flash.display.MovieClip;

        internal var loader:flash.display.Loader;

        internal var _source:String="";

        internal var _cutRect:flash.geom.Rectangle;
    }
}
