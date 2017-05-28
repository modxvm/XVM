package com.xvm.wg
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.IImage;
    import flash.display.Bitmap;
    import net.wg.infrastructure.interfaces.IImageData;
    import net.wg.infrastructure.managers.IImageManager;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.display.BitmapData;
    import org.idmedia.as3commons.util.StringUtils;

    public class ImageWG extends Sprite implements IImage
    {

        protected var _bitmap:Bitmap = null;

        protected var _imgData:IImageData = null;

        private var _source:String = "";

        private var _sourceAlt:String = "";

        protected var _loadFailed:Boolean = false;

        protected var _mgr:IImageManager = null;

        public function ImageWG()
        {
            super();
            this._mgr = ImageManagerWG.imageManager;
            this._bitmap = new Bitmap();
            addChild(this._bitmap);
        }

        public function dispose() : void
        {
            this.removeImgData();
            removeChild(this._bitmap);
            this._bitmap = null;
            this._mgr = null;
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

        protected function setImgData(param1:IImageData) : void
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
            this._imgData.addEventListener(IOErrorEvent.IO_ERROR,this.onImgDataIoErrorHandler);
        }

        private function removeImgDataListeners() : void
        {
            this._imgData.removeEventListener(Event.COMPLETE,this.onImgDataCompleteHandler);
            this._imgData.removeEventListener(IOErrorEvent.IO_ERROR,this.onImgDataIoErrorHandler);
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
                this._loadFailed = false;
                this.removeImgData();
                if(this._source)
                {
                    this.setImgData(this._mgr.getImageData(this._source));
                }
            }
        }

        public function get sourceAlt() : String
        {
            return this._sourceAlt;
        }

        public function set sourceAlt(param1:String) : void
        {
            if(this._sourceAlt != param1)
            {
                this._sourceAlt = param1;
                if(this._loadFailed)
                {
                    this.removeImgData();
                    if(this._sourceAlt)
                    {
                        this.setImgData(this._mgr.getImageData(this._sourceAlt));
                    }
                }
            }
        }

        public function set bitmapData(param1:BitmapData) : void
        {
            this._bitmap.bitmapData = param1;
            this._bitmap.visible = param1 != null;
            dispatchEvent(new Event(Event.CHANGE));
        }

        protected function onImgDataCompleteHandler(param1:Event) : void
        {
            this._loadFailed = false;
            this.removeImgDataListeners();
            this._imgData.showTo(this);
        }

        protected function onImgDataIoErrorHandler(param1:IOErrorEvent) : void
        {
            this.removeImgDataListeners();
            if(!this._loadFailed && StringUtils.isNotEmpty(this._sourceAlt))
            {
                this._loadFailed = true;
                this.setImgData(this._mgr.getImageData(this._sourceAlt));
            }
            else
            {
                //orig: ispatchEvent(new Event(Event.CHANGE));
                this._loadFailed = true;
            }
        }
    }
}
