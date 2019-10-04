package net.wg.gui.lobby.sessionStats
{
    import net.wg.infrastructure.base.meta.impl.SessionStatsPopoverMeta;
    import net.wg.infrastructure.base.meta.ISessionStatsPopoverMeta;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.gui.lobby.components.ResizableViewStack;
    import net.wg.gui.components.advanced.ContentTabBar;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextField;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsAnimatedCounter;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsPopoverVO;
    import net.wg.data.VO.ButtonPropertiesVO;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.gui.components.popovers.PopOver;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsTabVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.gui.lobby.sessionStats.events.SessionStatsPopoverResizedEvent;
    import scaleform.clik.events.IndexEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.generated.SESSION_STATS_CONSTANTS;
    import net.wg.infrastructure.base.BaseDAAPIComponent;

    public class SessionStatsPopover extends SessionStatsPopoverMeta implements ISessionStatsPopoverMeta, IStageSizeDependComponent
    {

        private static const COLLAPSED_HEIGHT:int = 491;

        private static const EXTENDED_HEIGHT:int = 735;

        private static const MIN_EXTENDED_HEIGHT:int = 580;

        private static const MIN_RESOLUTION:int = 900;

        private static const MIN_TAB_WIDTH:int = 142;

        private static const BUTTON_STATES_INVALID:String = "buttonStatesInvalid";

        private static const EXPANDED_INVALID:String = "expandedInvalid";

        public var viewStack:ResizableViewStack = null;

        public var buttonBar:ContentTabBar = null;

        public var moreBtn:ISoundButtonEx = null;

        public var resetBtn:ISoundButtonEx = null;

        public var lipBg:MovieClip = null;

        public var headerBg:Image = null;

        public var title:TextField = null;

        public var overlay:MovieClip = null;

        public var counterAnimated:SessionStatsAnimatedCounter = null;

        private var _currentAlias:String = "";

        private var _data:SessionStatsPopoverVO = null;

        private var _buttons:Array = null;

        private var _buttonStates:Vector.<ButtonPropertiesVO> = null;

        private var _isExpanded:Boolean;

        public function SessionStatsPopover()
        {
            super();
        }

        private static function getExpandedHeight(param1:Boolean) : Number
        {
            return param1?App.appHeight < MIN_RESOLUTION?MIN_EXTENDED_HEIGHT:EXTENDED_HEIGHT:COLLAPSED_HEIGHT;
        }

        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            PopOver(param1).isCloseBtnVisible = true;
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            invalidate(EXPANDED_INVALID);
        }

        override protected function draw() : void
        {
            var _loc1_:uint = 0;
            var _loc2_:SessionStatsTabVO = null;
            var _loc3_:* = 0;
            var _loc4_:ISoundButtonEx = null;
            var _loc5_:ButtonPropertiesVO = null;
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.expand(this._data.isExpanded);
                this.headerBg.source = this._data.headerImg;
                this.buttonBar.dataProvider = this._data.tabs;
                _loc1_ = this._data.tabs.length;
                _loc3_ = 0;
                while(_loc3_ < _loc1_)
                {
                    _loc2_ = this._data.tabs[_loc3_];
                    if(_loc2_.selected)
                    {
                        this.buttonBar.selectedIndex = _loc3_;
                        this.viewStack.show(_loc2_.linkage,_loc2_.linkage);
                        break;
                    }
                    _loc3_++;
                }
                this.title.htmlText = this._data.title;
                this.counterAnimated.goToNumber(this._data.lastBattleCount);
                this.counterAnimated.animateTo(this._data.battleCount);
                this.counterAnimated.x = width >> 1;
            }
            if(this._buttonStates && isInvalid(BUTTON_STATES_INVALID))
            {
                _loc1_ = this._buttons.length;
                _loc3_ = 0;
                while(_loc3_ < _loc1_)
                {
                    _loc4_ = this._buttons[_loc3_];
                    _loc5_ = this._buttonStates[_loc3_];
                    _loc4_.tooltip = _loc5_.btnTooltip;
                    _loc4_.label = _loc5_.btnLabel;
                    _loc4_.enabled = _loc5_.btnEnabled;
                    _loc3_++;
                }
            }
            if(isInvalid(EXPANDED_INVALID))
            {
                this.updateViewSize(this._isExpanded);
            }
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.viewStack.setAvailableSize(width,height - this.viewStack.y - (this.lipBg.height >> 1));
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.viewStack.cache = true;
            this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
            this.viewStack.addEventListener(SessionStatsPopoverResizedEvent.RESIZED,this.onPopoverResizedHandler);
            this.buttonBar.minRendererWidth = MIN_TAB_WIDTH;
            this.buttonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
            this.title.addEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
            this.title.addEventListener(MouseEvent.ROLL_OUT,this.onTitleRollOutHandler);
            this.moreBtn.addEventListener(ButtonEvent.CLICK,this.onMoreBtnClickHandler);
            this.resetBtn.addEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
            this.moreBtn.mouseEnabledOnDisabled = true;
            this.resetBtn.mouseEnabledOnDisabled = true;
            this._buttons = [this.moreBtn,this.resetBtn];
            App.stageSizeMgr.register(this);
        }

        override protected function onDispose() : void
        {
            App.stageSizeMgr.unregister(this);
            this.buttonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
            this.buttonBar.dispose();
            this.buttonBar = null;
            this.viewStack.removeEventListener(SessionStatsPopoverResizedEvent.RESIZED,this.onPopoverResizedHandler);
            this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
            this.viewStack.dispose();
            this.viewStack = null;
            this.moreBtn.removeEventListener(ButtonEvent.CLICK,this.onMoreBtnClickHandler);
            this.moreBtn.dispose();
            this.moreBtn = null;
            this.resetBtn.removeEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
            this.resetBtn.dispose();
            this.resetBtn = null;
            this.headerBg.dispose();
            this.headerBg = null;
            this.counterAnimated.dispose();
            this.counterAnimated = null;
            this.title.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
            this.title.removeEventListener(MouseEvent.ROLL_OUT,this.onTitleRollOutHandler);
            this.title = null;
            this._buttons.splice(0,this._buttons.length);
            this._buttons = null;
            this.overlay = null;
            this.lipBg = null;
            this._data = null;
            this._buttonStates = null;
            super.onDispose();
        }

        override protected function setData(param1:SessionStatsPopoverVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function setButtonsState(param1:Vector.<ButtonPropertiesVO>) : void
        {
            this._buttonStates = param1;
            invalidate(BUTTON_STATES_INVALID);
        }

        private function onPopoverResizedHandler(param1:SessionStatsPopoverResizedEvent) : void
        {
            this.expand(param1.isExpanded);
            onExpandedS(param1.isExpanded);
        }

        private function expand(param1:Boolean) : void
        {
            this._isExpanded = param1;
            invalidate(EXPANDED_INVALID);
        }

        private function updateViewSize(param1:Boolean) : void
        {
            var _loc2_:Number = height - this.moreBtn.y;
            setViewSize(width,getExpandedHeight(param1));
            this.moreBtn.y = this.resetBtn.y = height - _loc2_;
            this.lipBg.y = height - (this.lipBg.height >> 1);
        }

        private function onViewStackViewChangedHandler(param1:ViewStackEvent) : void
        {
            var _loc2_:String = param1.viewId;
            switch(_loc2_)
            {
                case SESSION_STATS_CONSTANTS.SESSION_VEHICLE_STATS_VIEW_LINKAGE:
                    this._currentAlias = SESSION_STATS_CONSTANTS.SESSION_VEHICLE_STATS_VIEW_PY_ALIAS;
                    break;
                case SESSION_STATS_CONSTANTS.SESSION_BATTLE_STATS_VIEW_LINKAGE:
                default:
                    this._currentAlias = SESSION_STATS_CONSTANTS.SESSION_BATTLE_STATS_VIEW_PY_ALIAS;
            }
            if(!isFlashComponentRegisteredS(this._currentAlias))
            {
                registerFlashComponentS(BaseDAAPIComponent(param1.view),this._currentAlias);
                param1.view.update(this._data);
            }
            invalidateSize();
        }

        private function onButtonBarIndexChangeHandler(param1:IndexEvent) : void
        {
            var _loc2_:SessionStatsTabVO = null;
            if(param1.lastIndex != -1 && param1.data)
            {
                _loc2_ = SessionStatsTabVO(param1.data);
                this.viewStack.show(_loc2_.linkage,_loc2_.linkage);
                onTabSelectedS(_loc2_.alias);
            }
        }

        private function onTitleRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(this._data.titleTooltip,null);
        }

        private function onTitleRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onMoreBtnClickHandler(param1:ButtonEvent) : void
        {
            if(this.moreBtn.enabled)
            {
                onClickMoreBtnS();
            }
        }

        private function onResetBtnClickHandler(param1:ButtonEvent) : void
        {
            if(this.resetBtn.enabled)
            {
                onClickResetBtnS();
            }
        }
    }
}
