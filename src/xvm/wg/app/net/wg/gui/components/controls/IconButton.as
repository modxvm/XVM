package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    
    public class IconButton extends net.wg.gui.components.controls.SoundButtonEx
    {
        public function IconButton()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.ICON_BTN;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.loader) 
            {
                this.loader.unloadAndStop();
                removeChild(this.loader);
                this.loader = null;
            }
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            this.updateNestedChild = true;
            return;
        }

        public function get iconSource():String
        {
            return this._iconSource;
        }

        public function set iconSource(arg1:String):void
        {
            if (this._iconSource != arg1) 
            {
                this._iconSource = arg1;
                this.isIconSourceChanged = true;
                invalidate();
            }
            return;
        }

        public function get iconOffsetTop():Number
        {
            return this._iconOffsetTop;
        }

        public function set iconOffsetTop(arg1:Number):void
        {
            this._iconOffsetTop = arg1;
            this.arrangeLayout = true;
            invalidate();
            return;
        }

        public function get iconOffsetLeft():Number
        {
            return this._iconOffsetLeft;
        }

        public function set iconOffsetLeft(arg1:Number):void
        {
            this._iconOffsetLeft = arg1;
            this.arrangeLayout = true;
            invalidate();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            super.draw();
            if (this.isIconSourceChanged) 
            {
                this.isIconSourceChanged = false;
                if (this.loader) 
                {
                    this.loader.unload();
                    this.removeIconListeners(this.loader.contentLoaderInfo);
                    removeChild(this.loader);
                    this.loader = null;
                }
                if (!(this._iconSource == null) && !(this._iconSource == "")) 
                {
                    loc1 = new flash.net.URLRequest(this._iconSource);
                    this.loader = new flash.display.Loader();
                    this.addIconListeners(this.loader.contentLoaderInfo);
                    this.loader.load(loc1);
                    this.loader.visible = false;
                    addChild(this.loader);
                }
            }
            if (this.loader && this.contains(this.loader) && this.updateNestedChild) 
            {
                this.setChildIndex(this.loader, (this.numChildren - 1));
                this.updateNestedChild = false;
            }
            if (this.arrangeLayout) 
            {
                this.arrangeLayout = false;
                this.configIcon();
            }
            return;
        }

        protected function addIconListeners(arg1:flash.display.LoaderInfo):void
        {
            arg1.addEventListener(flash.events.Event.COMPLETE, this.iconLoadingCompleteHandler);
            arg1.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.iconLoadingIOErrorHandler);
            return;
        }

        protected function configIcon():void
        {
            if (this.loader) 
            {
                this.loader.x = this._iconOffsetLeft;
                this.loader.y = this._iconOffsetTop;
                var loc1:*;
                this.loader.mouseEnabled = loc1 = false;
                this.loader.tabEnabled = loc1;
                this.loader.visible = true;
                this.loader.scaleX = 1 / this.scaleX;
                this.loader.scaleY = 1 / this.scaleY;
            }
            return;
        }

        internal function removeIconListeners(arg1:flash.display.LoaderInfo):void
        {
            arg1.removeEventListener(flash.events.Event.COMPLETE, this.iconLoadingCompleteHandler);
            arg1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.iconLoadingIOErrorHandler);
            return;
        }

        protected function iconLoadingIOErrorHandler(arg1:flash.events.IOErrorEvent):void
        {
            DebugUtils.LOG_WARNING("Flash :: Icon Loading IO Error!", flash.utils.getQualifiedClassName(this), arg1.toString());
            this.removeIconListeners(flash.display.LoaderInfo(arg1.target));
            return;
        }

        protected function iconLoadingCompleteHandler(arg1:flash.events.Event):void
        {
            this.removeIconListeners(flash.display.LoaderInfo(arg1.target));
            this.arrangeLayout = true;
            invalidate();
            return;
        }

        protected var _iconOffsetTop:Number=0;

        protected var _iconOffsetLeft:Number=0;

        protected var loader:flash.display.Loader;

        internal var _iconSource:String;

        internal var isIconSourceChanged:Boolean;

        internal var arrangeLayout:Boolean;

        internal var updateNestedChild:Boolean=false;
    }
}
