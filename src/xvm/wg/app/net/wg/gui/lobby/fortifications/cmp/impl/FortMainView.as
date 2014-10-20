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
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.lobby.fortifications.events.DirectionEvent;
    import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
    import scaleform.clik.events.InputEvent;
    import net.wg.gui.lobby.fortifications.data.FortificationVO;
    import net.wg.gui.lobby.fortifications.data.FortModeStateVO;
    import net.wg.gui.lobby.fortifications.data.BattleNotifiersDataVO;
    import net.wg.gui.lobby.fortifications.data.FunctionalStates;
    import net.wg.gui.lobby.fortifications.data.FortModeVO;
    import flash.geom.Point;
    import net.wg.gui.lobby.fortifications.utils.impl.FortsControlsAligner;
    import net.wg.infrastructure.events.LibraryLoaderEvent;
    import flash.events.Event;
    import net.wg.infrastructure.exceptions.LifecycleException;
    import scaleform.clik.ui.InputDetails;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    
    public class FortMainView extends FortMainViewMeta implements IFortMainView
    {
        
        public function FortMainView()
        {
            this.stateMethods = {};
            this.TRANSPORTING_MODES = new <String>[FORTIFICATION_ALIASES.MODE_TRANSPORTING_FIRST_STEP,FORTIFICATION_ALIASES.MODE_TRANSPORTING_NEXT_STEP,FORTIFICATION_ALIASES.MODE_TRANSPORTING_NOT_AVAILABLE];
            this.TRANSPORTING_TUTORIAL_MODES = new <String>[FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL,FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL_FIRST_STEP,FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL_NEXT_STEP];
            this.DIRECTION_MODES = new <String>[FORTIFICATION_ALIASES.MODE_DIRECTIONS];
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
        
        private var loadersList:Vector.<DisplayObject> = null;
        
        private var defaultLoadersList:Vector.<DisplayObject> = null;
        
        private var TRANSPORTING_MODES:Vector.<String>;
        
        private var TRANSPORTING_TUTORIAL_MODES:Vector.<String>;
        
        private var DIRECTION_MODES:Vector.<String>;
        
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
        
        public function as_setClanIconId(param1:String) : void
        {
            this._header.clanInfo.setClanImage(param1);
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
        
        public function as_setHeaderMessage(param1:String) : void
        {
            this._header.infoTF.htmlText = param1;
        }
        
        public function canShowAutomatically() : Boolean
        {
            return false;
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
            this.addLoaderHandlers();
            this._header.transportBtn.addEventListener(ButtonEvent.CLICK,this.onTransportButtonClickHandler);
            this._header.transportBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onTransportButtonMouseOverHandler);
            this._header.transportBtn.addEventListener(MouseEvent.MOUSE_OUT,onTransportButtonMouseOutHandler);
            this._header.statsBtn.addEventListener(ButtonEvent.CLICK,this.onStatsBtnClickHandler);
            this._header.clanListBtn.addEventListener(ButtonEvent.CLICK,this.onClanListBtnClickHandler);
            this._header.calendarBtn.addEventListener(ButtonEvent.CLICK,this.onCalendarBtnClickHandler);
            this._header.settingBtn.addEventListener(ButtonEvent.CLICK,this.onSettingBtnClickHandler);
            this._footer.intelligenceButton.addEventListener(ButtonEvent.CLICK,this.onIntelligenceButtonClickHandler);
            this._footer.sortieBtn.addEventListener(ButtonEvent.CLICK,this.onSortieButtonClickHandler);
            this._footer.leaveModeBtn.addEventListener(ButtonEvent.CLICK,this.onLeaveButtonClickHandler);
            this._switcher = IFortModeSwitcher(App.utils.classFactory.getObject(Linkages.FORT_MODE_SWITCHER));
            this._switcher.init(this);
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
            this.stateMethods[FORTIFICATION_ALIASES.MODE_COMMON] = this._buildings.updateCommonMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_DIRECTIONS] = this._buildings.updateDirectionsMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_FIRST_STEP] = this._buildings.updateTransportMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_NEXT_STEP] = this._buildings.updateTransportMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_NOT_AVAILABLE] = this._buildings.updateTransportMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_COMMON_TUTORIAL] = this._buildings.updateCommonMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_DIRECTIONS_TUTORIAL] = this._buildings.updateDirectionsMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL] = this._buildings.updateTransportMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL_FIRST_STEP] = this._buildings.updateTransportMode;
            this.stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL_NEXT_STEP] = this._buildings.updateTransportMode;
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
            this.removeLoaderHandlers();
            this._header.calendarBtn.removeEventListener(ButtonEvent.CLICK,this.onCalendarBtnClickHandler);
            this._header.settingBtn.removeEventListener(ButtonEvent.CLICK,this.onSettingBtnClickHandler);
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
            this.TRANSPORTING_MODES = null;
            this.TRANSPORTING_TUTORIAL_MODES = null;
            this.DIRECTION_MODES = null;
            this.loadersList = null;
            this.defaultLoadersList = null;
            super.onDispose();
        }
        
        override protected function setMainData(param1:FortificationVO) : void
        {
            this._header.clanListBtn.label = param1.clanSize.toString();
            this._header.totalDepotQuantityText.htmlText = param1.defResText;
            this._header.clanInfo.applyClanData(param1);
            this.updateControlPositions();
        }
        
        override protected function switchMode(param1:FortModeStateVO) : void
        {
            if(param1.mode != this._mode)
            {
                App.utils.asserter.assert(!(FORTIFICATION_ALIASES.MODES.indexOf(param1.mode) == -1),"unknown fort mode:" + param1.mode);
                this.invokeStateMethod(false,this._mode,this.getFortMode(param1.mode));
                this.invokeStateMethod(true,param1.mode,this.getFortMode(param1.mode));
                this._mode = param1.mode;
            }
            this._switcher.applyMode(param1);
            this._header.statsBtn.tooltip = TOOLTIPS.FORTIFICATION_HEADER_STATISTICS;
            this._header.clanListBtn.tooltip = TOOLTIPS.FORTIFICATION_HEADER_CLANLIST;
            this._header.calendarBtn.tooltip = TOOLTIPS.FORTIFICATION_HEADER_CALENDARBTN;
            this._header.settingBtn.tooltip = TOOLTIPS.FORTIFICATION_HEADER_SETTINGSBTN;
            if((this.isInTransportingMode(param1.mode)) || (this.isInDirectionMode(param1.mode)))
            {
                dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this._footer));
            }
        }
        
        override protected function setBattlesDirectionData(param1:BattleNotifiersDataVO) : void
        {
            this._buildings.directionsContainer.updateBattleDirectionNotifiers(param1.directionsBattles);
        }
        
        private function getFortMode(param1:String) : Number
        {
            if(param1 == FORTIFICATION_ALIASES.MODE_TRANSPORTING_NEXT_STEP)
            {
                return FunctionalStates.TRANSPORTING_NEXT_STEP;
            }
            if(param1 == FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL_FIRST_STEP)
            {
                return FunctionalStates.TRANSPORTING_TUTORIAL_FIRST_STEP;
            }
            return FunctionalStates.UNKNOWN;
        }
        
        private function isInTransportingMode(param1:String) : Boolean
        {
            return !(this.TRANSPORTING_MODES.indexOf(param1) == -1);
        }
        
        private function isInDirectionMode(param1:String) : Boolean
        {
            return !(this.DIRECTION_MODES.indexOf(param1) == -1);
        }
        
        private function show() : void
        {
            this.visible = true;
        }
        
        private function invokeStateMethod(param1:Boolean, param2:String, param3:Number) : void
        {
            var _loc4_:FortModeVO = null;
            if(param2 != null)
            {
                _loc4_ = new FortModeVO();
                _loc4_.isEntering = param1;
                _loc4_.isTutorial = !(FORTIFICATION_ALIASES.TUTORIAL_MODES.indexOf(param2) == -1);
                _loc4_.currentMode = param3;
                this.stateMethods[param2](_loc4_);
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
            FortsControlsAligner.instance.centerControl(this._buildings,false);
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
        
        private function addLoaderHandlers() : void
        {
            this.loadersList = new Vector.<DisplayObject>();
            this.defaultLoadersList = new Vector.<DisplayObject>();
            this.loadersList.push(this._buildings.landscapeBG);
            this.loadersList.push(this._header.clanListBtn);
            this.defaultLoadersList = this.loadersList.concat();
            var _loc1_:int = this.loadersList.length;
            var _loc2_:DisplayObject = null;
            var _loc3_:* = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = this.loadersList[_loc3_];
                _loc2_.addEventListener(LibraryLoaderEvent.ICON_LOADED,this.onLoadHandle);
                _loc2_.addEventListener(LibraryLoaderEvent.ICON_LOADING_FAILED,this.onLoadHandle);
                _loc3_++;
            }
        }
        
        private function removeLoaderHandlers() : void
        {
            var _loc1_:int = this.defaultLoadersList.length;
            var _loc2_:DisplayObject = null;
            var _loc3_:* = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = this.defaultLoadersList[_loc3_];
                _loc2_.removeEventListener(LibraryLoaderEvent.ICON_LOADED,this.onLoadHandle);
                _loc2_.removeEventListener(LibraryLoaderEvent.ICON_LOADING_FAILED,this.onLoadHandle);
                _loc3_++;
            }
        }
        
        private function onLoadHandle(param1:Event) : void
        {
            this.loadersList.splice(this.loadersList.indexOf(param1.target),1);
            if(this.loadersList.length == 0)
            {
                this.removeLoaderHandlers();
                onViewReadyS();
                this.show();
            }
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
        
        private function onCalendarBtnClickHandler(param1:ButtonEvent) : void
        {
            onCalendarClickS();
        }
        
        private function onSettingBtnClickHandler(param1:ButtonEvent) : void
        {
            onSettingClickS();
        }
        
        private function onTransportButtonClickHandler(param1:ButtonEvent) : void
        {
            DebugUtils.LOG_DEBUG("onTransportButtonClickHandler:" + initialized + "/" + this._buildings.isDAAPIInited);
            var _loc2_:* = "onTransportButtonClickHandler invoked after dispose!";
            App.utils.asserter.assert(!_baseDisposed,_loc2_,LifecycleException);
            App.eventLogManager.logUIEvent(param1,0);
            if(this.isInTransportingMode(this._mode))
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
            if(this.isInTransportingMode(_loc2_))
            {
                removeEventListener(InputEvent.INPUT,this.handleEscape);
                onLeaveTransportingClickS();
            }
            else if(this.isInDirectionMode(_loc2_))
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
        }
        
        private function nextTransportingStepHandler(param1:FortBuildingEvent) : void
        {
            param1.stopImmediatePropagation();
            onNextTransportingStepS();
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
                if(this.TRANSPORTING_TUTORIAL_MODES.indexOf(this._mode) == -1)
                {
                    removeEventListener(InputEvent.INPUT,this.handleEscape);
                    onLeaveTransportingClickS();
                }
            }
        }
    }
}
