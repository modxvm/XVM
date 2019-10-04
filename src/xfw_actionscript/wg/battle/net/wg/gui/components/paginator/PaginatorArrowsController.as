package net.wg.gui.components.paginator
{
    import flash.events.EventDispatcher;
    import net.wg.gui.components.interfaces.IPaginatorArrowsController;
    import flash.display.DisplayObjectContainer;
    import net.wg.utils.ILocale;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.containers.ButtonGroupEx;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.controls.Button;
    import flash.geom.Point;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.events.PaginationGroupEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.wg.gui.components.containers.HorizontalGroupLayout;

    public class PaginatorArrowsController extends EventDispatcher implements IPaginatorArrowsController
    {

        private static const TO_PREV_PAGE_BTN_NAME:String = "prevPageBtn";

        private static const TO_NEXT_PAGE_BTN_NAME:String = "nextPageBtn";

        private static const NAV_BUTTON_WIDTH:uint = 168;

        private static const NAV_BUTTON_MIN_WIDTH:uint = 74;

        private static const PAGE_BUTTONS_Y_SHIFT:int = -15;

        private static const PAGE_BUTTON_RIGHT_X_SHIFT:int = -1;

        private static const PAGE_BUTTON_LEFT_X_SHIFT:int = 15;

        private static const PAGINATOR_X_SHIFT:int = 9;

        private static const AFTER_ARROW_CLICK_CALL_CALLBACK_DELAY:int = 300;

        private static const MIN_WIDTH:uint = 1200;

        public var allowPageChange:Boolean = true;

        private var _hideDisabledArrows:Boolean = false;

        private var _holder:DisplayObjectContainer;

        private var _prevPageBtn:PaginationPageButton = null;

        private var _nextPageBtn:PaginationPageButton = null;

        private var _locale:ILocale = null;

        private var _arrowLeftBtn:ISoundButtonEx;

        private var _arrowRightBtn:ISoundButtonEx;

        private var _pageButtons:PaginationGroup;

        private var _buttonGroup:ButtonGroupEx;

        private var _currentMissionIndex:int = -1;

        private var _currentPageIndex:int = 0;

        private var _maxPagesLen:int = 0;

        private var _maxElementsPerPage:int = 0;

        private var _pagesData:DataProvider = null;

        private var _hasPagesBtns:Boolean = false;

        public function PaginatorArrowsController(param1:DisplayObjectContainer, param2:PaginationGroup, param3:ISoundButtonEx, param4:ISoundButtonEx, param5:String, param6:int = 0, param7:Boolean = false, param8:int = 0)
        {
            super();
            this._locale = App.utils.locale;
            this._holder = param1;
            this._pageButtons = param2;
            this._arrowLeftBtn = param3;
            this._arrowRightBtn = param4;
            this._hideDisabledArrows = param7;
            this._arrowLeftBtn.visible = this._arrowRightBtn.visible = false;
            this._arrowRightBtn.mouseEnabledOnDisabled = this._arrowLeftBtn.mouseEnabledOnDisabled = true;
            this._maxElementsPerPage = param6;
            var _loc9_:HorizontalGroupLayout = new HorizontalGroupLayout();
            _loc9_.gap = param8;
            this._pageButtons.layout = _loc9_;
            this._pageButtons.itemRendererLinkage = Linkages.PAGINATION_DETAILS_NUM_BUTTON;
            this._pageButtons.addEventListener(PaginationGroupEvent.GROUP_CHANGED,this.onPageButtonsGroupChangedHandler);
            this._buttonGroup = ButtonGroupEx.getGroup(param5,DisplayObjectContainer(this._pageButtons));
            this._pageButtons.maxElementsPerPage = this._maxElementsPerPage;
            this._arrowLeftBtn.addEventListener(ButtonEvent.CLICK,this.onArrowLeftBtnClickHandler);
            this._arrowRightBtn.addEventListener(ButtonEvent.CLICK,this.onArrowRightBtnClickHandler);
            this._arrowLeftBtn.addEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
            this._arrowRightBtn.addEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
            this._arrowLeftBtn.addEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
            this._arrowRightBtn.addEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
            this._buttonGroup.addEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function getPageIndex() : int
        {
            return this._currentMissionIndex;
        }

        public function getSelectedButton() : Button
        {
            return this._buttonGroup.selectedButton;
        }

        public function setPageIndex(param1:int) : void
        {
            if(this._currentMissionIndex == param1)
            {
                return;
            }
            var _loc2_:int = param1 / this._maxElementsPerPage;
            if(_loc2_ != this._currentPageIndex)
            {
                this.switchPage(_loc2_,param1);
            }
            else
            {
                this._currentMissionIndex = param1;
                this.onPageUpdate();
            }
        }

        public function setPages(param1:DataProvider) : void
        {
            this._pagesData = param1;
            this._pageButtons.dataProvider = param1;
            this._maxPagesLen = this._pageButtons.getPagesCount();
            this._pageButtons.validateNow();
            this._arrowLeftBtn.visible = this._arrowRightBtn.visible = this._pagesData.length > 1;
        }

        public function setPositions(param1:Point) : void
        {
            this._pageButtons.x = param1.x - (this._pageButtons.width >> 1) + PAGINATOR_X_SHIFT;
            this._pageButtons.y = param1.y;
            this.layoutPageBtns();
        }

        public function updateSize(param1:int, param2:int) : void
        {
            var _loc4_:uint = 0;
            var _loc3_:* = App.appWidth <= MIN_WIDTH;
            if(this._hasPagesBtns)
            {
                this._nextPageBtn.isMinimize = _loc3_;
                this._nextPageBtn.width = _loc3_?NAV_BUTTON_MIN_WIDTH:NAV_BUTTON_WIDTH;
                if(!_loc3_)
                {
                    _loc4_ = this._pageButtons.getProviderRealLength() - (this._currentPageIndex + 1) * this._maxElementsPerPage;
                    _loc4_ = _loc4_ > this._maxElementsPerPage?this._maxElementsPerPage:_loc4_;
                    this._nextPageBtn.label = this._locale.makeString(QUESTS.MISSIONDETAILS_NEXTPAGEBTN_LABEL) + " " + _loc4_;
                }
                this._prevPageBtn.isMinimize = _loc3_;
                this._prevPageBtn.width = _loc3_?NAV_BUTTON_MIN_WIDTH:NAV_BUTTON_WIDTH;
                if(!_loc3_)
                {
                    this._prevPageBtn.label = this._locale.makeString(QUESTS.MISSIONDETAILS_PREVPAGEBTN_LABEL) + " " + this._maxElementsPerPage;
                }
            }
        }

        protected function gatButtonByIndex(param1:int) : Button
        {
            var _loc2_:int = this._pageButtons.getRendererIndex(param1);
            return this._buttonGroup.getButtonAt(_loc2_);
        }

        protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(this.afterArrowClickCallback);
            this.removeListeners();
            this._locale = null;
            this.clearPagesBtns();
            this._holder = null;
            this._pagesData = null;
            this._arrowLeftBtn = null;
            this._arrowRightBtn = null;
            this._pageButtons = null;
            this._buttonGroup = null;
        }

        protected function showArrowTooltip(param1:int) : void
        {
        }

        protected function arrowRightBtnClickHandler() : void
        {
            this.setPageIndex(this._currentMissionIndex + 1);
        }

        protected function arrowLeftBtnClickHandler() : void
        {
            this.setPageIndex(this._currentMissionIndex - 1);
        }

        protected function getPageDataByIdx(param1:int) : Object
        {
            return this._pagesData[param1];
        }

        protected function getFirstMissionIndex() : int
        {
            return 0;
        }

        protected function getLastMissionIndex() : int
        {
            return this._pagesData.length - 1;
        }

        private function updatePagesBtn() : void
        {
            if(this._maxPagesLen > 1)
            {
                if(!this._prevPageBtn)
                {
                    this._prevPageBtn = App.utils.classFactory.getComponent(Linkages.PAGINATOR_PAGE_SHIFT_BTN,PaginationPageButton);
                    this._prevPageBtn.addEventListener(ButtonEvent.CLICK,this.onPrevPageBtnClickHandler);
                    this._prevPageBtn.setImage(RES_ICONS.MAPS_ICONS_LIBRARY_ARROW_NAV_LEFT);
                    this._prevPageBtn.name = TO_PREV_PAGE_BTN_NAME;
                    this._holder.addChild(this._prevPageBtn);
                }
                if(!this._nextPageBtn)
                {
                    this._nextPageBtn = App.utils.classFactory.getComponent(Linkages.PAGINATOR_PAGE_SHIFT_BTN,PaginationPageButton);
                    this._nextPageBtn.addEventListener(ButtonEvent.CLICK,this.onNextPageBtnClickHandler);
                    this._nextPageBtn.setImage(RES_ICONS.MAPS_ICONS_LIBRARY_ARROW_NAV_RIGHT);
                    this._nextPageBtn.name = TO_NEXT_PAGE_BTN_NAME;
                    this._holder.addChild(this._nextPageBtn);
                }
                this._hasPagesBtns = true;
                this.layoutPageBtns();
            }
            else
            {
                this.clearPagesBtns();
                this._hasPagesBtns = false;
            }
        }

        private function layoutPageBtns() : void
        {
            if(this._hasPagesBtns)
            {
                this._prevPageBtn.x = this._pageButtons.x - this._prevPageBtn.width - PAGE_BUTTON_LEFT_X_SHIFT | 0;
                this._nextPageBtn.x = this._pageButtons.x + this._pageButtons.width + PAGE_BUTTON_RIGHT_X_SHIFT | 0;
                this._nextPageBtn.y = this._prevPageBtn.y = this._pageButtons.y + PAGE_BUTTONS_Y_SHIFT | 0;
            }
        }

        private function clearPagesBtns() : void
        {
            if(this._prevPageBtn)
            {
                this._prevPageBtn.removeEventListener(ButtonEvent.CLICK,this.onPrevPageBtnClickHandler);
                this._holder.removeChild(this._prevPageBtn);
                this._prevPageBtn.dispose();
                this._prevPageBtn = null;
            }
            if(this._nextPageBtn)
            {
                this._nextPageBtn.removeEventListener(ButtonEvent.CLICK,this.onNextPageBtnClickHandler);
                this._holder.removeChild(this._nextPageBtn);
                this._nextPageBtn.dispose();
                this._nextPageBtn = null;
            }
        }

        private function switchPage(param1:int, param2:int) : void
        {
            var _loc3_:Button = null;
            var _loc4_:Button = null;
            if(this._currentPageIndex != param1 && param1 >= 0 && param1 < this._maxPagesLen)
            {
                this._currentPageIndex = param1;
                _loc3_ = this._buttonGroup.selectedButton;
                if(param2 == Values.DEFAULT_INT)
                {
                    var param2:int = this._currentPageIndex * this._maxElementsPerPage;
                }
                this._pageButtons.ensureIndexVisible(param2);
                this._pageButtons.validateNow();
                this._currentMissionIndex = param2;
                this.onPageUpdate();
                _loc4_ = this._buttonGroup.selectedButton;
                if(_loc3_ == _loc4_)
                {
                    this.onMissionHasChanged();
                }
            }
        }

        private function onPageUpdate() : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            if(this._pagesData.length > this._currentMissionIndex)
            {
                _loc2_ = this._buttonGroup.length;
                _loc3_ = 0;
                while(_loc3_ != _loc2_)
                {
                    Button(this._buttonGroup.getButtonAt(_loc3_)).invalidateState();
                    _loc3_++;
                }
            }
            var _loc1_:int = this._pageButtons.getRendererIndex(this._currentMissionIndex);
            this._buttonGroup.setSelectedButtonByIndex(_loc1_);
        }

        private function updateControlsStates() : void
        {
            var _loc1_:* = false;
            this._arrowLeftBtn.enabled = this._currentMissionIndex > this.getFirstMissionIndex();
            this._arrowRightBtn.enabled = this._currentMissionIndex < this.getLastMissionIndex();
            if(this._hideDisabledArrows)
            {
                _loc1_ = this._pagesData.length > 0;
                this._arrowLeftBtn.visible = this._arrowLeftBtn.enabled && _loc1_;
                this._arrowRightBtn.visible = this._arrowRightBtn.enabled && _loc1_;
            }
            if(this._hasPagesBtns)
            {
                this._nextPageBtn.visible = this._currentPageIndex + 1 < this._maxPagesLen;
                this._prevPageBtn.visible = this._currentPageIndex > 0;
            }
        }

        private function removeListeners() : void
        {
            this._pageButtons.removeEventListener(PaginationGroupEvent.GROUP_CHANGED,this.onPageButtonsGroupChangedHandler);
            this._arrowLeftBtn.removeEventListener(ButtonEvent.CLICK,this.onArrowLeftBtnClickHandler);
            this._arrowRightBtn.removeEventListener(ButtonEvent.CLICK,this.onArrowRightBtnClickHandler);
            this._buttonGroup.removeEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
            this._arrowLeftBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
            this._arrowRightBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
            this._arrowLeftBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
            this._arrowRightBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
        }

        private function onArrowClick(param1:ISoundButtonEx) : void
        {
            App.utils.scheduler.scheduleTask(this.afterArrowClickCallback,AFTER_ARROW_CLICK_CALL_CALLBACK_DELAY,param1);
        }

        private function afterArrowClickCallback(param1:ISoundButtonEx) : void
        {
            var _loc2_:Boolean = param1.hitTestPoint(App.stage.mouseX,App.stage.mouseY,true);
            if(_loc2_)
            {
                this.onArrowRollOver(param1);
            }
        }

        private function onArrowRollOver(param1:ISoundButtonEx) : void
        {
            var _loc2_:* = 0;
            if(this.allowPageChange)
            {
                if(param1.enabled)
                {
                    _loc2_ = this._currentMissionIndex + (param1 == this._arrowLeftBtn?-1:1);
                    if(_loc2_ >= 0 && _loc2_ < this._pagesData.length)
                    {
                        this.showArrowTooltip(_loc2_);
                    }
                }
            }
        }

        private function onMissionHasChanged() : void
        {
            this.updateControlsStates();
            dispatchEvent(new Event(Event.CHANGE));
        }

        private function onPageButtonsGroupChangedHandler(param1:PaginationGroupEvent) : void
        {
            this.updatePagesBtn();
        }

        private function onNextPageBtnClickHandler(param1:ButtonEvent) : void
        {
            this.switchPage(this._currentPageIndex + 1,Values.DEFAULT_INT);
        }

        private function onPrevPageBtnClickHandler(param1:ButtonEvent) : void
        {
            this.switchPage(this._currentPageIndex - 1,Values.DEFAULT_INT);
        }

        private function onArrowRightBtnClickHandler(param1:ButtonEvent) : void
        {
            if(this.allowPageChange && this._arrowRightBtn.enabled)
            {
                this.onArrowClick(ISoundButtonEx(param1.target));
                this.arrowRightBtnClickHandler();
            }
        }

        private function onArrowLeftBtnClickHandler(param1:ButtonEvent) : void
        {
            if(this.allowPageChange && this._arrowLeftBtn.enabled)
            {
                this.onArrowClick(ISoundButtonEx(param1.target));
                this.arrowLeftBtnClickHandler();
            }
        }

        private function onArrowMouseRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.target);
            this.onArrowRollOver(_loc2_);
        }

        private function onArrowMouseRollOutHandler(param1:MouseEvent) : void
        {
            App.utils.scheduler.cancelTask(this.afterArrowClickCallback);
        }

        private function onButtonGroupChangeHandler(param1:Event) : void
        {
            if(this.allowPageChange)
            {
                this.setPageIndex(PaginationDetailsNumButton(this._buttonGroup.selectedButton).pageIndex);
                this.onMissionHasChanged();
            }
            else
            {
                this.setPageIndex(this._currentMissionIndex);
            }
        }
    }
}
