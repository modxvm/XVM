package net.wg.gui.components.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.events.*;

    public class UILoaderAlt extends flash.display.Sprite implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function UILoaderAlt()
        {
            super();
            this._width = width;
            this._height = height;
            this.loader = new flash.display.Loader();
            addChild(this.loader);
            this.background.visible = false;
            var loc1:*;
            scaleY = loc1 = 1;
            scaleX = loc1;
            this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.onLoadComplete);
            this.loader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            this.loader.contentLoaderInfo.addEventListener(flash.events.Event.UNLOAD, this.onUnloadComplete);
            return;
        }

        public function get originalHeight():Number
        {
            return this._height;
        }

        public function get maintainAspectRatio():Boolean
        {
            return this._maintainAspectRatio;
        }

        public function set maintainAspectRatio(arg1:Boolean):void
        {
            this._maintainAspectRatio = arg1;
            return;
        }

        public function unload():void
        {
            if (this._loadInProgress)
                this.loader.close();
            this._unloadInProgress = true;
            if (this.loader.contentLoaderInfo.contentType != CONTENT_TYPE_SWF)
                this.loader.unload();
            else
                this.loader.unloadAndStop(true);
            this._source = null;
            this._sizeRetries = 0;
            return;
        }

        public function get originalWidth():Number
        {
            return this._width;
        }

        public function invalidate():void
        {
            if (this._invalid)
                if (stage != null)
                    stage.invalidate();
            else
            {
                this._invalid = true;
                if (stage != null)
                {
                    addEventListener(flash.events.Event.ENTER_FRAME, this.handleEnterFrameValidation, false, 0, true);
                    addEventListener(flash.events.Event.RENDER, this.updateSize, false, 0, true);
                    stage.invalidate();
                }
                else
                    addEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleStageChange, false, 0, true);
            }
            return;
        }

        protected function handleStageChange(arg1:flash.events.Event):void
        {
            if (arg1.type == flash.events.Event.ADDED_TO_STAGE)
            {
                removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleStageChange, false);
                addEventListener(flash.events.Event.RENDER, this.updateSize, false, 0, true);
                if (stage != null)
                    stage.invalidate();
            }
            return;
        }

        protected function handleEnterFrameValidation(arg1:flash.events.Event):void
        {
            this.updateSize();
            return;
        }

        internal function toggleVisible(arg1:Boolean):void
        {
            if (this.hideLoader)
                this.loader.visible = arg1;
            return;
        }

        internal function updateSize(arg1:flash.events.Event=null):void
        {
            var loc1:*=NaN;
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleStageChange);
            removeEventListener(flash.events.Event.ENTER_FRAME, this.handleEnterFrameValidation);
            removeEventListener(flash.events.Event.RENDER, this.updateSize);
            if (this._autoSize)
            {
                if (this.loader.width <= 0)
                {
                    if (this._sizeRetries < 10)
                    {
                        var loc2:*;
                        var loc3:*=((loc2 = this)._sizeRetries + 1);
                        loc2._sizeRetries = loc3;
                        this.invalidate();
                    }
                    else
                        DebugUtils.LOG_DEBUG("Warning: " + this + "cannot be autoSized because content width is <= 0!");
                    return;
                }
                if (this._maintainAspectRatio)
                {
                    loc1 = Math.min(this._height / this.loader.height, this._width / this.loader.width);
                    this.loader.width = Math.round(this.loader.width * loc1);
                    this.loader.height = Math.round(this.loader.height * loc1);
                }
                else
                {
                    this.loader.width = Math.round(this.loader.width * this._width / this.loader.width);
                    this.loader.height = Math.round(this.loader.height * this._height / this.loader.height);
                }
            }
            else
            {
                width = this.loader.width;
                height = this.loader.height;
                this.loader.scaleX = 1 / scaleX;
                this.loader.scaleY = 1 / scaleY;
            }
            this.toggleVisible(true);
            dispatchEvent(new net.wg.gui.events.UILoaderEvent(net.wg.gui.events.UILoaderEvent.COMPLETE));
            this._invalid = false;
            return;
        }

        internal function startLoad(arg1:String):void
        {
            this._source = arg1;
            if (!this._previousContentUnloaded)
                this.loader.unload();
            this.toggleVisible(false);
            this._loadInProgress = true;
            this._previousContentUnloaded = false;
            var loc1:*=new flash.net.URLRequest(arg1);
            var loc2:*=new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain);
            this.loader.load(loc1, loc2);
            return;
        }

        internal function onIOError(arg1:flash.events.IOErrorEvent):void
        {
            if (!this._loadFailed && this._sourceAlt)
            {
                this._loadFailed = true;
                this.startLoad(this._sourceAlt);
            }
            else
            {
                dispatchEvent(new net.wg.gui.events.UILoaderEvent(net.wg.gui.events.UILoaderEvent.IOERROR));
                this._loadInProgress = false;
            }
            return;
        }

        public function startLoadAlt():void
        {
            this.startLoad(this._sourceAlt);
            return;
        }

        internal function onUnloadComplete(arg1:flash.events.Event):void
        {
            this._previousContentUnloaded = true;
            this._unloadInProgress = false;
            return;
        }

        internal function removeLoaderListener():void
        {
            this.loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, this.onLoadComplete);
            this.loader.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            this.loader.contentLoaderInfo.removeEventListener(flash.events.Event.UNLOAD, this.onUnloadComplete);
            return;
        }

        public function set autoSize(arg1:Boolean):void
        {
            this._autoSize = arg1;
            return;
        }

        public function dispose():void
        {
            if (this.loader)
            {
                this.removeLoaderListener();
                this.unload();
                removeChild(this.loader);
                this.loader = null;
            }
            if (this.background)
            {
                removeChild(this.background);
                this.background = null;
            }
            return;
        }

        public override function get visible():Boolean
        {
            return super.visible;
        }

        public override function set visible(arg1:Boolean):void
        {
            super.visible = arg1;
            dispatchEvent(new scaleform.clik.events.ComponentEvent(arg1 ? scaleform.clik.events.ComponentEvent.SHOW : scaleform.clik.events.ComponentEvent.HIDE));
            return;
        }

        public function get autoSize():Boolean
        {
            return this._autoSize;
        }

        internal function onLoadComplete(arg1:flash.events.Event):void
        {
            this._loadFailed = false;
            this._loadInProgress = false;
            this.updateSize();
            return;
        }

        public function get source():String
        {
            return this._source;
        }

        public function set source(arg1:String):void
        {
            this._loadFailed = false;
            if (!arg1 || arg1 == this._source)
                return;
            this.startLoad(arg1);
            return;
        }

        public function get sourceAlt():String
        {
            return this._sourceAlt;
        }

        public function set sourceAlt(arg1:String):void
        {
            if (!arg1 || this._sourceAlt == arg1)
                return;
            this._sourceAlt = arg1;
            if (this._loadFailed)
                this.startLoad(this._sourceAlt);
            return;
        }

        internal static const CONTENT_TYPE_SWF:String="application/x-shockwave-flash";

        public var background:flash.display.Sprite;

        public var hideLoader:Boolean=false;

        public var enableInitCallback:Boolean=false;

        internal var _autoSize:Boolean=true;

        internal var _loadFailed:Boolean;

        internal var _previousContentUnloaded:Boolean;

        internal var _loadInProgress:Boolean;

        internal var _sourceAlt:String;

        internal var _maintainAspectRatio:Boolean=true;

        internal var _unloadInProgress:Boolean;

        internal var _sizeRetries:int;

        internal var _width:Number;

        internal var _height:Number;

        internal var loader:flash.display.Loader;

        internal var _invalid:Boolean=false;

        internal var _source:String;
    }
}
