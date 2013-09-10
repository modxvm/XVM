package net.wg.gui.components.windows 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class Window extends scaleform.clik.controls.Window implements net.wg.infrastructure.interfaces.IWindow
    {
        public function Window()
        {
            super();
            this._formBgPadding = this.BG_FORM_DEF_PADDING;
            _contentPadding = this.CONTENT_DEF_PADDING;
            maxWidth = 1024;
            maxHeight = 720;
            titleBtn = this.titleBtnEx;
            closeBtn = this.closeBtnEx;
            resizeBtn = this.resizeBtnEx;
            return;
        }

        public function get sourceView():net.wg.infrastructure.interfaces.IAbstractWindowView
        {
            return this._sourceView;
        }

        public function set sourceView(arg1:net.wg.infrastructure.interfaces.IAbstractWindowView):void
        {
            this._sourceView = arg1;
            if (_content) 
            {
                constraints.removeElement("content");
                removeChild(_content);
            }
            if (this._sourceView) 
            {
                _content = flash.display.DisplayObject(this.sourceView);
                addChild(_content);
                invalidate(INVALID_SRC_VIEW);
            }
            return;
        }

        public function get formBgPadding():scaleform.clik.utils.Padding
        {
            return this._formBgPadding;
        }

        public function set formBgPadding(arg1:scaleform.clik.utils.Padding):void
        {
            this._formBgPadding = arg1;
            invalidate("padding");
            return;
        }

        public function get useBottomBtns():Boolean
        {
            return this._useBottomBtns;
        }

        public function set useBottomBtns(arg1:Boolean):void
        {
            if (this._useBottomBtns == arg1) 
                return;
            this._useBottomBtns = arg1;
            var loc1:*=this.formBgPadding;
            loc1.bottom = this._useBottomBtns ? this.BG_FORM_DEF_PADDING.bottom + this.BTN_PADDING_Y : this.BG_FORM_DEF_PADDING.bottom;
            this.formBgPadding = loc1;
            invalidate("padding");
            return;
        }

        public function setMaxWidth(arg1:Number):void
        {
            maxWidth = arg1;
            return;
        }

        public function get useTabs():Boolean
        {
            return this._useTabs;
        }

        public function set useTabs(arg1:Boolean):void
        {
            if (this._useTabs == arg1) 
                return;
            this._useTabs = arg1;
            var loc1:*=this.formBgPadding;
            loc1.top = this._useTabs ? this.BG_FORM_DEF_PADDING.top + this.TAB_PADDING_Y : this.BG_FORM_DEF_PADDING.top;
            this.formBgPadding = loc1;
            invalidate("padding");
            return;
        }

        public function get showBgForm():Boolean
        {
            return this._showBgForm;
        }

        public function set showBgForm(arg1:Boolean):void
        {
            if (arg1 == this.showBgForm) 
                return;
            this._showBgForm = arg1;
            _contentPadding = this._showBgForm ? this.CONTENT_DEF_PADDING : _contentPadding;
            invalidate("padding");
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (closeBtn != null) 
            {
                closeBtn.removeEventListener(flash.events.MouseEvent.CLICK, this.onCloseButtonClick);
                closeBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.closeButtonClickHandler, false, 0, true);
                constraints.addElement("closeBtn", closeBtn, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            }
            if (this.bgForm) 
            {
                constraints.addElement("bgForm", this.bgForm, scaleform.clik.utils.Constraints.ALL);
                this.bgForm.mouseEnabled = false;
            }
            if (this.minimizeBtn) 
            {
                constraints.addElement("minimizeBtn", this.minimizeBtn, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
                this.minimizeBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onMinimizeButtonClick);
            }
            if (hit) 
                hitArea = hit;
            if (background) 
                background.mouseEnabled = false;
            if (titleBtn) 
                titleBtn.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, onWindowStartDrag);
            return;
        }

        protected override function reflowContent():void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.bgForm.visible = this._showBgForm;
            if (this.showBgForm && this.bgForm) 
            {
                loc1 = this.formBgPadding;
                loc2 = constraints.getElement("bgForm");
                var loc3:*;
                loc2.left = loc3 = loc1.left;
                this.bgForm.x = loc3;
                loc2.top = loc3 = loc1.top;
                this.bgForm.y = loc3;
                loc2.right = loc1.right;
                loc2.bottom = loc1.bottom;
                this.bgForm.width = _width - loc1.horizontal;
                this.bgForm.height = _height - loc1.vertical;
            }
            super.reflowContent();
            return;
        }

        protected function updateSource():void
        {
            if (this.sourceView != null) 
            {
                minWidth = _content.width + contentPadding.horizontal;
                minHeight = _content.height + contentPadding.vertical;
                this.sourceView.geometry.setSize(this);
                constraints.addElement("content", _content, scaleform.clik.utils.Constraints.ALL);
            }
            return;
        }

        protected override function onCloseButtonClick(arg1:flash.events.MouseEvent):void
        {
            if (this.sourceView) 
                this.sourceView.onWindowCloseS();
            return;
        }

        protected function closeButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.onCloseButtonClick(null);
            return;
        }

        protected function onMinimizeButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (this.sourceView && this.sourceView.canMinimize) 
                this.sourceView.handleWindowMinimize();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (_content && contains(_content)) 
                removeChild(_content);
            if (this.sourceView.canDrag) 
                App.cursor.unRegisterDragging(this);
            this.isDisposing = true;
            this.minimizeBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onMinimizeButtonClick);
            titleBtn.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, onWindowStartDrag);
            closeBtn.removeEventListener(flash.events.MouseEvent.CLICK, this.onCloseButtonClick);
            closeBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.closeButtonClickHandler);
            resizeBtn.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, onResizeStartDrag);
            if (okBtn) 
                okBtn.removeEventListener(flash.events.MouseEvent.CLICK, this.onCloseButtonClick);
            this.bgForm = null;
            this._formBgPadding = null;
            okBtn = null;
            this.minimizeBtn = null;
            titleBtn = null;
            closeBtn = null;
            resizeBtn = null;
            return;
        }

        public function setTitleIcon(arg1:String):void
        {
            this.iconMovie.gotoAndStop(arg1);
            invalidate(INVALID_TITLE);
            return;
        }

        public function onStartDrag():void
        {
            startDrag();
            return;
        }

        public function onDragging(arg1:Number, arg2:Number):void
        {
            return;
        }

        public function onEndDrag():void
        {
            stopDrag();
            return;
        }

        public function getDragType():String
        {
            return net.wg.data.constants.DragType.SOFT;
        }

        public function getHitArea():flash.display.InteractiveObject
        {
            return this.titleBtnEx;
        }

        public function updateSize(arg1:Number, arg2:Number, arg3:Boolean=false):void
        {
            if (arg3) 
            {
                arg1 = arg1 + contentPadding.horizontal;
                arg2 = arg2 + contentPadding.vertical;
            }
            _originalWidth = arg1;
            _originalHeight = arg2;
            setActualSize(arg1, arg2);
            setActualScale(1, 1);
            return;
        }

        public function getTitleBtnEx():net.wg.gui.components.controls.TextFieldShort
        {
            return this.titleBtnEx;
        }

        public function getTitleBtn():scaleform.clik.controls.Button
        {
            return titleBtn;
        }

        public function getCloseBtn():scaleform.clik.controls.Button
        {
            return closeBtn;
        }

        protected override function draw():void
        {
            var loc1:*;
            if (isInvalid(INVALID_SRC_VIEW) && this.sourceView) 
            {
                this.updateSource();
                this.showBgForm = this.sourceView.showWindowBg;
                this.minimizeBtn.visible = this.sourceView.canMinimize;
                resizeBtn.visible = this.sourceView.canResize;
                closeBtn.visible = this.sourceView.canClose;
                closeBtn.enabled = this.sourceView.enabledCloseBtn;
                if (this.sourceView.canDrag && !this.draggingRegistered) 
                    try 
                    {
                        App.cursor.registerDragging(this);
                        this.draggingRegistered = true;
                    }
                    catch (e:Error)
                    {
                        trace(e);
                    }
            }
            if (isInvalid("padding", INVALID_SRC_VIEW)) 
                this.reflowContent();
            if (!this.isDisposing && isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
                constraints.update(_width, _height);
            if (isInvalid(INVALID_TITLE)) 
            {
                titleBtn.label = _title || "";
                if (!(this.iconMovie.currentFrame == 0) || !(currentLabel == ("" || null))) 
                {
                    titleBtn.x = this.iconMovie.x + this.iconMovie.width;
                    titleBtn.width = titleBtn.width - this.iconMovie.width;
                }
            }
            return;
        }

        public function setMaxHeight(arg1:Number):void
        {
            maxHeight = arg1;
            return;
        }

        public function getMinWidth():Number
        {
            return minWidth;
        }

        public function setMinWidth(arg1:Number):void
        {
            minWidth = arg1;
            return;
        }

        public function getMinHeight():Number
        {
            return minHeight;
        }

        public function setMinHeight(arg1:Number):void
        {
            minHeight = arg1;
            return;
        }

        public function getConstraints():scaleform.clik.utils.Constraints
        {
            return constraints;
        }

        public function getBackground():flash.display.MovieClip
        {
            return background;
        }

        public function getIconMovie():flash.display.MovieClip
        {
            return this.iconMovie;
        }

        public override function set title(arg1:String):void
        {
            _title = arg1;
            invalidate(INVALID_TITLE);
            return;
        }

        internal const BTN_PADDING_Y:Number=26;

        internal const TAB_PADDING_Y:Number=30;

        internal const CONTENT_DEF_PADDING:scaleform.clik.utils.Padding=new scaleform.clik.utils.Padding(35, 13, 19, 12);

        public const BG_FORM_DEF_PADDING:scaleform.clik.utils.Padding=new scaleform.clik.utils.Padding(33, 11, 16, 10);

        public static const INVALID_SRC_VIEW:String="sourceView";

        internal static const INVALID_TITLE:String="titleInv";

        public var iconMovie:flash.display.MovieClip=null;

        public var minimizeBtn:net.wg.gui.components.controls.SoundButton=null;

        public var titleBtnEx:net.wg.gui.components.controls.TextFieldShort=null;

        public var closeBtnEx:net.wg.gui.components.controls.CloseButton=null;

        public var resizeBtnEx:net.wg.gui.components.controls.SoundButton=null;

        public var bgForm:flash.display.Sprite=null;

        internal var _formBgPadding:scaleform.clik.utils.Padding;

        internal var _useBottomBtns:Boolean=false;

        internal var _useTabs:Boolean=false;

        internal var _showBgForm:Boolean=true;

        internal var draggingRegistered:Boolean=false;

        internal var _sourceView:net.wg.infrastructure.interfaces.IAbstractWindowView=null;

        internal var isDisposing:Boolean=false;
    }
}
