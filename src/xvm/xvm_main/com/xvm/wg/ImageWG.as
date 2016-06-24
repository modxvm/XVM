package com.xvm.wg
{
    import com.xvm.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.IImage;
    import net.wg.infrastructure.interfaces.IImageData;
    import net.wg.infrastructure.managers.IImageManager;

    public class ImageWG extends Sprite implements IImage
    {

        private var _bitmap:Bitmap = null;

        private var _imgData:IImageData = null;

        private var _source:String = "";

        private var _repeatLoadOnError:Boolean = false;

        private var _mgr:IImageManager = null;

        public function ImageWG()
        {
            super();
            this._mgr = Xvm.imageManager;
            this._bitmap = new Bitmap();
            addChild(this._bitmap);
        }

        public function dispose() : void
        {
            this.removeImgData();
            removeChild(this._bitmap);
            this._bitmap = null;
        }

        private function removeImgData() : void
        {
            if(this._imgData != null)
            {
                if(!this._imgData.ready)
                {
                    this.removeImgDataListeners();
                }
                this._imgData = null;
                this.bitmapData = null;
            }
        }

        private function setImgData(param1:IImageData) : void
        {
            this._imgData = param1;
            if(this._imgData.ready)
            {
                this._imgData.showTo(this);
            }
            else
            {
                this.addImgDataListeners();
            }
        }

        private function addImgDataListeners() : void
        {
            this._imgData.addEventListener(Event.COMPLETE,this.onImgDataCompleteHandler);
            this._imgData.addEventListener(IOErrorEvent.IO_ERROR,this.onImgDataIOErrorHandler);
        }

        private function removeImgDataListeners() : void
        {
            this._imgData.removeEventListener(Event.COMPLETE,this.onImgDataCompleteHandler);
            this._imgData.removeEventListener(IOErrorEvent.IO_ERROR,this.onImgDataIOErrorHandler);
        }

        public function get source() : String
        {
            return this._source;
        }

        public function set source(param1:String) : void
        {
            if(this._source != param1)
            {
                this._source = param1;
                this.removeImgData();
                if(this._source != Values.EMPTY_STR && this._source != null)
                {
                    this.setImgData(this._mgr.getImageData(this._source));
                }
            }
        }

        public function set bitmapData(param1:BitmapData) : void
        {
            this._bitmap.bitmapData = param1;
            dispatchEvent(new Event(Event.CHANGE));
        }

        public function get repeatLoadOnError() : Boolean
        {
            return this._repeatLoadOnError;
        }

        public function set repeatLoadOnError(param1:Boolean) : void
        {
            this._repeatLoadOnError = param1;
        }

        private function onImgDataCompleteHandler(param1:Event) : void
        {
            this.removeImgDataListeners();
            this._imgData.showTo(this);
        }

        private function onImgDataIOErrorHandler(param1:IOErrorEvent) : void
        {
            this.removeImgDataListeners();
            if(this._repeatLoadOnError)
            {
                this.setImgData(this._mgr.getImageData(this._source));
            }
        }
    }
}
