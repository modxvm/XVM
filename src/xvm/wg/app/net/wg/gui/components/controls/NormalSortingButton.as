package net.wg.gui.components.controls
{
    import net.wg.gui.components.advanced.ScalableIconButton;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.data.constants.SortingInfo;
    import net.wg.gui.events.SortingEvent;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ComponentEvent;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.gui.components.advanced.SortingButtonInfo;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import scaleform.gfx.TextFieldEx;
    
    public class NormalSortingButton extends ScalableIconButton
    {
        
        public function NormalSortingButton()
        {
            super();
        }
        
        private static var SORT_DIRECTION_INVALID:String = "checkSortDirection";
        
        private static var SEPARATOR_PADDING:int = 3;
        
        private static var TEXT_PADDING:int = 13;
        
        private static var DESIGN_PADDING:int = 12;
        
        private static var PIXEL_PADDING:int = 1;
        
        private static var SEPARATOR:String = "separator";
        
        private static var EMPTY:String = "empty";
        
        public var labelField:TextField;
        
        public var defaultSortDirection:String = "none";
        
        public var bg:MovieClip;
        
        public var upperBg:MovieClip;
        
        public var sortingArrow:MovieClip;
        
        public var overBg:MovieClip;
        
        public var pressBg:MovieClip;
        
        public var arrowBg:MovieClip;
        
        private var _sortDirection:String;
        
        private var _textAlign:String = "center";
        
        private var _id:String;
        
        private var _showSeparator:Boolean = true;
        
        private var _showDisabledState:Boolean = false;
        
        private var _previousSelectedSorDirection:String;
        
        override public function set data(param1:Object) : void
        {
            super.data = param1;
            this.checkSortingBtnInfo(param1);
            invalidateData();
        }
        
        override public function set toggle(param1:Boolean) : void
        {
        }
        
        override public function set selected(param1:Boolean) : void
        {
            if(selected != param1)
            {
                if(param1 == false)
                {
                    this.sortDirection = SortingInfo.WITHOUT_SORT;
                }
                else if(!(this._previousSelectedSorDirection == SortingInfo.ASCENDING_SORT) && !(this._previousSelectedSorDirection == SortingInfo.DESCENDING_SORT))
                {
                    this.sortDirection = this.defaultSortDirection == SortingInfo.WITHOUT_SORT?SortingInfo.ASCENDING_SORT:this.defaultSortDirection;
                }
                else
                {
                    this.sortDirection = this.defaultSortDirection == SortingInfo.WITHOUT_SORT?this._previousSelectedSorDirection:this.defaultSortDirection;
                }
                
            }
            super.selected = param1;
        }
        
        public function get sortDirection() : String
        {
            return this._sortDirection;
        }
        
        public function set sortDirection(param1:String) : void
        {
            if(!(this._sortDirection == param1) && (selected))
            {
                this._previousSelectedSorDirection = this._sortDirection;
            }
            if(!(param1 == SortingInfo.ASCENDING_SORT) && !(param1 == SortingInfo.DESCENDING_SORT) && !(param1 == SortingInfo.WITHOUT_SORT))
            {
                param1 = SortingInfo.WITHOUT_SORT;
            }
            if(this._sortDirection != param1)
            {
                this._sortDirection = param1;
                dispatchEvent(new SortingEvent(SortingEvent.SORT_DIRECTION_CHANGED,true));
                invalidate(SORT_DIRECTION_INVALID);
            }
        }
        
        public function get id() : String
        {
            return this._id;
        }
        
        public function set id(param1:String) : void
        {
            this._id = param1;
        }
        
        override protected function onDispose() : void
        {
            this.bg = null;
            this.upperBg = null;
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabledOnDisabled = true;
            this.sortingArrow.visible = false;
            this.tabEnabled = false;
            _toggle = true;
            allowDeselect = false;
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = 0;
            if(isInvalid(InvalidationType.STATE))
            {
                if(_newFrame)
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
                if(_baseDisposed)
                {
                    return;
                }
                if((focusIndicator) && (_newFocusIndicatorFrame))
                {
                    focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                    _newFocusIndicatorFrame = null;
                }
                updateAfterStateChange();
                dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
                invalidate(InvalidationType.DATA,InvalidationType.SIZE);
            }
            if(isIconSourceChanged)
            {
                isIconSourceChanged = false;
                loader.source = iconSource;
                invalidate(InvalidationType.SIZE);
            }
            if((this.labelField && isInvalid(InvalidationType.DATA)) && (!(label == null)) && !(label == ""))
            {
                if(!iconSource && label.length > 0)
                {
                    this.labelField.visible = true;
                    this.labelField.htmlText = data.label;
                    this.updateTextSize(true);
                }
                else
                {
                    this.labelField.visible = false;
                }
            }
            if(isInvalid(SORT_DIRECTION_INVALID))
            {
                this.applySortDirection();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                hitMc.width = _width;
                hitMc.height = _height;
                this.bg.gotoAndStop(this._showSeparator?SEPARATOR:EMPTY);
                this.bg.width = _width;
                this.bg.height = _height;
                if(this.pressBg)
                {
                    this.pressBg.gotoAndStop(this._showSeparator?SEPARATOR:EMPTY);
                    this.pressBg.width = _width - PIXEL_PADDING;
                    this.pressBg.height = _height;
                }
                if(this.overBg)
                {
                    this.overBg.y = _height;
                    this.overBg.width = _width - PIXEL_PADDING;
                }
                _loc1_ = this._showSeparator?SEPARATOR_PADDING:0;
                this.sortingArrow.x = Math.round((_width - _loc1_) / 2);
                this.arrowBg.y = this.sortingArrow.y = Math.round(_height);
                this.arrowBg.width = _width - _loc1_;
                loader.x = Math.round((_width - loader.width - _loc1_) / 2);
                loader.y = Math.round((_height - loader.height) / 2);
                this.updateTextSize(true);
            }
            this.updateDisable();
        }
        
        override protected function updateDisable() : void
        {
            if(disableMc != null)
            {
                disableMc.visible = !enabled && (this._showDisabledState);
                disableMc.x = disabledFillPadding.left;
                disableMc.y = disabledFillPadding.top;
                disableMc.width = _width;
                disableMc.height = _height;
                disableMc.widthFill = _width - disabledFillPadding.horizontal;
                disableMc.heightFill = _height - disabledFillPadding.vertical;
            }
        }
        
        override protected function handleClick(param1:uint = 0) : void
        {
            if(selected)
            {
                if(this.sortDirection == SortingInfo.ASCENDING_SORT)
                {
                    this.sortDirection = SortingInfo.DESCENDING_SORT;
                }
                else if(this.sortDirection == SortingInfo.DESCENDING_SORT)
                {
                    this.sortDirection = SortingInfo.ASCENDING_SORT;
                }
                
            }
            else
            {
                super.handleClick(param1);
            }
        }
        
        protected function applySortDirection() : void
        {
            if(this._sortDirection == SortingInfo.ASCENDING_SORT)
            {
                this.sortingArrow.gotoAndStop(SortingInfo.ASCENDING_SORT);
                this.arrowBg.visible = this.sortingArrow.visible = true;
            }
            else if(this._sortDirection == SortingInfo.DESCENDING_SORT)
            {
                this.sortingArrow.gotoAndStop(SortingInfo.DESCENDING_SORT);
                this.arrowBg.visible = this.sortingArrow.visible = true;
            }
            else
            {
                this.arrowBg.visible = this.sortingArrow.visible = false;
            }
            
        }
        
        override protected function iconLoadingCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidateSize();
        }
        
        private function checkSortingBtnInfo(param1:Object) : void
        {
            var _loc2_:NormalSortingBtnInfo = null;
            if(param1 is SortingButtonInfo)
            {
                _loc2_ = NormalSortingBtnInfo(param1);
                if(!isNaN(_loc2_.buttonWidth))
                {
                    width = _loc2_.buttonWidth;
                }
                if(!isNaN(_loc2_.buttonHeight))
                {
                    height = _loc2_.buttonHeight;
                }
                if(_loc2_.defaultSortDirection)
                {
                    this.defaultSortDirection = _loc2_.defaultSortDirection;
                }
                if(_loc2_.toolTip)
                {
                    tooltip = _loc2_.toolTip;
                }
                enabled = _loc2_.enabled;
                this._id = _loc2_.iconId;
                this._showSeparator = _loc2_.showSeparator;
                this._showDisabledState = _loc2_.showDisabledState;
                this._textAlign = _loc2_.textAlign;
                iconSource = _loc2_.iconSource;
            }
        }
        
        private function updateTextSize(param1:Boolean = false) : void
        {
            var _loc2_:TextFormat = null;
            if((this.labelField) && (this.labelField.visible))
            {
                this.labelField.x = 0;
                this.labelField.width = _width - SEPARATOR_PADDING;
                this.labelField.height = _height - DESIGN_PADDING;
            }
            if(param1)
            {
                _loc2_ = this.labelField.getTextFormat();
                _loc2_.align = this._textAlign;
                if(this._textAlign == TextFieldAutoSize.RIGHT)
                {
                    _loc2_.rightMargin = TEXT_PADDING;
                }
                else if(this._textAlign == TextFieldAutoSize.LEFT)
                {
                    _loc2_.leftMargin = TEXT_PADDING;
                }
                
                this.labelField.setTextFormat(_loc2_);
                TextFieldEx.setVerticalAlign(this.labelField,TextFieldEx.VAUTOSIZE_BOTTOM);
            }
        }
    }
}
