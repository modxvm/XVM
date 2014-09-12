package net.wg.gui.components.windows
{
    import scaleform.clik.controls.Window;
    import net.wg.infrastructure.base.interfaces.IWindow;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.SoundButton;
    import net.wg.gui.components.controls.TextFieldShort;
    import net.wg.gui.components.controls.CloseButton;
    import flash.display.Sprite;
    import scaleform.clik.utils.Padding;
    import net.wg.infrastructure.base.interfaces.IAbstractWindowView;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.DragType;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.ITextContainer;
    import scaleform.clik.controls.Button;
    import scaleform.clik.utils.Constraints;
    import net.wg.infrastructure.interfaces.IAbstractWrapperView;
    import flash.display.DisplayObject;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.IManagedContent;
    import net.wg.infrastructure.interfaces.IView;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.utils.ConstrainedElement;
    
    public class Window extends scaleform.clik.controls.Window implements IWindow
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
            resizeBtn.lockDragStateChange = true;
        }
        
        public static var INVALID_SRC_VIEW:String = "windowContent";
        
        private static var INVALID_TITLE:String = "titleInv";
        
        public var iconMovie:MovieClip = null;
        
        public var minimizeBtn:SoundButton = null;
        
        public var titleBtnEx:TextFieldShort = null;
        
        public var closeBtnEx:CloseButton = null;
        
        public var resizeBtnEx:SoundButton = null;
        
        public var bgForm:Sprite = null;
        
        private var isDisposing:Boolean = false;
        
        private var _formBgPadding:Padding;
        
        private var _useBottomBtns:Boolean = false;
        
        private var _useTabs:Boolean = false;
        
        private var _showBgForm:Boolean = true;
        
        private var draggingRegistered:Boolean = false;
        
        private var _windowContent:IAbstractWindowView = null;
        
        public var BG_FORM_DEF_PADDING:Padding = new Padding(33,11,16,10);
        
        private var BTN_PADDING_Y:Number = 26;
        
        private var TAB_PADDING_Y:Number = 30;
        
        private var CONTENT_DEF_PADDING:Padding = new Padding(35,13,19,12);
        
        override protected function onDispose() : void
        {
            if((_content) && (contains(_content)))
            {
                removeChild(_content);
            }
            if((this.windowContent.canDrag) && (initialized))
            {
                App.cursor.unRegisterDragging(this);
            }
            this.isDisposing = true;
            this.minimizeBtn.removeEventListener(ButtonEvent.CLICK,this.onMinimizeButtonClick);
            titleBtn.removeEventListener(MouseEvent.MOUSE_DOWN,onWindowStartDrag);
            closeBtn.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
            closeBtn.removeEventListener(ButtonEvent.CLICK,this.closeButtonClickHandler);
            resizeBtn.removeEventListener(MouseEvent.MOUSE_DOWN,onResizeStartDrag);
            if(okBtn)
            {
                okBtn.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
            }
            this.bgForm = null;
            this._formBgPadding = null;
            okBtn = null;
            this.minimizeBtn = null;
            titleBtn = null;
            closeBtn = null;
            resizeBtn = null;
            super.onDispose();
        }
        
        public function setWindow(param1:IWindow) : void
        {
        }
        
        public function setTitleIcon(param1:String) : void
        {
            this.iconMovie.gotoAndStop(param1);
            invalidate(INVALID_TITLE);
        }
        
        public function onStartDrag() : void
        {
            startDrag();
        }
        
        public function onDragging(param1:Number, param2:Number) : void
        {
        }
        
        public function onEndDrag() : void
        {
            stopDrag();
        }
        
        public function getDragType() : String
        {
            return DragType.SOFT;
        }
        
        public function getHitArea() : InteractiveObject
        {
            return this.titleBtnEx;
        }
        
        public function updateSize(param1:Number, param2:Number, param3:Boolean = false) : void
        {
            if(param3)
            {
                param1 = param1 + contentPadding.horizontal;
                param2 = param2 + contentPadding.vertical;
            }
            _originalWidth = param1;
            _originalHeight = param2;
            setActualSize(param1,param2);
            setActualScale(1,1);
        }
        
        public function getTitleBtnEx() : ITextContainer
        {
            return this.titleBtnEx;
        }
        
        public function getTitleBtn() : Button
        {
            return titleBtn;
        }
        
        public function getCloseBtn() : Button
        {
            return closeBtn;
        }
        
        public function setMaxWidth(param1:Number) : void
        {
            maxWidth = param1;
        }
        
        public function setMaxHeight(param1:Number) : void
        {
            maxHeight = param1;
        }
        
        public function getMinWidth() : Number
        {
            return minWidth;
        }
        
        public function setMinWidth(param1:Number) : void
        {
            minWidth = param1;
        }
        
        public function getMinHeight() : Number
        {
            return minHeight;
        }
        
        public function setMinHeight(param1:Number) : void
        {
            minHeight = param1;
        }
        
        public function getConstraints() : Constraints
        {
            return constraints;
        }
        
        public function getBackground() : MovieClip
        {
            return background;
        }
        
        public function getIconMovie() : MovieClip
        {
            return this.iconMovie;
        }
        
        public function set wrapperContent(param1:IAbstractWrapperView) : void
        {
            this.setWindowContent(IAbstractWindowView(param1));
        }
        
        public function get wrapperContent() : IAbstractWrapperView
        {
            return this._windowContent;
        }
        
        public function setWindowContent(param1:IAbstractWindowView) : void
        {
            this._windowContent = param1;
            if(_content)
            {
                constraints.removeElement("content");
                removeChild(_content);
            }
            if(this._windowContent)
            {
                _content = DisplayObject(this.windowContent);
                addChild(_content);
                if(this.windowContent.canResize)
                {
                    setChildIndex(resizeBtn,numChildren - 1);
                }
                invalidate(INVALID_SRC_VIEW);
            }
        }
        
        override public function set scaleX(param1:Number) : void
        {
            var _loc2_:Number = width;
            super.scaleX = param1;
            dispatchEvent(new WindowEvent(WindowEvent.SCALE_X_CHANGED,_loc2_));
        }
        
        override public function set scaleY(param1:Number) : void
        {
            var _loc2_:Number = height;
            super.scaleY = param1;
            dispatchEvent(new WindowEvent(WindowEvent.SCALE_Y_CHANGED,_loc2_));
        }
        
        override public function set title(param1:String) : void
        {
            _title = param1;
            invalidate(INVALID_TITLE);
        }
        
        public function get isModal() : Boolean
        {
            return this._windowContent.isModal;
        }
        
        public function get modalAlpha() : Number
        {
            return Values.DEFAULT_ALPHA;
        }
        
        public function get window() : IManagedContent
        {
            return this;
        }
        
        public function get sourceView() : IView
        {
            return this._windowContent;
        }
        
        public function get windowContent() : IAbstractWindowView
        {
            return this._windowContent;
        }
        
        public function get containerContent() : IManagedContent
        {
            return this;
        }
        
        public function get formBgPadding() : Padding
        {
            return this._formBgPadding;
        }
        
        public function set formBgPadding(param1:Padding) : void
        {
            this._formBgPadding = param1;
            invalidate("padding");
        }
        
        public function get useBottomBtns() : Boolean
        {
            return this._useBottomBtns;
        }
        
        public function set useBottomBtns(param1:Boolean) : void
        {
            if(this._useBottomBtns == param1)
            {
                return;
            }
            this._useBottomBtns = param1;
            var _loc2_:Padding = this.formBgPadding;
            _loc2_.bottom = this._useBottomBtns?this.BG_FORM_DEF_PADDING.bottom + this.BTN_PADDING_Y:this.BG_FORM_DEF_PADDING.bottom;
            this.formBgPadding = _loc2_;
            invalidate("padding");
        }
        
        public function get useTabs() : Boolean
        {
            return this._useTabs;
        }
        
        public function set useTabs(param1:Boolean) : void
        {
            if(this._useTabs == param1)
            {
                return;
            }
            this._useTabs = param1;
            var _loc2_:Padding = this.formBgPadding;
            _loc2_.top = this._useTabs?this.BG_FORM_DEF_PADDING.top + this.TAB_PADDING_Y:this.BG_FORM_DEF_PADDING.top;
            this.formBgPadding = _loc2_;
            invalidate("padding");
        }
        
        public function get showBgForm() : Boolean
        {
            return this._showBgForm;
        }
        
        public function set showBgForm(param1:Boolean) : void
        {
            if(param1 == this.showBgForm)
            {
                return;
            }
            this._showBgForm = param1;
            _contentPadding = this._showBgForm?this.CONTENT_DEF_PADDING:_contentPadding;
            invalidate("padding");
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            if(closeBtn != null)
            {
                closeBtn.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
                closeBtn.addEventListener(ButtonEvent.CLICK,this.closeButtonClickHandler,false,0,true);
                constraints.addElement("closeBtn",closeBtn,Constraints.TOP | Constraints.RIGHT);
            }
            if(this.bgForm)
            {
                constraints.addElement("bgForm",this.bgForm,Constraints.ALL);
                this.bgForm.mouseEnabled = false;
                this.bgForm.mouseChildren = false;
                this.bgForm.tabEnabled = false;
                this.bgForm.tabChildren = false;
            }
            if(this.minimizeBtn)
            {
                constraints.addElement("minimizeBtn",this.minimizeBtn,Constraints.TOP | Constraints.RIGHT);
                this.minimizeBtn.addEventListener(ButtonEvent.CLICK,this.onMinimizeButtonClick);
            }
            if(hit)
            {
                hitArea = hit;
            }
            if(background)
            {
                background.mouseEnabled = false;
                background.mouseChildren = false;
                background.tabEnabled = false;
                background.tabChildren = false;
            }
            if(titleBtn)
            {
                titleBtn.removeEventListener(MouseEvent.MOUSE_DOWN,onWindowStartDrag);
            }
        }
        
        override protected function draw() : void
        {
            if((isInvalid(INVALID_SRC_VIEW)) && (this.windowContent))
            {
                this.updateSource();
                this.showBgForm = this.windowContent.showWindowBgForm;
                background.visible = this.windowContent.showWindowBg;
                this.minimizeBtn.visible = this.windowContent.canMinimize;
                resizeBtn.visible = this.windowContent.canResize;
                closeBtn.visible = this.windowContent.canClose;
                closeBtn.enabled = this.windowContent.enabledCloseBtn;
                if((this.windowContent.canDrag) && !this.draggingRegistered)
                {
                    try
                    {
                        App.cursor.registerDragging(this);
                        this.draggingRegistered = true;
                    }
                    catch(e:Error)
                    {
                    }
                }
                if(this.windowContent.isSourceTracked)
                {
                    this.windowContent.onSourceLoadedS();
                }
            }
            if(isInvalid("padding",INVALID_SRC_VIEW))
            {
                this.reflowContent();
            }
            if(!this.isDisposing && (isInvalid(InvalidationType.SIZE)))
            {
                constraints.update(_width,_height);
            }
            if(isInvalid(INVALID_TITLE))
            {
                titleBtn.label = _title || "";
                if(this.iconMovie.currentFrame > 1 || !(currentLabel == null))
                {
                    titleBtn.x = this.iconMovie.x + this.iconMovie.width;
                    titleBtn.width = titleBtn.width - this.iconMovie.width;
                }
            }
        }
        
        override protected function reflowContent() : void
        {
            var _loc1_:Padding = null;
            var _loc2_:ConstrainedElement = null;
            this.bgForm.visible = this._showBgForm;
            if((this.showBgForm) && (this.bgForm))
            {
                _loc1_ = this.formBgPadding;
                _loc2_ = constraints.getElement("bgForm");
                this.bgForm.x = _loc2_.left = _loc1_.left;
                this.bgForm.y = _loc2_.top = _loc1_.top;
                _loc2_.right = _loc1_.right;
                _loc2_.bottom = _loc1_.bottom;
                this.bgForm.width = _width - _loc1_.horizontal;
                this.bgForm.height = _height - _loc1_.vertical;
            }
            super.reflowContent();
        }
        
        protected function updateSource() : void
        {
            if(this.windowContent != null)
            {
                minWidth = _content.width + contentPadding.horizontal;
                minHeight = _content.height + contentPadding.vertical;
                this.windowContent.geometry.setSize(this);
                constraints.addElement("content",_content,Constraints.ALL);
            }
        }
        
        override protected function onCloseButtonClick(param1:MouseEvent) : void
        {
            if(this.windowContent)
            {
                this.windowContent.handleWindowClose();
            }
        }
        
        protected function closeButtonClickHandler(param1:ButtonEvent) : void
        {
            this.onCloseButtonClick(null);
        }
        
        protected function onMinimizeButtonClick(param1:ButtonEvent) : void
        {
            if((this.windowContent) && (this.windowContent.canMinimize))
            {
                this.windowContent.handleWindowMinimize();
            }
        }
    }
}
