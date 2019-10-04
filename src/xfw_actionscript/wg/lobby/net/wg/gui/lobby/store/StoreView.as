package net.wg.gui.lobby.store
{
    import net.wg.infrastructure.base.meta.impl.StoreViewMeta;
    import net.wg.infrastructure.base.meta.IStoreViewMeta;
    import net.wg.gui.components.advanced.screenTab.ScreenTabButtonBar;
    import net.wg.gui.lobby.components.ResizableViewStack;
    import net.wg.gui.components.controls.BitmapFill;
    import flash.display.Sprite;
    import net.wg.gui.components.advanced.BackButton;
    import net.wg.data.VO.CountersVo;
    import scaleform.clik.controls.Button;
    import net.wg.utils.ICounterManager;
    import net.wg.utils.ICounterProps;
    import net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta;
    import net.wg.infrastructure.managers.counter.CounterProps;
    import net.wg.data.constants.LobbyMetrics;
    import scaleform.clik.utils.Padding;
    import net.wg.gui.events.ViewStackEvent;
    import scaleform.clik.events.IndexEvent;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.store.data.StoreViewInitVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.store.data.ButtonBarVO;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.gui.lobby.store.evnts.StoreViewStackEvent;
    import scaleform.clik.interfaces.IDataProvider;

    public class StoreView extends StoreViewMeta implements IStoreViewMeta
    {

        private static const VIEW_STACK_BOTTOM_PADDING:Number = 3;

        private static const INVALIDATE_TAB_COUNTERS:String = "invTabCounters";

        private static const INVALIDATE_BUTTON_BAR:String = "invButtonBar";

        private static const MOVING_TEXT_HEIGHT:int = 24;

        private static const BG_OFFSET:int = 85;

        public var buttonBar:ScreenTabButtonBar = null;

        public var viewStack:ResizableViewStack = null;

        public var background:BitmapFill = null;

        public var headerBg:BitmapFill = null;

        public var tabGradient:Sprite = null;

        public var backButton:BackButton = null;

        private var _currentViewAliasId:String;

        private var _availableVewStackHeight:Number = 0;

        private var _countersToSet:Vector.<CountersVo> = null;

        private var _countersToRemove:Vector.<String> = null;

        private var _actualCounters:Vector.<Button>;

        private var _counterManager:ICounterManager;

        private var _isButtonBarReady:Boolean = false;

        private var _defCounterProps:ICounterProps = null;

        private var _globalVarsMgr:IGlobalVarsMgrMeta = null;

        public function StoreView()
        {
            this._actualCounters = new Vector.<Button>();
            this._counterManager = App.utils.counterManager;
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc3_:Boolean = this._globalVarsMgr.isShowTickerS();
            this._availableVewStackHeight = param2 - this.viewStack.y + (_loc3_?MOVING_TEXT_HEIGHT:VIEW_STACK_BOTTOM_PADDING);
            setViewSize(param1,param2 + (_loc3_?MOVING_TEXT_HEIGHT:0));
        }

        override protected function initialize() : void
        {
            bgIndex = getChildIndex(this.background) + 1;
            super.initialize();
            this._globalVarsMgr = App.globalVarsMgr;
            this._defCounterProps = new CounterProps(-47,4);
            var _loc1_:Number = LobbyMetrics.LOBBY_MESSENGER_HEIGHT - BG_OFFSET + (this._globalVarsMgr.isShowTickerS()?MOVING_TEXT_HEIGHT:0);
            bgPaddingLayout = new Padding(_loc1_,0,0,0);
            bgHolder.y = BG_OFFSET;
        }

        override protected function onPopulate() : void
        {
            this.viewStack.cache = true;
            this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewStackNeedUpdateHandler,false,0,true);
            this.buttonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
            this.buttonBar.addEventListener(Event.COMPLETE,this.onButtonBarCompleteHandler);
            this.buttonBar.allowSwapRendererForSelect = false;
            this.backButton.visible = false;
            this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
            super.onPopulate();
        }

        override protected function init(param1:StoreViewInitVO) : void
        {
            setBackground(param1.bgImageSrc);
            this.buttonBar.dataProvider = param1.buttonBarData;
            this.buttonBar.selectedIndex = param1.currentViewIdx;
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:String = null;
            var _loc4_:Button = null;
            var _loc5_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.buttonBar.x = _width - this.buttonBar.width >> 1;
                this.viewStack.setAvailableSize(_width,this._availableVewStackHeight);
                this.background.widthFill = _width;
                this.background.heightFill = _height + LobbyMetrics.LOBBY_MESSENGER_HEIGHT;
                this.tabGradient.width = _width;
                this.headerBg.widthFill = _width;
                y = this._globalVarsMgr.isShowTickerS()?-MOVING_TEXT_HEIGHT:0;
            }
            if(isInvalid(INVALIDATE_BUTTON_BAR))
            {
                invalidate(INVALIDATE_TAB_COUNTERS);
            }
            if(this._isButtonBarReady && isInvalid(INVALIDATE_TAB_COUNTERS))
            {
                _loc1_ = 0;
                _loc2_ = 0;
                _loc3_ = Values.EMPTY_STR;
                _loc4_ = null;
                if(this._countersToSet)
                {
                    _loc2_ = this._countersToSet.length;
                    _loc1_ = 0;
                    while(_loc1_ < _loc2_)
                    {
                        _loc3_ = this._countersToSet[_loc1_].componentId;
                        _loc4_ = this.getTabRenderer(_loc3_);
                        App.utils.asserter.assertNotNull(_loc4_,_loc3_ + " " + Errors.CANT_NULL);
                        this._counterManager.setCounter(_loc4_,this._countersToSet[_loc1_].count,null,this._defCounterProps);
                        this._actualCounters.push(_loc4_);
                        _loc1_++;
                    }
                    this._countersToSet.splice(0,this._countersToSet.length);
                    this._countersToSet = null;
                }
                if(this._countersToRemove)
                {
                    _loc2_ = this._countersToRemove.length;
                    _loc5_ = 0;
                    _loc1_ = 0;
                    while(_loc1_ < _loc2_)
                    {
                        _loc3_ = this._countersToRemove[_loc1_];
                        _loc4_ = this.getTabRenderer(_loc3_);
                        App.utils.asserter.assertNotNull(_loc4_,_loc3_ + " " + Errors.CANT_NULL);
                        this._counterManager.removeCounter(_loc4_);
                        _loc5_ = this._actualCounters.indexOf(_loc4_);
                        if(_loc5_ >= 0)
                        {
                            this._actualCounters.splice(_loc5_,1);
                        }
                        _loc1_++;
                    }
                    this._countersToRemove.splice(0,this._countersToRemove.length);
                    this._countersToRemove = null;
                }
            }
        }

        override protected function onDispose() : void
        {
            this._defCounterProps = null;
            if(this._countersToSet)
            {
                this._countersToSet.splice(0,this._countersToSet.length);
                this._countersToSet = null;
            }
            if(this._countersToRemove)
            {
                this._countersToRemove.splice(0,this._countersToSet.length);
                this._countersToRemove = null;
            }
            if(this._actualCounters)
            {
                while(this._actualCounters.length)
                {
                    this._counterManager.removeCounter(this._actualCounters.pop());
                }
                this._actualCounters = null;
            }
            this._counterManager = null;
            this.buttonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
            this.buttonBar.removeEventListener(Event.COMPLETE,this.onButtonBarCompleteHandler);
            this.buttonBar.dispose();
            this.buttonBar = null;
            this.clearCurrentVew();
            this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewStackNeedUpdateHandler);
            this.viewStack.dispose();
            this.viewStack = null;
            this.background.dispose();
            this.background = null;
            this.headerBg.dispose();
            this.headerBg = null;
            this.tabGradient = null;
            this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
            this.backButton.dispose();
            this.backButton = null;
            this._globalVarsMgr = null;
            super.onDispose();
        }

        override protected function setBtnTabCounters(param1:Vector.<CountersVo>) : void
        {
            this._countersToSet = param1;
            invalidate(INVALIDATE_TAB_COUNTERS);
        }

        override protected function removeBtnTabCounters(param1:Vector.<String>) : void
        {
            this._countersToRemove = param1;
            invalidate(INVALIDATE_TAB_COUNTERS);
        }

        override protected function onEscapeKeyDown() : void
        {
            onCloseS();
        }

        public function as_hideBackButton() : void
        {
            this.backButton.visible = false;
        }

        public function as_showBackButton(param1:String, param2:String) : void
        {
            this.backButton.label = param1;
            this.backButton.descrLabel = param2;
            this.backButton.visible = true;
        }

        public function as_showStorePage(param1:String) : void
        {
            this.switchView(param1);
        }

        private function changeViewByButtonBarData(param1:ButtonBarVO) : void
        {
            this.clearCurrentVew();
            this._currentViewAliasId = param1.id;
            this.viewStack.show(param1.linkage,param1.linkage);
            onTabChangeS(this._currentViewAliasId);
        }

        private function clearCurrentVew() : void
        {
            if(this.viewStack.cache)
            {
                return;
            }
            var _loc1_:IDAAPIModule = IDAAPIModule(this.viewStack.currentView);
            if(_loc1_)
            {
                _loc1_.removeEventListener(StoreViewStackEvent.SWITCH_TO_VIEW,this.onCurViewSwitchToViewHandler);
                unregisterFlashComponentS(this._currentViewAliasId);
            }
        }

        private function switchView(param1:String) : void
        {
            var _loc2_:IDataProvider = this.buttonBar.dataProvider;
            var _loc3_:ButtonBarVO = null;
            var _loc4_:int = _loc2_.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                _loc3_ = ButtonBarVO(_loc2_.requestItemAt(_loc5_));
                if(_loc3_.id == param1)
                {
                    this.buttonBar.selectedIndex = _loc5_;
                    break;
                }
                _loc5_++;
            }
        }

        private function getTabRenderer(param1:String) : Button
        {
            var _loc2_:IDataProvider = this.buttonBar.dataProvider;
            var _loc3_:ButtonBarVO = null;
            var _loc4_:int = _loc2_.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                _loc3_ = ButtonBarVO(_loc2_.requestItemAt(_loc5_));
                if(_loc3_.id == param1)
                {
                    return this.buttonBar.getButtonAt(_loc5_);
                }
                _loc5_++;
            }
            return null;
        }

        private function onButtonBarCompleteHandler(param1:Event) : void
        {
            if(!this._isButtonBarReady)
            {
                this._isButtonBarReady = true;
                invalidate(INVALIDATE_BUTTON_BAR);
            }
        }

        private function onBackButtonClickHandler(param1:ButtonEvent) : void
        {
            onBackButtonClickS();
        }

        private function onButtonBarIndexChangeHandler(param1:IndexEvent) : void
        {
            var _loc2_:ButtonBarVO = ButtonBarVO(this.buttonBar.dataProvider.requestItemAt(param1.index));
            this.changeViewByButtonBarData(_loc2_);
        }

        private function onCurViewSwitchToViewHandler(param1:StoreViewStackEvent) : void
        {
            this.switchView(param1.viewId);
        }

        private function onViewStackNeedUpdateHandler(param1:ViewStackEvent) : void
        {
            var _loc2_:IDAAPIModule = IDAAPIModule(param1.view);
            if(!isFlashComponentRegisteredS(this._currentViewAliasId))
            {
                _loc2_.addEventListener(StoreViewStackEvent.SWITCH_TO_VIEW,this.onCurViewSwitchToViewHandler);
                registerFlashComponentS(_loc2_,this._currentViewAliasId);
                invalidateSize();
            }
        }
    }
}
