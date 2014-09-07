package net.wg.gui.lobby.header.headerButtonBar
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import net.wg.infrastructure.interfaces.IClosePopoverCallback;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.header.vo.HeaderButtonVo;
    import net.wg.gui.interfaces.IHeaderButtonContentItem;
    import scaleform.clik.utils.Padding;
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.header.events.HeaderEvents;
    import flash.text.TextFieldAutoSize;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
    import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
    import net.wg.data.constants.Tooltips;
    
    public class HeaderButton extends SoundButtonEx implements IPopOverCaller, IClosePopoverCallback
    {
        
        public function HeaderButton()
        {
            super();
        }
        
        public var separator:Sprite;
        
        public var container:Sprite;
        
        public var states:MovieClip;
        
        public var bounds:Sprite;
        
        private var _dataVo:HeaderButtonVo = null;
        
        private var _content:IHeaderButtonContentItem = null;
        
        private var _screen:String = "";
        
        private var _wideScreenPrc:Number = 0;
        
        private var _maxScreenPrc:Number = 0;
        
        private var _isShowSeparator:Boolean = false;
        
        private var BTN_CONTENT_INVALID:String = "button_content_invalid";
        
        private var BTN_DATA_INVALID:String = "button_data_invalid";
        
        override protected function configUI() : void
        {
            constraintsDisabled = true;
            preventAutosizing = true;
            var _loc1_:Padding = disabledFillPadding;
            _loc1_.left = 2;
            super.configUI();
        }
        
        override protected function initialize() : void
        {
            super.initialize();
            _labelHash = UIComponent.generateLabelHash(this.states);
        }
        
        private function onContentUpdated(param1:HeaderEvents) : void
        {
            this._content.visible = true;
            this.visible = this._content.readyToShow;
            this._content.x = param1.leftPadding;
            hitMc.width = param1.contentWidth;
            this.states.width = param1.contentWidth;
            this.bounds.width = param1.contentWidth;
            this.updateDisable();
            this.separator.x = this._dataVo.direction == TextFieldAutoSize.LEFT?param1.contentWidth:0;
            dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED,this.bounds.width));
        }
        
        override protected function draw() : void
        {
            if(isInvalid(this.BTN_DATA_INVALID))
            {
                this.removeItems();
                this.addItem();
                invalidate(this.BTN_CONTENT_INVALID);
            }
            if(isInvalid(this.BTN_CONTENT_INVALID))
            {
                this.updateContentData();
            }
            super.draw();
        }
        
        public function updateContentData() : void
        {
            this.helpConnectorLength = this._dataVo.helpConnectorLength;
            this.helpDirection = this._dataVo.helpDirection;
            this.helpText = this._dataVo.helpText;
            this.enabled = this._dataVo.enabled;
            this._content.data = this._dataVo.data;
            this.updateScreen(this._screen,this._wideScreenPrc,this._maxScreenPrc);
        }
        
        private function addItem() : void
        {
            this._content = App.utils.classFactory.getObject(this._dataVo.linkage) as IHeaderButtonContentItem;
            this._content.visible = false;
            this._content.addEventListener(HeaderEvents.HBC_SIZE_UPDATED,this.onContentUpdated);
            this.container.addChild(DisplayObject(this._content));
        }
        
        private function removeItems() : void
        {
            var _loc1_:IHeaderButtonContentItem = null;
            while(this.container.numChildren > 0)
            {
                _loc1_ = IHeaderButtonContentItem(this.container.removeChildAt(0));
                _loc1_.removeEventListener(HeaderEvents.HBC_SIZE_UPDATED,this.onContentUpdated);
                if(_loc1_ is IDisposable)
                {
                    IDisposable(_loc1_).dispose();
                }
            }
        }
        
        override protected function onDispose() : void
        {
            this.removeItems();
            this._dataVo.dispose();
            this._dataVo = null;
            super.onDispose();
        }
        
        override public function gotoAndPlay(param1:Object, param2:String = null) : void
        {
            this.states.gotoAndPlay(param1);
        }
        
        override public function gotoAndStop(param1:Object, param2:String = null) : void
        {
            this.states.gotoAndStop(param1);
        }
        
        public function updateScreen(param1:String, param2:Number, param3:Number) : void
        {
            if(!(param1 == this._screen) || !(this._wideScreenPrc == param2) || !(this._maxScreenPrc == param3))
            {
                if(this._content)
                {
                    this._screen = param1;
                    this._wideScreenPrc = param2;
                    this._maxScreenPrc = param3;
                    this._content.updateScreen(this._screen,this._wideScreenPrc,this._maxScreenPrc);
                }
            }
        }
        
        override public function set data(param1:Object) : void
        {
            super.data = param1;
            var _loc2_:String = this.BTN_DATA_INVALID;
            if((this._dataVo) && !(this._dataVo.linkage == data.linkage))
            {
                _loc2_ = this.BTN_CONTENT_INVALID;
            }
            this._dataVo = HeaderButtonVo(data);
            this._dataVo.headerButton = this;
            this.tooltip = this._dataVo.tooltip;
            invalidate(_loc2_);
        }
        
        public function get headerButtonData() : HeaderButtonVo
        {
            return this._dataVo;
        }
        
        public function get isReadyToShow() : Boolean
        {
            return this._content?this._content.readyToShow:false;
        }
        
        override public function showTooltip(param1:MouseEvent) : void
        {
            if(this._dataVo)
            {
                if(this._dataVo.id == HeaderButtonsHelper.ITEM_ID_PREM)
                {
                    this.tooltip = HBC_PremDataVo(this._dataVo.data).isPrem?TOOLTIPS.HEADER_PREMIUM_EXTEND:TOOLTIPS.HEADER_PREMIUM_BUY;
                }
                else if(this._dataVo.id == HeaderButtonsHelper.ITEM_ID_SQUAD)
                {
                    this.tooltip = HBC_SquadDataVo(this._dataVo.data).isInSquad?TOOLTIPS.HEADER_SQUAD_MEMBER:TOOLTIPS.HEADER_SQUAD;
                }
                else if(this._dataVo.id == HeaderButtonsHelper.ITEM_ID_SETTINGS)
                {
                    App.toolTipMgr.showSpecial(Tooltips.SETTINGS_BUTTON,null);
                    return;
                }
                
                
            }
            super.showTooltip(param1);
        }
        
        override public function toString() : String
        {
            return "[WG HeaderButton " + name + "]";
        }
        
        public function getTargetButton() : DisplayObject
        {
            return hitMc;
        }
        
        public function getHitArea() : DisplayObject
        {
            return this;
        }
        
        public function onPopoverClose() : void
        {
        }
        
        public function onPopoverOpen() : void
        {
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            if(this._dataVo.id == HeaderButtonsHelper.ITEM_ID_SQUAD || this._dataVo.id == HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR)
            {
                this.alpha = param1?1:0.4;
            }
            super.enabled = param1;
        }
        
        override protected function updateDisable() : void
        {
            if(disableMc != null)
            {
                disableMc.x = disabledFillPadding.left;
                disableMc.y = disabledFillPadding.top;
                disableMc.scaleX = 1 / this.scaleX;
                disableMc.scaleY = 1 / this.scaleY;
                disableMc.widthFill = Math.round(this.bounds.width * this.scaleX) - disabledFillPadding.horizontal;
                disableMc.heightFill = Math.round(this.bounds.height * this.scaleY) - disabledFillPadding.vertical;
                disableMc.visible = !enabled && !(this._dataVo.id == HeaderButtonsHelper.ITEM_ID_SQUAD) && !(this._dataVo.id == HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR);
            }
        }
        
        override public function showHelpLayout() : void
        {
            var _loc1_:Object = null;
            if(helpText.length > 0)
            {
                _loc1_ = {"borderWidth":this.bounds.width - 1,
                "borderHeight":this.bounds.height - 2,
                "direction":helpDirection,
                "text":helpText,
                "x":1,
                "y":1,
                "connectorLength":helpConnectorLength
            };
            setHelpLayout(App.utils.helpLayout.create(this.root,_loc1_,this));
        }
    }
    
    public function get isShowSeparator() : Boolean
    {
        return this._isShowSeparator;
    }
    
    public function set isShowSeparator(param1:Boolean) : void
    {
        if(this._isShowSeparator == param1)
        {
            return;
        }
        this._isShowSeparator = param1;
        isInvalid(this.BTN_CONTENT_INVALID);
    }
    
    public function get content() : IHeaderButtonContentItem
    {
        return this._content;
    }
}
}
