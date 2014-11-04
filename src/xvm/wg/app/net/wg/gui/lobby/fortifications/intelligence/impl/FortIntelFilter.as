package net.wg.gui.lobby.fortifications.intelligence.impl
{
    import net.wg.infrastructure.base.meta.impl.FortIntelFilterMeta;
    import net.wg.gui.lobby.fortifications.intelligence.IFortIntelFilter;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconTextButton;
    import net.wg.gui.components.controls.TextInput;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObject;
    import scaleform.clik.events.InputEvent;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.events.FocusHandlerEvent;
    import net.wg.gui.lobby.fortifications.data.FortInterFilterVO;
    import scaleform.clik.data.DataProvider;
    import flash.events.IEventDispatcher;
    import scaleform.clik.events.ButtonEvent;
    import flash.text.TextFormat;
    import net.wg.gui.lobby.fortifications.intelligence.FortIntelligenceWindowHelper;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    
    public class FortIntelFilter extends FortIntelFilterMeta implements IFortIntelFilter
    {
        
        public function FortIntelFilter()
        {
            super();
        }
        
        private static var FILTER_ICON_PNG:String = "filter.png";
        
        private static var SEARCH_ICON_PNG:String = "search.png";
        
        private static var H5_STYLE_COLOR:int = 3618350;
        
        private static var H7_STYLE_COLOR:int = 9211006;
        
        private static var MAX_CLAN_ABBREVIATE_LEN_DEF:int = 7;
        
        private static var SEARCH_BRACKETS_TEXT_LENGTH:int = 2;
        
        private static var FORT_RESULT_TEXT_OFFSET_X:int = 7;
        
        private static var FORT_RESULT_TEXT_DEFAULT_X:int = 17;
        
        private static var FILTER_BUTTON_ICON_OFFSET_LEFT:int = 10;
        
        private static var FILTER_BUTTON_ICON_OFFSET_TOP:int = 1;
        
        private static function onMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var clanTypeDropDn:DropdownMenu = null;
        
        public var filterResultTextField:TextField = null;
        
        public var filterButtonStatusTextField:TextField = null;
        
        public var filterButtonStatusTextFieldWithEffect:TextField = null;
        
        public var tagSearchButton:IconTextButton = null;
        
        public var filterButton:IconTextButton = null;
        
        public var tagSearchTextInput:TextInput = null;
        
        public var clearFilterBtn:ISoundButtonEx = null;
        
        private var tooltips:Object = null;
        
        private var _isSearchTextMaxCharsSetted:Boolean = false;
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this.clanTypeDropDn;
        }
        
        public function getTargetButton() : DisplayObject
        {
            return this.filterButton;
        }
        
        public function getHitArea() : DisplayObject
        {
            return this.filterButton;
        }
        
        public function as_setMaxClanAbbreviateLength(param1:uint) : void
        {
            this.tagSearchTextInput.maxChars = param1 + SEARCH_BRACKETS_TEXT_LENGTH;
            this._isSearchTextMaxCharsSetted = true;
        }
        
        public function as_setClanAbbrev(param1:String) : void
        {
            this.clearTagSearchTextInput();
            this.tagSearchTextInput.text = param1;
            this.updateClearButtonVisibility();
        }
        
        public function as_setupCooldown(param1:Boolean) : void
        {
            this.filterButton.enabled = this.clearFilterBtn.enabled = this.tagSearchButton.enabled = !param1;
            this.clanTypeDropDn.enabled = this.tagSearchTextInput.enabled = !param1;
            if(param1)
            {
                this.tagSearchTextInput.removeEventListener(InputEvent.INPUT,this.handleInput,false);
            }
            else
            {
                this.tagSearchTextInput.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
            }
        }
        
        public function as_setFilterStatus(param1:String) : void
        {
            App.utils.asserter.assertNotNull(param1,"filterButtonStatus" + Errors.CANT_NULL);
            this.filterResultTextField.htmlText = param1;
        }
        
        public function as_setFilterButtonStatus(param1:String, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(param1,"filterButtonStatus" + Errors.CANT_NULL);
            this.filterButtonStatusTextFieldWithEffect.visible = param2;
            this.filterButtonStatusTextField.visible = !param2;
            this.filterButtonStatusTextField.htmlText = this.filterButtonStatusTextFieldWithEffect.htmlText = param1;
        }
        
        public function as_setSearchResult(param1:String) : void
        {
            this.tagSearchTextInput.highlight = !(param1 == null) && (this.tagSearchTextInput.text);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
            this.tooltips = {};
            this.tooltips[this.tagSearchTextInput] = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_TAGSEARCHTEXTINPUT;
            this.tooltips[this.tagSearchButton] = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_TAGSEARCHBUTTON;
            this.tooltips[this.clearFilterBtn] = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_CLEARFILTERBTN;
            this.tooltips[this.filterButton] = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_FILTERBUTTON;
            if(!this._isSearchTextMaxCharsSetted)
            {
                this.tagSearchTextInput.maxChars = MAX_CLAN_ABBREVIATE_LEN_DEF;
            }
            this.tagSearchTextInput.defaultTextFormat.italic = false;
            this.tagSearchTextInput.defaultTextFormat.color = H5_STYLE_COLOR;
            this.tagSearchTextInput.defaultText = FORTIFICATIONS.FORTINTELLIGENCE_TAGSEARCHTEXTINPUT_DEFAULT;
            this.tagSearchTextInput.validateNow();
            this.clearFilterBtn.label = FORTIFICATIONS.FORTINTELLIGENCE_CLEARFILTERBTN_TITLE;
            this.filterButton.iconOffsetLeft = FILTER_BUTTON_ICON_OFFSET_LEFT;
            this.filterButton.iconOffsetTop = FILTER_BUTTON_ICON_OFFSET_TOP;
            this.filterButton.icon = FILTER_ICON_PNG;
            this.tagSearchButton.icon = SEARCH_ICON_PNG;
            this.clearFilterBtn.visible = false;
            this.updateClearButtonVisibility();
            this.clanTypeDropDn.addEventListener(ListEvent.INDEX_CHANGE,this.onClanTypeDropDnIndexChangeHandler);
            this.tagSearchTextInput.addEventListener(FocusHandlerEvent.FOCUS_IN,this.onTagSearchTextInputFocusInHandler);
            this.addInteractionListeners(this.tagSearchTextInput,false);
            this.addInteractionListeners(this.clearFilterBtn,true);
            this.addInteractionListeners(this.tagSearchButton,true);
            this.addInteractionListeners(this.filterButton,true);
            this.tagSearchTextInput.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
        }
        
        override protected function setData(param1:FortInterFilterVO) : void
        {
            this.clanTypeDropDn.dataProvider = new DataProvider(param1.clanTypes);
            this.clanTypeDropDn.removeEventListener(ListEvent.INDEX_CHANGE,this.onClanTypeDropDnIndexChangeHandler);
            this.clanTypeDropDn.selectedIndex = param1.selectedFilterType;
            this.clanTypeDropDn.addEventListener(ListEvent.INDEX_CHANGE,this.onClanTypeDropDnIndexChangeHandler);
            this.updateControlsVisibility(param1.selectedFilterType);
            param1.dispose();
        }
        
        override protected function onDispose() : void
        {
            this.tagSearchTextInput.removeEventListener(InputEvent.INPUT,this.handleInput,false);
            this.tagSearchTextInput.removeEventListener(FocusHandlerEvent.FOCUS_IN,this.onTagSearchTextInputFocusInHandler);
            this.removeInteractionListeners(this.tagSearchTextInput);
            this.removeInteractionListeners(this.clearFilterBtn);
            this.removeInteractionListeners(this.tagSearchButton);
            this.removeInteractionListeners(this.filterButton);
            App.utils.commons.cleanupDynamicObject(this.tooltips);
            this.tooltips = null;
            this.clearFilterBtn.dispose();
            this.clearFilterBtn = null;
            this.clanTypeDropDn.dispose();
            this.clanTypeDropDn = null;
            this.tagSearchButton.dispose();
            this.tagSearchButton = null;
            this.tagSearchTextInput.dispose();
            this.tagSearchTextInput = null;
            this.filterButton.dispose();
            this.filterButton = null;
            this.filterResultTextField = null;
            this.filterButtonStatusTextField = null;
            super.onDispose();
        }
        
        private function addInteractionListeners(param1:IEventDispatcher, param2:Boolean) : void
        {
            if(param2)
            {
                param1.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
            }
            param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            param1.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
        }
        
        private function removeInteractionListeners(param1:IEventDispatcher) : void
        {
            param1.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
            param1.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            param1.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
        }
        
        private function getClanTagWithoutBrackets() : String
        {
            var _loc1_:String = this.tagSearchTextInput.text;
            if(_loc1_.charAt(0) == "[")
            {
                _loc1_ = _loc1_.substr(1);
            }
            if(_loc1_.length > 1 && _loc1_.charAt(_loc1_.length - 1) == "]")
            {
                _loc1_ = _loc1_.substr(0,_loc1_.length - 1);
            }
            return App.utils.toUpperOrLowerCase(_loc1_,true);
        }
        
        private function updateClearButtonVisibility() : void
        {
            this.clearFilterBtn.visible = this.clanTypeDropDn.selectedIndex == 0 && !this.isTagSearchEmptyNow();
            if(this.clearFilterBtn.visible)
            {
                this.filterResultTextField.x = this.clearFilterBtn.x + this.clearFilterBtn.width + FORT_RESULT_TEXT_OFFSET_X;
            }
            else
            {
                this.filterResultTextField.x = FORT_RESULT_TEXT_DEFAULT_X;
            }
        }
        
        private function isTagSearchEmptyNow() : Boolean
        {
            return this.tagSearchTextInput.text.length == 0;
        }
        
        private function applyFilter() : void
        {
            var _loc1_:* = "selected index in clanTypeDropDn can not be equals -1";
            App.utils.asserter.assert(!(this.clanTypeDropDn.selectedIndex == -1),_loc1_);
            onTryToSearchByClanAbbrS(this.getClanTagWithoutBrackets(),this.clanTypeDropDn.selectedIndex);
            this.updateClearButtonVisibility();
        }
        
        private function tryToApplyFilter() : void
        {
            if(!this.isTagSearchEmptyNow())
            {
                this.applyFilter();
            }
        }
        
        private function clearTagSearchTextInput() : void
        {
            this.tagSearchTextInput.highlight = false;
            this.tagSearchTextInput.text = "";
            var _loc1_:TextField = this.tagSearchTextInput.textField;
            var _loc2_:TextFormat = _loc1_.getTextFormat();
            _loc2_.color = H7_STYLE_COLOR;
            _loc1_.setTextFormat(_loc2_);
            this.tagSearchTextInput.validateNow();
        }
        
        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = this.tooltips[param1.currentTarget];
            FortIntelligenceWindowHelper.getInstance().assertHandlerTarget(!(_loc2_ == null),param1.currentTarget);
            App.toolTipMgr.showComplex(_loc2_);
        }
        
        private function onTagSearchTextInputFocusInHandler(param1:FocusHandlerEvent) : void
        {
            if(this.isTagSearchEmptyNow())
            {
                this.clearTagSearchTextInput();
            }
        }
        
        private function onButtonClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:String = null;
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                switch(param1.currentTarget)
                {
                    case this.filterButton:
                        App.popoverMgr.show(this,FORTIFICATION_ALIASES.FORT_INTELLIGENCE_CLAN_FILTER_POPOVER_ALIAS);
                        break;
                    case this.clearFilterBtn:
                        this.clearTagSearchTextInput();
                        this.updateClearButtonVisibility();
                        if(this.clanTypeDropDn.selectedIndex != FORTIFICATION_ALIASES.CLAN_TYPE_FILTER_STATE_ALL)
                        {
                            _loc2_ = "clearFilterBtn need to ListEvent.INDEX_CHANGE handling!";
                            App.utils.asserter.assert(this.clanTypeDropDn.hasEventListener(ListEvent.INDEX_CHANGE),_loc2_);
                            this.clanTypeDropDn.selectedIndex = FORTIFICATION_ALIASES.CLAN_TYPE_FILTER_STATE_ALL;
                        }
                        else
                        {
                            this.applyFilter();
                        }
                        break;
                    case this.tagSearchButton:
                        this.tryToApplyFilter();
                        break;
                    default:
                        FortIntelligenceWindowHelper.getInstance().assertHandlerTarget(false,param1.currentTarget);
                }
            }
        }
        
        private function onClanTypeDropDnIndexChangeHandler(param1:ListEvent) : void
        {
            this.updateControlsVisibility(param1.index);
            this.applyFilter();
        }
        
        private function updateControlsVisibility(param1:int) : void
        {
            var _loc2_:* = false;
            _loc2_ = param1 == FORTIFICATION_ALIASES.CLAN_TYPE_FILTER_STATE_ALL;
            this.tagSearchTextInput.visible = this.filterButton.visible = this.tagSearchButton.visible = _loc2_;
            this.filterButtonStatusTextFieldWithEffect.alpha = this.filterButtonStatusTextField.alpha = _loc2_?1:0;
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            super.handleInput(param1);
            if(param1.details.code == Keyboard.ENTER && param1.details.value == InputValue.KEY_DOWN)
            {
                this.tryToApplyFilter();
                param1.handled = true;
            }
        }
    }
}
