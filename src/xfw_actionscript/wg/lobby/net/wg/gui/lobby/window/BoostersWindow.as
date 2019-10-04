package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.BoostersWindowMeta;
    import net.wg.infrastructure.base.meta.IBoostersWindowMeta;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import net.wg.gui.lobby.components.InfoMessageComponent;
    import net.wg.gui.components.advanced.ContentTabBar;
    import net.wg.gui.components.controls.SortableTable;
    import net.wg.gui.lobby.components.BoostersPanel;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.boosters.components.BoostersWindowFilters;
    import net.wg.gui.lobby.boosters.data.BoostersWindowVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.IndexEvent;
    import net.wg.gui.lobby.boosters.events.BoostersWindowEvent;
    import net.wg.gui.events.FiltersEvent;
    import net.wg.data.Aliases;
    import net.wg.gui.components.controls.events.SlotsPanelEvent;
    import net.wg.gui.lobby.boosters.data.BoostersWindowStaticVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;

    public class BoostersWindow extends BoostersWindowMeta implements IBoostersWindowMeta
    {

        private static const TAB_MIN_WIDTH:int = 150;

        public var closeBtn:SoundButtonEx = null;

        public var activeTF:TextField = null;

        public var noInfoCmp:InfoMessageComponent = null;

        public var tabs:ContentTabBar = null;

        public var boostersList:SortableTable = null;

        public var boostersPanel:BoostersPanel = null;

        public var noInfoBg:UILoaderAlt = null;

        public var boosterFilters:BoostersWindowFilters;

        private var _model:BoostersWindowVO = null;

        public function BoostersWindow()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.tabs.minRendererWidth = TAB_MIN_WIDTH;
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
            this.boostersList.addEventListener(BoostersWindowEvent.BOOSTER_ACTION_BTN_CLICK,this.onBoostersListBoosterActionBtnClickHandler);
            this.boosterFilters.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onBoosterFiltersFiltersChangedHandler);
            this.noInfoCmp.addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onNoInfoCmpResetAllFiltersHandler);
            registerFlashComponentS(this.boostersPanel,Aliases.BOOSTERS_PANEL);
            this.boostersPanel.addEventListener(SlotsPanelEvent.NEED_REPOSITION,this.onBoostersPanelNeedRepositionHandler);
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.useBottomBtns = true;
        }

        override protected function onDispose() : void
        {
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
            this.boostersList.removeEventListener(BoostersWindowEvent.BOOSTER_ACTION_BTN_CLICK,this.onBoostersListBoosterActionBtnClickHandler);
            this.boostersPanel.removeEventListener(SlotsPanelEvent.NEED_REPOSITION,this.onBoostersPanelNeedRepositionHandler);
            this.boosterFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onBoosterFiltersFiltersChangedHandler);
            this.noInfoCmp.removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onNoInfoCmpResetAllFiltersHandler);
            this.closeBtn.dispose();
            this.closeBtn = null;
            this.activeTF = null;
            this.noInfoCmp.dispose();
            this.noInfoCmp = null;
            this.tabs.dispose();
            this.tabs = null;
            this.boostersList.dispose();
            this.boostersList = null;
            this.noInfoBg.dispose();
            this.noInfoBg = null;
            this.boosterFilters.dispose();
            this.boosterFilters = null;
            this.boostersPanel = null;
            this._model = null;
            super.onDispose();
        }

        override protected function setData(param1:BoostersWindowVO) : void
        {
            if(param1 != null)
            {
                this._model = param1;
                this.tabs.dataProvider = this._model.tabsLabels;
                this.tabs.selectedIndex = this._model.tabIndex;
                invalidateData();
            }
        }

        override protected function setStaticData(param1:BoostersWindowStaticVO) : void
        {
            window.title = param1.windowTitle;
            this.closeBtn.label = param1.closeBtnLabel;
            this.noInfoBg.source = param1.noInfoBgSource;
            this.boosterFilters.setData(param1.filtersData);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._model && isInvalid(InvalidationType.DATA))
            {
                this.activeTF.htmlText = this._model.activeText;
                this.noInfoBg.visible = this._model.isHaveNotInfo;
                this.noInfoCmp.setData(this._model.noInfoData);
                this.noInfoCmp.visible = this._model.isHaveNotInfo;
                if(this._model.isHaveNotInfo)
                {
                    this.noInfoCmp.x = width - this.noInfoCmp.width >> 1;
                    this.noInfoCmp.y = this.boostersList.y + (this.boostersList.height - this.noInfoCmp.height >> 1);
                }
                if(this._model.filterState >= 0)
                {
                    this.boosterFilters.resetFilters(this._model.filterState);
                }
            }
        }

        override protected function setListData(param1:DataProvider, param2:Boolean) : void
        {
            this.boostersList.listDP = param1;
            if(param2)
            {
                this.boostersList.listSelectedIndex = 0;
            }
        }

        private function onBoosterFiltersFiltersChangedHandler(param1:FiltersEvent) : void
        {
            onFiltersChangeS(param1.filtersValue);
        }

        private function onCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }

        private function onTabIndexChangeHandler(param1:IndexEvent) : void
        {
            requestBoostersArrayS(param1.index);
        }

        private function onBoostersListBoosterActionBtnClickHandler(param1:BoostersWindowEvent) : void
        {
            onBoosterActionBtnClickS(param1.boosterID,param1.questID);
        }

        private function onNoInfoCmpResetAllFiltersHandler(param1:FiltersEvent) : void
        {
            onResetFiltersS();
        }

        private function onBoostersPanelNeedRepositionHandler(param1:SlotsPanelEvent) : void
        {
            this.boostersPanel.x = this.width - this.boostersPanel.actualWidth >> 1;
        }
    }
}
