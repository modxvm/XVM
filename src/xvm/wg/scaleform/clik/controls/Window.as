package scaleform.clik.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class Window extends scaleform.clik.core.UIComponent
    {
        public function Window()
        {
            super();
            this._contentPadding = new scaleform.clik.utils.Padding(0, 0, 0, 0);
            hitArea = this.hit;
            return;
        }

        public function set source(arg1:String):void
        {
            this._src = arg1;
            invalidate("source");
            return;
        }

        public function get contentPadding():Object
        {
            return this._contentPadding;
        }

        public function set contentPadding(arg1:Object):void
        {
            this._contentPadding = new scaleform.clik.utils.Padding(arg1.top, arg1.right, arg1.bottom, arg1.left);
            invalidate("padding");
            return;
        }

        protected override function preInitialize():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            return;
        }

        protected override function initialize():void
        {
            tabEnabled = false;
            var loc1:*;
            mouseChildren = loc1 = enabled;
            mouseEnabled = loc1;
            super.initialize();
            return;
        }

        protected override function configUI():void
        {
            initSize();
            if (hitArea != null) 
                constraints.addElement("hitArea", hitArea, scaleform.clik.utils.Constraints.ALL);
            if (this.background != null) 
                constraints.addElement("background", this.background, scaleform.clik.utils.Constraints.ALL);
            if (this.titleBtn != null) 
            {
                this.titleBtn.label = this._title || "My Window";
                this.titleBtn.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onWindowStartDrag, false, 0, true);
                constraints.addElement("titleBtn", this.titleBtn, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            }
            if (this.closeBtn != null) 
            {
                this.closeBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onCloseButtonClick, false, 0, true);
                constraints.addElement("closeBtn", this.closeBtn, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            }
            if (this.resizeBtn != null) 
            {
                constraints.addElement("resizeBtn", this.resizeBtn, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
                this.resizeBtn.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onResizeStartDrag, false, 0, true);
            }
            if (this.okBtn != null) 
            {
                constraints.addElement("okBtn", this.okBtn, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
                this.okBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onCloseButtonClick, false, 0, true);
            }
            return;
        }

        protected override function draw():void
        {
            if (isInvalid("source")) 
            {
                this.loadSource();
                this.reflowContent();
            }
            else if (isInvalid("padding")) 
                this.reflowContent();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
                constraints.update(_width, _height);
            return;
        }

        protected function loadSource():void
        {
            var loc1:*=null;
            if (this._src != "") 
            {
                if (this._content) 
                {
                    constraints.removeElement("content");
                    removeChild(this._content);
                }
                loc1 = flash.utils.getDefinitionByName(this._src) as Class;
                if (loc1) 
                    this._content = new loc1();
                else 
                {
                    this._content = null;
                    trace("Error: Cannot load content for " + name + "; symbol " + this._src + " not found!");
                    return;
                }
                addChild(this._content);
                constraints.addElement("content", this._content, scaleform.clik.utils.Constraints.ALL);
                this._content.name = "content";
            }
            return;
        }

        protected function reflowContent():void
        {
            var loc1:*=null;
            if (!this._content) 
                return;
            loc1 = this._contentPadding;
            var loc2:*=constraints.getElement("content");
            var loc3:*;
            loc2.left = loc3 = loc1.left;
            this._content.x = loc3;
            loc2.top = loc3 = loc1.top;
            this._content.y = loc3;
            loc2.right = loc1.right;
            loc2.bottom = loc1.bottom;
            this._content.width = _width - loc1.horizontal;
            this._content.height = _height - loc1.vertical;
            invalidateSize();
            return;
        }

        protected function onWindowStartDrag(arg1:flash.events.Event):void
        {
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onWindowStopDrag, false, 0, true);
            startDrag();
            return;
        }

        protected function onWindowStopDrag(arg1:flash.events.Event):void
        {
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onWindowStopDrag, false);
            stopDrag();
            return;
        }

        protected function onResizeStartDrag(arg1:flash.events.Event):void
        {
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onResizeStopDrag, false, 0, true);
            this._dragProps = [parent.mouseX - (x + width), parent.mouseY - (y + height)];
            stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onResizeMouseMove, false, 0, true);
            return;
        }

        protected function onResizeStopDrag(arg1:flash.events.Event):void
        {
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onResizeMouseMove, false);
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onResizeStopDrag, false);
            return;
        }

        protected function onResizeMouseMove(arg1:flash.events.Event):void
        {
            var loc1:*=Math.max(this.minWidth, Math.min(this.maxWidth, parent.mouseX - x - this._dragProps[0]));
            var loc2:*=Math.max(this.minHeight, Math.min(this.maxHeight, parent.mouseY - y - this._dragProps[1]));
            if (!(loc1 == _width) || !(loc2 == _height)) 
            {
                setSize(loc1, loc2);
                dispatchEvent(new scaleform.clik.events.ResizeEvent(scaleform.clik.events.ResizeEvent.RESIZE, scaleX, scaleY));
            }
            return;
        }

        protected function onCloseButtonClick(arg1:flash.events.MouseEvent):void
        {
            parent.removeChild(this);
            dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.HIDE));
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this._content = null;
            this._contentPadding = null;
            this._dragProps = null;
            this.hit = null;
            return;
        }

        public function get title():String
        {
            return this._title;
        }

        public function set title(arg1:String):void
        {
            this._title = arg1;
            if (!(this.titleBtn == null) && this.titleBtn.initialized) 
                this.titleBtn.label = this._title;
            return;
        }

        public function get source():String
        {
            return this._src;
        }

        public var minWidth:Number=150;

        public var maxWidth:Number=500;

        public var minHeight:Number=150;

        public var maxHeight:Number=500;

        protected var _title:String;

        protected var _src:String="";

        protected var _contentPadding:scaleform.clik.utils.Padding;

        protected var _content:flash.display.DisplayObject;

        protected var _dragProps:Array;

        public var closeBtn:scaleform.clik.controls.Button;

        public var okBtn:scaleform.clik.controls.Button;

        public var resizeBtn:scaleform.clik.controls.Button;

        public var titleBtn:scaleform.clik.controls.Button;

        public var background:flash.display.MovieClip;

        public var hit:flash.display.MovieClip;
    }
}
