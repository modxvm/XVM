package net.wg.gui.battle.windows
{
    import net.wg.infrastructure.base.meta.impl.IngameDetailsHelpWindowMeta;
    import net.wg.infrastructure.base.meta.IIngameDetailsHelpWindowMeta;
    import scaleform.clik.utils.Padding;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.gui.components.paginator.PaginatorArrowBtn;
    import net.wg.gui.components.paginator.PaginationGroup;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.battle.windows.vo.IngameDetailsHelpVO;
    import net.wg.gui.battle.windows.vo.IngameDetailsPageVO;
    import net.wg.gui.components.interfaces.IPaginatorArrowsController;
    import net.wg.gui.components.hintPanel.KeyViewersList;
    import net.wg.infrastructure.interfaces.IWindow;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import net.wg.gui.components.windows.WindowEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
    import net.wg.infrastructure.constants.WindowViewInvalidationType;
    import net.wg.data.constants.InvalidationType;
    import net.wg.gui.components.paginator.PaginatorArrowsController;
    import net.wg.data.constants.Values;
    import flash.geom.Point;
    import net.wg.gui.components.paginator.PaginationDetailsNumButton;

    public class IngameDetailsHelpWindow extends IngameDetailsHelpWindowMeta implements IIngameDetailsHelpWindowMeta
    {

        private static const DETAILS_HELP_PAGE_GROUP:String = "DetailsHelpPageGroup";

        private static const INV_PAGE:String = "InvPage";

        private static const INV_PAGE_SIZE:String = "InvPageSize";

        private static const MIN_PAGES:int = 1;

        private static const WINDOW_HEIGHT:int = 720;

        private static const FOOTER_HEIGHT:int = 60;

        private static const DESCRIPTION_PADDING_BOTTOM:int = 30;

        private static const TEXT_BASELINE_PADDING:int = 6;

        private static const KEYS_PADDING:int = 63;

        private static const WARNING_MARGIN_TOP:int = 27;

        private static const KEY_BOTTOM:int = 25;

        private static const PAGE_TITLE_BOTTOM:int = 15;

        private static const ARROWS_PADDING_TOP:int = 85;

        private static const PAGINATOR_PADDING_BOTTOM:int = 65;

        private static const WINDOW_PADDING:Padding = new Padding(-70,0,0,0);

        private static const ARROW_HORIZONTAL_GAP:int = 80;

        public var background:BattleAtlasSprite = null;

        public var pgBackground:BattleAtlasSprite = null;

        public var arrowLeftBtn:PaginatorArrowBtn = null;

        public var arrowRightBtn:PaginatorArrowBtn = null;

        public var pageButtons:PaginationGroup = null;

        public var btnClose:ISoundButtonEx = null;

        public var pageBg:UILoaderAlt = null;

        public var title:TextField = null;

        public var pageTitle:TextField = null;

        public var description:TextField = null;

        public var warning:TextField = null;

        private var _currentIndex:int = 0;

        private var _data:IngameDetailsHelpVO = null;

        private var _pageData:IngameDetailsPageVO = null;

        private var _pageController:IPaginatorArrowsController = null;

        private var _keyViewersList:KeyViewersList = null;

        public function IngameDetailsHelpWindow()
        {
            super();
            showWindowBgForm = false;
            showWindowBg = false;
        }

        override public function setWindow(param1:IWindow) : void
        {
            super.setWindow(param1);
            if(window)
            {
                window.contentPadding = WINDOW_PADDING;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.background.imageName = BATTLEATLAS.HELP_WINDOW_BG;
            this.pgBackground.imageName = BATTLEATLAS.HELP_WINDOW_BOTTOM_BG;
            updateStage(App.appWidth,App.appHeight);
            window.addEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleYChangedHandler);
            this.btnClose.label = INGAME_HELP.BATTLECONTROLS_CLOSEBTNLABEL;
            this._pageController = this.createPaginatorController();
            this.btnClose.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
            this._pageController.addEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
            this.warning.text = INGAME_HELP.DETAILSHELP_NOKEYSWARNING;
            this.warning.visible = false;
            this.arrowLeftBtn.focusable = false;
            this.arrowRightBtn.focusable = false;
            this.pageButtons.focusable = false;
            this.btnClose.focusable = false;
            this._keyViewersList = new KeyViewersList();
            addChild(this._keyViewersList);
            this._keyViewersList.y = height - KEY_BOTTOM >> 0;
        }

        override protected function draw() : void
        {
            var _loc1_:DataProvider = null;
            var _loc2_:PaginatorPageNumVO = null;
            var _loc3_:* = 0;
            super.draw();
            if(isInvalid(WindowViewInvalidationType.POSITION_INVALID) && geometry && window)
            {
                window.x = App.appWidth - window.getBackground().width >> 1;
                window.y = App.appHeight - window.getBackground().height >> 1;
            }
            if(this._data != null)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    _loc1_ = this._data.pages;
                    this.title.text = this._data.title;
                    if(_loc1_.length > MIN_PAGES)
                    {
                        this._pageController.setPages(_loc1_);
                        for each(_loc2_ in _loc1_)
                        {
                            if(_loc2_.selected)
                            {
                                this._pageController.setPageIndex(_loc2_.pageIndex);
                                break;
                            }
                        }
                    }
                    requestHelpDataS(this._currentIndex);
                    invalidateSize();
                }
                if(isInvalid(INV_PAGE))
                {
                    _loc3_ = this._data.pages.length;
                    if(_loc3_ > this._currentIndex && this._pageData != null)
                    {
                        this.setData(this._pageData);
                        invalidate(INV_PAGE_SIZE);
                    }
                }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateLayout();
            }
            if(isInvalid(INV_PAGE_SIZE))
            {
                this.updatePageLayout();
            }
        }

        override protected function onDispose() : void
        {
            this.btnClose.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
            this._pageController.removeEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
            window.removeEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleYChangedHandler);
            this.background = null;
            this.pgBackground = null;
            this.pageBg.dispose();
            this.pageBg = null;
            this.btnClose.dispose();
            this.btnClose = null;
            this.title = null;
            this.pageTitle = null;
            this.description = null;
            this.warning = null;
            this._data = null;
            this._pageData = null;
            removeChild(this._keyViewersList);
            this._keyViewersList.dispose();
            this._keyViewersList = null;
            this._pageController.dispose();
            this._pageController = null;
            this.arrowLeftBtn.dispose();
            this.arrowLeftBtn = null;
            this.arrowRightBtn.dispose();
            this.arrowRightBtn = null;
            this.pageButtons.dispose();
            this.pageButtons = null;
            super.onDispose();
        }

        override protected function setInitData(param1:IngameDetailsHelpVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function setHelpData(param1:IngameDetailsPageVO) : void
        {
            this._pageData = param1;
            invalidate(INV_PAGE);
        }

        override protected function getIngameDetailsHelpVOForData(param1:Object) : IngameDetailsHelpVO
        {
            return new IngameDetailsHelpVO(param1);
        }

        override protected function getIngameDetailsPageVOForData(param1:Object) : IngameDetailsPageVO
        {
            return new IngameDetailsPageVO(param1);
        }

        public function createPaginatorController() : IPaginatorArrowsController
        {
            return new PaginatorArrowsController(this,this.pageButtons,this.arrowLeftBtn,this.arrowRightBtn,DETAILS_HELP_PAGE_GROUP,Values.ZERO,true);
        }

        private function updateLayout() : void
        {
            this.arrowLeftBtn.x = x - this.arrowLeftBtn.width + ARROW_HORIZONTAL_GAP >> 0;
            this.arrowRightBtn.x = x + width + this.arrowLeftBtn.width - ARROW_HORIZONTAL_GAP >> 0;
            this.arrowLeftBtn.y = this.arrowRightBtn.y = this.background.y + ARROWS_PADDING_TOP;
            var _loc1_:Point = new Point(x + (width >> 1),this.background.y + height + PAGINATOR_PADDING_BOTTOM);
            this._pageController.setPositions(_loc1_);
        }

        private function updatePageLayout() : void
        {
            App.utils.commons.updateTextFieldSize(this.description,false,true);
            var _loc1_:int = WINDOW_HEIGHT - FOOTER_HEIGHT - DESCRIPTION_PADDING_BOTTOM;
            if(this._keyViewersList.visible || this.warning.visible)
            {
                _loc1_ = _loc1_ - KEYS_PADDING;
            }
            this.description.y = _loc1_ - this.description.height + TEXT_BASELINE_PADDING >> 0;
            this.pageTitle.y = this.description.y - this.title.height - PAGE_TITLE_BOTTOM >> 0;
            this.warning.y = this.description.y + this.description.height + WARNING_MARGIN_TOP >> 0;
        }

        private function setData(param1:IngameDetailsPageVO) : void
        {
            var _loc2_:Array = null;
            var _loc3_:* = false;
            this.description.text = param1.descr;
            this.pageTitle.text = param1.title;
            this.pageBg.source = param1.image;
            _loc2_ = param1.buttons;
            _loc3_ = _loc2_.indexOf(Values.EMPTY_STR) > -1;
            this._keyViewersList.clearKeys();
            this._keyViewersList.visible = _loc2_.length > 0;
            this.warning.visible = _loc3_;
            if(!_loc3_)
            {
                this._keyViewersList.setKeys(_loc2_);
                this._keyViewersList.x = width - this._keyViewersList.width >> 1;
            }
        }

        private function onWindowScaleYChangedHandler(param1:WindowEvent) : void
        {
            invalidate(WindowViewInvalidationType.POSITION_INVALID);
        }

        private function onBtnCloseClickHandler(param1:ButtonEvent) : void
        {
            handleWindowClose();
        }

        private function onPageControllerChangeHandler(param1:Event) : void
        {
            this._currentIndex = PaginationDetailsNumButton(this._pageController.getSelectedButton()).pageIndex;
            requestHelpDataS(this._currentIndex);
        }
    }
}
