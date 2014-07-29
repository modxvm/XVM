package net.wg.gui.lobby.fortifications.cmp.impl
{
    import net.wg.infrastructure.base.meta.impl.FortMainViewMeta;
    import net.wg.gui.lobby.fortifications.cmp.IFortMainView;
    import flash.events.MouseEvent;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import flash.display.Sprite;
    import net.wg.gui.lobby.fortifications.utils.IFortsControlsAligner;
    import net.wg.gui.lobby.fortifications.utils.IFortModeSwitcher;
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuildingCmp;
    import net.wg.gui.lobby.fortifications.cmp.main.IMainHeader;
    import net.wg.gui.lobby.fortifications.cmp.main.IMainFooter;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.infrastructure.events.LibraryLoaderEvent;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.lobby.fortifications.events.DirectionEvent;
    import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
    import scaleform.clik.events.InputEvent;
    import net.wg.gui.lobby.fortifications.data.FortificationVO;
    import net.wg.gui.lobby.fortifications.data.FortModeStateVO;
    import flash.geom.Point;
    import net.wg.gui.lobby.fortifications.utils.impl.FortsControlsAligner;
    import scaleform.clik.ui.InputDetails;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    
    public class FortMainView extends FortMainViewMeta implements IFortMainView
    {
        
        public function FortMainView()
        {
            this.stateMethods = {};
            super();
            this.helper = FortsControlsAligner.instance;
            addEventListener(DirectionEvent.OPEN_DIRECTION,this.openDirHandler,false,0,true);
            addEventListener(FortBuildingEvent.FIRST_TRANSPORTING_STEP,this.firstTransportingStepHandler);
            addEventListener(FortBuildingEvent.NEXT_TRANSPORTING_STEP,this.nextTransportingStepHandler);
            removeChild(this.fortWelcomeCommanderViewImporter);
            this.fortWelcomeCommanderViewImporter = null;
            this.visible = false;
        }
        
        private static var CHAT_HEIGHT:Number = 33;
        
        private static function onTransportButtonMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var landscapeMask:IUIComponentEx = null;
        
        public var commanderHelpView:FortWelcomeCommanderView = null;
        
        public var fortWelcomeCommanderViewImporter:Sprite;
        
        private var helper:IFortsControlsAligner = null;
        
        private var _mode:String = null;
        
        private var _switcher:IFortModeSwitcher = null;
        
        private var stateMethods:Object;
        
        private var _buildings:IFortBuildingCmp;
        
        private var _header:IMainHeader = null;
        
        private var _footer:IMainFooter = null;
        
        public function update(param1:Object) : void
        {
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            if(this.commanderHelpView)
            {
                return this.commanderHelpView.getComponentForFocus();
            }
            return this._header.getComponentForFocus();
        }
        
        public function as_toggleCommanderHelp(param1:Boolean) : void
        {
            if(param1)
            {
                App.utils.asserter.assertNull(this.commanderHelpView,"toggleCommanderHelp already shown");
                this.commanderHelpView = App.utils.classFactory.getComponent("FortWelcomeCommanderViewUI",FortWelcomeCommanderView);
                this.commanderHelpView.content.button.addEventListener(ButtonEvent.CLICK,this.commanderHelpButtonHandler,false,0,true);
                addChild(this.commanderHelpView);
                this.updateControlPositions();
            }
            else
            {
                App.utils.asserter.assertNotNull(this.commanderHelpView,"toggleCommanderHelp not shown, can`t be hidden.");
                this.disposeCommanderHelp();
            }
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
        }
        
        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
        }
        
        public function get buildings() : IFortBuildingCmp
        {
            return this._buildings;
        }
        
        public function set buildings(param1:IFortBuildingCmp) : void
        {
            this._buildings = param1;
        }
        
        public function get header() : IMainHeader
        {
            return this._header;
        }
        
        public function set header(param1:IMainHeader) : void
        {
            this._header = param1;
        }
        
        public function get footer() : IMainFooter
        {
            return this._footer;
        }
        
        public function set footer(param1:IMainFooter) : void
        {
            this._footer = param1;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponentS(this._buildings,FORTIFICATION_ALIASES.FORT_BUILDING_COMPONENT_ALIAS);
            registerFlashComponentS(this._footer.ordersPanel,FORTIFICATION_ALIASES.FORT_ORDERS_PANEL_COMPONENT_ALIAS);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this._header.transportBtn.addEventListener(ButtonEvent.CLICK,this.onTransportButtonClickHandler);
            this._header.transportBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onTransportButtonMouseOverHandler);
            this._header.transportBtn.addEventListener(MouseEvent.MOUSE_OUT,onTransportButtonMouseOutHandler);
            this._header.statsBtn.addEventListener(ButtonEvent.CLICK,this.onStatsBtnClickHandler);
            this._header.clanListBtn.addEventListener(ButtonEvent.CLICK,this.onClanListBtnClickHandler);
            this._header.clanListBtn.addEventListener(LibraryLoaderEvent.ICON_LOADED,this.onHeaderClanListBtnIconLoadedHandler);
            this._header.clanListBtn.addEventListener(LibraryLoaderEvent.ICON_LOADING_FAILED,this.onHeaderClanListBtnIconLoadingFailedHandler);
            this._footer.intelligenceButton.addEventListener(ButtonEvent.CLICK,this.onIntelligenceButtonClickHandler);
            this._footer.sortieBtn.addEventListener(ButtonEvent.CLICK,this.onSortieButtonClickHandler);
            this._footer.leaveModeBtn.addEventListener(ButtonEvent.CLICK,this.onLeaveButtonClickHandler);
            this._switcher = IFortModeSwitcher(App.utils.classFactory.getObject(Linkages.FORT_MODE_SWITCHER));
            this._switcher.init(this);
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
            this.stateMethods[FORTIFICATION_ALIASES.MODE_COMMON] = this._buildings.updateCommonMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_DIRECTIONS] = this._buildings.updateDirectionsMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING] = this._buildings.updateTransportMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_COMMON_TUTORIAL] = this._buildings.updateCommonMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_DIRECTIONS_TUTORIAL] = this._buildings.updateDirectionsMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL] = this._buildings.updateTransportMode;
        }
        
        override protected function draw() : void
        {
            super.draw();
            this.updateControlPositions();
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(DirectionEvent.OPEN_DIRECTION,this.openDirHandler);
            removeEventListener(FortBuildingEvent.FIRST_TRANSPORTING_STEP,this.firstTransportingStepHandler);
            removeEventListener(FortBuildingEvent.NEXT_TRANSPORTING_STEP,this.nextTransportingStepHandler);
            removeEventListener(InputEvent.INPUT,this.handleEscape);
            this._footer.leaveModeBtn.removeEventListener(ButtonEvent.CLICK,this.onLeaveButtonClickHandler);
            this._footer.intelligenceButton.removeEventListener(ButtonEvent.CLICK,this.onIntelligenceButtonClickHandler);
            this._footer.sortieBtn.removeEventListener(ButtonEvent.CLICK,this.onSortieButtonClickHandler);
            this._header.transportBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onTransportButtonMouseOverHandler);
            this._header.transportBtn.removeEventListener(MouseEvent.MOUSE_OUT,onTransportButtonMouseOutHandler);
            this._header.transportBtn.removeEventListener(ButtonEvent.PRESS,this.onTransportButtonClickHandler);
            this._header.statsBtn.removeEventListener(ButtonEvent.CLICK,this.onStatsBtnClickHandler);
            this._header.clanListBtn.removeEventListener(ButtonEvent.CLICK,this.onClanListBtnClickHandler);
            this._header.clanListBtn.removeEventListener(LibraryLoaderEvent.ICON_LOADED,this.onHeaderClanListBtnIconLoadedHandler);
            this._header.clanListBtn.removeEventListener(LibraryLoaderEvent.ICON_LOADING_FAILED,this.onHeaderClanListBtnIconLoadingFailedHandler);
            this.stateMethods = App.utils.commons.cleanupDynamicObject(this.stateMethods);
            if(this.commanderHelpView)
            {
                this.disposeCommanderHelp();
            }
            this._buildings = null;
            this._switcher.dispose();
            this._switcher = null;
            this._footer.dispose();
            this._footer = null;
            this.landscapeMask.dispose();
            this.landscapeMask = null;
            this.helper = null;
            super.onDispose();
        }
        
        override protected function setMainData(param1:FortificationVO) : void
        {
            this._header.clanListBtn.label = param1.clanSize.toString();
            this._header.totalDepotQuantityText.htmlText = param1.defResText;
            this._header.clanInfo.applyClanData(param1);
            if(param1.disabledTransporting)
            {
                this._header.vignetteYellow.descrText.text = FORTIFICATIONS.FORTMAINVIEW_TRANSPORTING_TUTORIALDESCRDISABLED;
            }
        }
        
        override protected function switchMode(param1:FortModeStateVO) : void
        {
            if(param1.mode != this._mode)
            {
                App.utils.asserter.assert(!(FORTIFICATION_ALIASES.MODES.indexOf(param1.mode) == -1),"unknown fort mode:" + param1.mode);
                this.invokeStateMethod(false,this._mode);
                this.invokeStateMethod(true,param1.mode);
                this._mode = param1.mode;
            }
            this._switcher.applyMode(param1);
            this._header.statsBtn.tooltip = TOOLTIPS.FORTIFICATION_HEADER_STATISTICS;
            this._header.clanListBtn.tooltip = TOOLTIPS.FORTIFICATION_HEADER_CLANLIST;
            if(param1.mode == FORTIFICATION_ALIASES.MODE_TRANSPORTING || param1.mode == FORTIFICATION_ALIASES.MODE_DIRECTIONS)
            {
                dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this._footer));
            }
        }
        
        private function show() : void
        {
            this.visible = true;
        }
        
        private function invokeStateMethod(param1:Boolean, param2:String) : void
        {
            var _loc3_:* = false;
            if(param2 != null)
            {
                _loc3_ = !(FORTIFICATION_ALIASES.TUTORIAL_MODES.indexOf(param2) == -1);
                this.stateMethods[param2](param1,_loc3_);
            }
        }
        
        private function disposeCommanderHelp() : void
        {
            this.commanderHelpView.content.button.removeEventListener(ButtonEvent.CLICK,this.commanderHelpButtonHandler);
            this.commanderHelpView.dispose();
            this.commanderHelpView.parent.removeChild(this.commanderHelpView);
            this.commanderHelpView = null;
        }
        
        private function updateControlPositions() : void
        {
            var _loc1_:Number = localToGlobal(new Point(0,0)).y;
            var _loc2_:Number = App.appHeight - _loc1_ - CHAT_HEIGHT;
            this.landscapeMask.setActualSize(App.appWidth,_loc2_);
            FortsControlsAligner.instance.centerControl(this._buildings);
            this._buildings.y = Math.round((this.landscapeMask.height - this._buildings.height) / 2);
            this._buildings.updateControlPositions();
            this._header.updateControls();
            this._footer.updateControls();
            if(this.commanderHelpView)
            {
                this.commanderHelpView.setSize(App.appWidth,_loc2_);
            }
            this._header.widthFill = this._footer.widthFill = App.appWidth;
            this._footer.y = this.landscapeMask.actualHeight - this._footer.heightFill;
        }
        
        private function onHeaderClanListBtnIconLoadedHandler(param1:LibraryLoaderEvent) : void
        {
            this.show();
            this._header.clanListBtn.removeEventListener(LibraryLoaderEvent.ICON_LOADED,this.onHeaderClanListBtnIconLoadedHandler);
        }
        
        private function onHeaderClanListBtnIconLoadingFailedHandler(param1:LibraryLoaderEvent) : void
        {
            this.show();
            this._header.clanListBtn.removeEventListener(LibraryLoaderEvent.ICON_LOADING_FAILED,this.onHeaderClanListBtnIconLoadedHandler);
        }
        
        private function commanderHelpButtonHandler(param1:ButtonEvent) : void
        {
            onEnterBuildDirectionClickS();
            this.disposeCommanderHelp();
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
        }
        
        private function onClanListBtnClickHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            onClanClickS();
        }
        
        private function onStatsBtnClickHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            onStatsClickS();
        }
        
        private function onTransportButtonClickHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            if(this._mode == FORTIFICATION_ALIASES.MODE_TRANSPORTING)
            {
                removeEventListener(InputEvent.INPUT,this.handleEscape);
                onLeaveTransportingClickS();
            }
            else
            {
                addEventListener(InputEvent.INPUT,this.handleEscape);
                onEnterTransportingClickS();
            }
            this.updateControlPositions();
        }
        
        private function onTransportButtonMouseOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            if(this._header.transportBtn.selected)
            {
                _loc2_ = TOOLTIPS.FORTIFICATION_TRANPORTINGBUTTON_ACTIVE;
            }
            else
            {
                _loc2_ = TOOLTIPS.FORTIFICATION_TRANPORTINGBUTTON_INACTIVE;
            }
            App.toolTipMgr.showComplex(_loc2_);
        }
        
        private function onIntelligenceButtonClickHandler(param1:ButtonEvent) : void
        {
            onIntelligenceClickS();
        }
        
        private function onSortieButtonClickHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            onSortieClickS();
        }
        
        private function onLeaveButtonClickHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            var _loc2_:String = this._mode;
            if(_loc2_ == FORTIFICATION_ALIASES.MODE_TRANSPORTING)
            {
                removeEventListener(InputEvent.INPUT,this.handleEscape);
                onLeaveTransportingClickS();
            }
            else if(_loc2_ == FORTIFICATION_ALIASES.MODE_DIRECTIONS)
            {
                onLeaveBuildDirectionClickS();
            }
            
            this.updateControlPositions();
        }
        
        private function openDirHandler(param1:DirectionEvent) : void
        {
            param1.stopImmediatePropagation();
            onCreateDirectionClickS(param1.id);
        }
        
        private function firstTransportingStepHandler(param1:FortBuildingEvent) : void
        {
            param1.stopImmediatePropagation();
            onFirstTransportingStepS();
            this._header.vignetteYellow.descrText.text = FORTIFICATIONS.FORTMAINVIEW_TRANSPORTING_EXPORTINGSTATUS;
        }
        
        private function nextTransportingStepHandler(param1:FortBuildingEvent) : void
        {
            param1.stopImmediatePropagation();
            onNextTransportingStepS();
            this._header.vignetteYellow.descrText.text = FORTIFICATIONS.FORTMAINVIEW_TRANSPORTING_IMPORTINGSTATUS;
        }
        
        private function handleEscape(param1:InputEvent) : void
        {
            if(param1.handled)
            {
                return;
            }
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
            {
                param1.handled = true;
                removeEventListener(InputEvent.INPUT,this.handleEscape);
                onLeaveTransportingClickS();
            }
        }
        
        public function canShowAutomatically() : Boolean
        {
            return false;
        }
    }
}
