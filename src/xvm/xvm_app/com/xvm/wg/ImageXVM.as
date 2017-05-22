package com.xvm.wg
{
    import flash.events.*;
    import net.wg.infrastructure.interfaces.IImageData;

    public class ImageXVM extends ImageWG
    {
        public var successCallback : Function;

        public var errorCallback : Function;

        public function ImageXVM()
        {
            super();
        }

        override public function dispose() : void
        {
            super.dispose();
            successCallback = null;
            errorCallback = null;
        }

        override protected function setImgData(param1:IImageData) : void
        {
            super.setImgData(param1);
            if(this._imgData.ready)
            {
                imageDataReady();
            }
        }

        override protected function onImgDataCompleteHandler(param1:Event) : void
        {
            super.onImgDataCompleteHandler(param1);
            imageDataReady();
        }

        override protected function onImgDataIoErrorHandler(param1:IOErrorEvent) : void
        {
            super.onImgDataIoErrorHandler(param1);
            if (_loadFailed)
            {
                if (errorCallback != null) {
                    errorCallback();
                }
            }
        }

        protected function imageDataReady() : void
        {
            if (successCallback != null) {
                successCallback();
            }
        }
    }
}
