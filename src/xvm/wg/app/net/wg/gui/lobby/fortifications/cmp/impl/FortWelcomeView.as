package net.wg.gui.lobby.fortifications.cmp.impl
{
    import net.wg.infrastructure.base.meta.impl.FortWelcomeViewMeta;
    import net.wg.gui.lobby.fortifications.cmp.IFortWelcomeView;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import net.wg.gui.lobby.profile.components.SimpleLoader;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.fortifications.data.FortWelcomeViewVO;
    import flash.utils.Dictionary;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.NullPointerException;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.data.constants.Values;
    import scaleform.clik.events.ButtonEvent;
    import flash.text.TextFieldAutoSize;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.TextEvent;
    import flash.geom.Point;
    import flash.events.Event;
    import net.wg.gui.lobby.fortifications.data.FortConstants;
    
    public class FortWelcomeView extends FortWelcomeViewMeta implements IFortWelcomeView
    {
        
        public function FortWelcomeView()
        {
            super();
        }
        
        private static var PROMO_START_WIDTH:Number = 1920;
        
        private static var PROMO_START_HEIGHT:Number = 1080;
        
        private static var RIGHT_ALIGN_FACTOR:Number = 2 / 3;
        
        private static var MIN_APP_HGHT_FOR_TEXT_V_ALIGN:uint = 768;
        
        private static var V_ALIGN_THRESHOLD:uint = 3;
        
        private static var TEXT_V_ALIGN_START_POSITION_Y:uint = 130;
        
        private static var WARNING_OFFSET_Y:uint = 8;
        
        private static var REQUIREMENT_TEXT_OFFSET_Y:int = 17;
        
        private static var MIN_ASPECT_RATIO:Number = 0.64;
        
        private static var CREATE_CLAN_OFFSET_Y:int = 174;
        
        private static var MIN_NORMAL_WIDTH:int = 1920;
        
        private static var CREATE_BTN_OFFSET_Y:int = 30;
        
        private static function onLinkTextfieldMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var createFortBtn:SoundButtonEx = null;
        
        public var titleTextField:TextField = null;
        
        public var buildingAndUpgradeTitleTextField:TextField = null;
        
        public var buildingAndUpgradeBodyTextField:TextField = null;
        
        public var bonusesTitleTextField:TextField = null;
        
        public var bonusesBodyTextField:TextField = null;
        
        public var warForResourcesTitleTextField:TextField = null;
        
        public var warForResourcesBodyTextField:TextField = null;
        
        public var detail:TextField = null;
        
        public var promoMC:SimpleLoader = null;
        
        public var blackBg:MovieClip = null;
        
        public var warningText:TextField = null;
        
        public var requirementText:TextField = null;
        
        public var searchClanText:TextField = null;
        
        public var createClanText:TextField = null;
        
        private var rightAlignedControls:Vector.<DisplayObject> = null;
        
        private var _data:FortWelcomeViewVO = null;
        
        private var _linkTooltips:Dictionary = null;
        
        private var _disabledBtnTooltip:String = null;
        
        public function update(param1:Object) : void
        {
            if(param1)
            {
            }
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this.createFortBtn;
        }
        
        public function as_setWarningText(param1:String, param2:String, param3:String) : void
        {
            App.utils.asserter.assertNotNull(param1,"text" + Errors.CANT_NULL,NullPointerException);
            this.warningText.htmlText = param1;
            this._disabledBtnTooltip = new ComplexTooltipHelper().addHeader(param2).addBody(param3).addNote(Values.EMPTY_STR,false).make();
            invalidateData();
        }
        
        public function as_setRequirementText(param1:String) : void
        {
            App.utils.asserter.assertNotNull(param1,"text" + Errors.CANT_NULL,NullPointerException);
            this.requirementText.htmlText = param1;
        }
        
        public function as_setHyperLinks(param1:String, param2:String, param3:String) : void
        {
            this.searchClanText.htmlText = param1;
            this.createClanText.htmlText = param2;
            this.detail.htmlText = param3;
        }
        
        public function canShowAutomatically() : Boolean
        {
            return false;
        }
        
        override protected function setCommonData(param1:FortWelcomeViewVO) : void
        {
            this._data = param1;
            invalidateData();
            validateNow();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.promoMC.setSource(RES_FORT.MAPS_FORT_WELCOMESCREEN);
            this.promoMC.visible = false;
            this.promoMC.addEventListener(SimpleLoader.LOADED,this.onPromoMCLoaded);
            this.rightAlignedControls = Vector.<DisplayObject>([this.buildingAndUpgradeTitleTextField,this.buildingAndUpgradeBodyTextField,this.bonusesTitleTextField,this.bonusesBodyTextField,this.warForResourcesTitleTextField,this.warForResourcesBodyTextField,this.detail,this.requirementText,this.searchClanText]);
            this.createFortBtn.addEventListener(ButtonEvent.CLICK,this.onCreateFortBtnClickHandler);
            this.detail.autoSize = this.searchClanText.autoSize = this.createClanText.autoSize = TextFieldAutoSize.LEFT;
            this.createLinks();
            this.initTexts();
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
        }
        
        override protected function draw() : void
        {
            super.draw();
            this.updateControlPositions();
            if((isInvalid(InvalidationType.DATA)) && (this._data))
            {
                this.createFortBtn.visible = this._data.canRoleCreateFortRest;
                this.createFortBtn.enabled = this._data.canCreateFort();
                if(this._data.canCreateFort())
                {
                    this.createFortBtn.tooltip = TOOLTIPS.FORTIFICATION_WELCOME_CREATEFORT;
                }
                else
                {
                    this.createFortBtn.tooltip = this._disabledBtnTooltip;
                }
                this.searchClanText.visible = this.createClanText.visible = !this._data.isOnClan;
                this.requirementText.visible = !this._data.canRoleCreateFortRest;
                this.warningText.visible = !this.createFortBtn.enabled && this.warningText.text.length > 2;
            }
        }
        
        override protected function onDispose() : void
        {
            this.disposeLinks();
            this.promoMC.removeEventListener(SimpleLoader.LOADED,this.onPromoMCLoaded);
            this.createFortBtn.removeEventListener(ButtonEvent.CLICK,this.onCreateFortBtnClickHandler);
            this.createFortBtn.dispose();
            this.createFortBtn = null;
            this.titleTextField = null;
            this.buildingAndUpgradeTitleTextField = null;
            this.buildingAndUpgradeBodyTextField = null;
            this.bonusesTitleTextField = null;
            this.bonusesBodyTextField = null;
            this.warForResourcesTitleTextField = null;
            this.warForResourcesBodyTextField = null;
            this.detail = null;
            this.rightAlignedControls.splice(0,this.rightAlignedControls.length);
            this.rightAlignedControls = null;
            this.requirementText = null;
            this.searchClanText = null;
            this.createClanText = null;
            this.promoMC.dispose();
            this.promoMC = null;
            this.blackBg = null;
            this._data = null;
            super.onDispose();
        }
        
        private function createLinks() : void
        {
            var _loc1_:Object = null;
            var _loc2_:TextField = null;
            this._linkTooltips = new Dictionary(true);
            this._linkTooltips[this.detail] = TOOLTIPS.FORTIFICATION_WELCOME_DETAILS;
            this._linkTooltips[this.searchClanText] = TOOLTIPS.FORTIFICATION_WELCOME_CLANSEARCH;
            this._linkTooltips[this.createClanText] = TOOLTIPS.FORTIFICATION_WELCOME_CLANCREATE;
            for(_loc1_ in this._linkTooltips)
            {
                _loc2_ = TextField(_loc1_);
                _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onLinkTextfieldMouseOverHandler);
                _loc2_.addEventListener(MouseEvent.MOUSE_OUT,onLinkTextfieldMouseOutHandler);
                _loc2_.addEventListener(TextEvent.LINK,this.onLinkNavigationHandler);
                App.utils.styleSheetManager.setLinkStyle(_loc2_);
            }
        }
        
        private function disposeLinks() : void
        {
            var _loc2_:Object = null;
            var _loc3_:TextField = null;
            var _loc1_:Array = [];
            for(_loc2_ in this._linkTooltips)
            {
                _loc3_ = TextField(_loc2_);
                _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,this.onLinkTextfieldMouseOverHandler);
                _loc3_.removeEventListener(MouseEvent.MOUSE_OUT,onLinkTextfieldMouseOutHandler);
                _loc3_.removeEventListener(TextEvent.LINK,this.onLinkNavigationHandler);
                _loc3_.styleSheet = null;
                _loc1_.push(_loc2_);
            }
            for each(_loc2_ in _loc1_)
            {
                delete this._linkTooltips[_loc2_];
                true;
            }
            this._linkTooltips = null;
        }
        
        private function initTexts() : void
        {
            this.createFortBtn.label = FORTIFICATIONS.FORTWELCOMEVIEW_CREATEFORTBTN;
            this.titleTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_TITLE;
            this.buildingAndUpgradeTitleTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_BUILDINGANDUPGRADING_TITLE;
            this.buildingAndUpgradeBodyTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_BUILDINGANDUPGRADING_BODY;
            this.bonusesTitleTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_BONUSES_TITLE;
            this.bonusesBodyTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_BONUSES_BODY;
            this.warForResourcesTitleTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_WARFORRESOURCES_TITLE;
            this.warForResourcesBodyTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_WARFORRESOURCES_BODY;
            this.updateControlPositions();
        }
        
        private function updateControlPositions() : void
        {
            var _loc1_:DisplayObject = null;
            var _loc2_:uint = Math.round(App.appWidth * RIGHT_ALIGN_FACTOR);
            var _loc3_:uint = TEXT_V_ALIGN_START_POSITION_Y;
            for each(_loc1_ in this.rightAlignedControls)
            {
                _loc1_.x = _loc2_;
                _loc1_.y = _loc3_ + Math.round((App.appHeight - MIN_APP_HGHT_FOR_TEXT_V_ALIGN) / V_ALIGN_THRESHOLD);
                _loc3_ = _loc3_ + _loc1_.height;
            }
            this.createFortBtn.x = _loc1_.x;
            this.requirementText.y = this.detail.y + this.detail.height + REQUIREMENT_TEXT_OFFSET_Y;
            this.createFortBtn.y = this.detail.y + this.detail.height + CREATE_BTN_OFFSET_Y;
            this.createClanText.x = this.searchClanText.x + CREATE_CLAN_OFFSET_Y;
            this.createClanText.y = this.searchClanText.y;
            this.warningText.x = this.searchClanText.x;
            this.warningText.y = this.createFortBtn.y + this.createFortBtn.height + WARNING_OFFSET_Y;
            this.searchClanText.y = this.createClanText.y = this.requirementText.y + this.requirementText.height;
            var _loc4_:Number = Math.min(MIN_NORMAL_WIDTH,App.appWidth) / MIN_NORMAL_WIDTH;
            _loc4_ = Math.max(MIN_ASPECT_RATIO,_loc4_);
            this.promoMC.width = PROMO_START_WIDTH * _loc4_;
            this.promoMC.height = PROMO_START_HEIGHT * _loc4_;
            this.promoMC.x = App.appWidth - this.promoMC.width >> 1;
            this.blackBg.width = this.titleTextField.width = App.appWidth + 1;
            this.blackBg.height = App.appHeight - globalToLocal(new Point(x,y)).y + 1;
        }
        
        private function onLinkTextfieldMouseOverHandler(param1:MouseEvent) : void
        {
            App.utils.asserter.assert(!(this._linkTooltips[param1.target] == undefined),"unknown target for _linkTooltips: " + param1.target);
            App.toolTipMgr.showComplex(this._linkTooltips[param1.target]);
        }
        
        private function onLinkNavigationHandler(param1:TextEvent) : void
        {
            onNavigateS(param1.text);
        }
        
        private function onCreateFortBtnClickHandler(param1:ButtonEvent) : void
        {
            param1.stopImmediatePropagation();
            dispatchEvent(new Event(FortConstants.ON_FORT_CREATE_EVENT,true));
        }
        
        private function onPromoMCLoaded(param1:Event) : void
        {
            this.promoMC.removeEventListener(SimpleLoader.LOADED,this.onPromoMCLoaded);
            this.promoMC.visible = true;
            this.show();
        }
        
        private function show() : void
        {
            onViewReadyS();
            this.visible = true;
        }
    }
}
