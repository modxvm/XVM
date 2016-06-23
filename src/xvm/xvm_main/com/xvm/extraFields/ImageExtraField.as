package com.xvm.extraFields
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import com.xvm.wg.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;

    public class ImageExtraField extends ImageWG implements IExtraField
    {
        private static const ERROR_URL:String = "../maps/icons/vehicle/noImage.png";

        private var format:CExtraField;
        private var loader:Loader;
        private var _source:String = "";

        public function ImageExtraField(format:CExtraField)
        {
            super();

            this.format = format.clone();

            //var x:Number = !isNaN(format.x) ? format.x : 0;
            //var y:Number = !isNaN(format.y) ? format.y : 0;
            //var w:Number = !isNaN(format.w) ? format.w : NaN;
            //var h:Number = format.h != null && !isNaN(format.h) ? format.h : NaN;

            //var img:UILoaderAlt = owner.addChild(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt)) as UILoaderAlt;
            //img.name = "f" + n;
            //img["data"] = {
            //    x: x, y: y, w: w, h: h,
            //    format: format,
            //    align: format.align != null ? format.align : "left"
            //};
            //Logger.addObject(img["data"]);

            //img.alpha = format.alpha != null && !isNaN(format.alpha) ? format.alpha / 100.0 : 1;
            //img.rotation = format.rotation != null && !isNaN(format.rotation) ? format.rotation : 0;

            //autoSize = true;
            //maintainAspectRatio = false;

            //addEventListener(UILoaderEvent.COMPLETE, onExtraMovieClipLoadComplete);

            //cleanupFormat(img, format);
        }

        /*public function set source(url:String):void
        {
            Logger.add(url);
            if (url == null || url == "" || url == this._source)
                return;
            this._source = url;
            var request:URLRequest = new URLRequest(url);
            var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
            if (this.loader)
            {
                this.loader.unloadAndStop(true);
            }
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            this.loader.load(request, context);
            addChild(loader);
        }

        private function completeHandler(e:Event):void
        {
            //graphics.clear();
            //var matrix:Matrix = new Matrix(1,0,0,1,-this._cutRect.x,-this._cutRect.y);
            //graphics.beginBitmapFill(Bitmap(this.loader.content));// .bitmapData, matrix, false);
            //graphics.moveTo(0,0);
            //graphics.lineTo(this._cutRect.width,0);
            //graphics.lineTo(this._cutRect.width,this._cutRect.height);
            //graphics.lineTo(0,this._cutRect.height);
            //graphics.lineTo(0,0);
            //graphics.endFill();
            //addChild(loader.content);
            //visible = true;
            loader.x = 10;
            loader.y = 10;
            loader.visible = true;
            visible = true;
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
            //loader = null;
        }

        private function onIOError(param1:IOErrorEvent) : void
        {
            this.loader.unloadAndStop(true);
            this.source = ERROR_URL;
        }

        public function dispose() : void
        {
            this._source = null;
            if (this.loader)
            {
                this.loader.unloadAndStop(true);
            }
        }*/

        //private static function onExtraMovieClipLoadComplete(e:UILoaderEvent):void
        //{
            //Logger.add("onExtraMovieClipLoadComplete");
            //Logger.addObject(e);

            //var loader:Loader = getChildAt(1) as Loader;

            //this.loader

            //var data:Object = img["data"];
            //if (isNaN(data.w) && data.format.w == null)
            //    data.w = loader.contentLoaderInfo.content.width;
            //if (isNaN(data.h) && data.format.h == null)
            //    data.h = loader.contentLoaderInfo.content.height;
            //Logger.addObject(data, 2);

            //img.visible = false;
            //img.x = 0;
            //img.y = 0;
            //img.width = 0;
            //img.height = 0;
            //alignField(img);
            //App.utils.scheduler.scheduleOnNextFrame(function():void { img.visible = true; } );
        //}

        public function update(options:IVOMacrosOptions):void
        {
            /*var img:UILoaderAlt = f as UILoaderAlt;

            var needAlign:Boolean = false;
            var data:Object = (f.parent as MovieClip).data[f.name];

            if (format.x != null)
            {
                if (format.bindToIcon)
                {
                    value += isLeftPanel
                        ? panel.m_list._x + panel.m_list.width
                        : App.appWidth - panel._x - panel.m_list._x + panel.m_list.width;
                }
                data.x = parseFloat(Macros.Format(null, format.x, options)) || 0;
                needAlign = true;
            }
            if (format.y != null)
            {
                data.y = parseFloat(Macros.Format(null, format.y, options)) || 0;
                needAlign = true;
            }
            if (format.w != null)
            {
                data.w = parseFloat(Macros.Format(null, format.w, options)) || 0;
                needAlign = true;
            }
            if (format.h != null)
            {
                data.h = parseFloat(Macros.Format(null, format.h, options)) || 0;
                needAlign = true;
            }
            if (format.alpha != null)
            {
                var alpha:Number = parseFloat(Macros.Format(null, format.alpha, options));
                f.alpha = isNaN(alpha) ? 1 : alpha / 100.0;
            }
            if (format.rotation != null)
                f.rotation = parseFloat(Macros.Format(null, format.rotation, options)) || 0;

            if (format.src != null && img != null)
            {
                var src:String = "../../" + Macros.Format(null, format.src, options).replace("img://", "");
                if (img.source != src)
                {
                    //Logger.add(img.source + " => " + src);
                    img.visible = true;
                    img.source = src;
                }
            }

            if (needAlign)
                alignField(f);*/
            x = 300;
            source = "../../" + Macros.Format(options.playerName, format.src, options).replace("img://", "");
            Logger.add("../../" + Macros.Format(options.playerName, format.src, options).replace("img://", ""));
        }

        public function alignField():void
        {
            /*var img:UILoaderAlt = field as UILoaderAlt;

            var data:Object = img["data"];
            //Logger.addObject(data);

            var x:Number = data.x;
            var y:Number = data.y;
            var w:Number = data.w;
            var h:Number = data.h;

            if (data.align == "right")
                x -= w;
            else if (data.align == "center")
                x -= w / 2;

            //Logger.add("x:" + x + " y:" + y + " w:" + w + " h:" + h + " align:" + data.align);

            if (img != null)
            {
                if (img.x != x)
                    img.x = x;
                if (img.y != y)
                    img.y = y;
                if (img.width != w || img.height != h)
                {
                    //Logger.add(img.width + "->" + w + " " + x + " " + y);
                    img.width = w;
                    img.height = h;
                }
            }*/
        }


    }
}
