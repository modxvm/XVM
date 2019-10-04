package net.wg.gui.lobby.vehiclePreview.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanel;
    import flash.display.Sprite;
    import net.wg.gui.components.advanced.ButtonBarEx;
    import net.wg.gui.components.controls.ResizableScrollPane;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.components.advanced.ViewStack;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoPanelVO;
    import net.wg.gui.events.ViewStackEvent;
    import scaleform.clik.events.ComponentEvent;
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanelTab;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.vehiclePreview.events.VehPreviewInfoPanelEvent;

    public class VehPreviewInfoPanel extends UIComponentEx implements IVehPreviewInfoPanel
    {

        private static const SCROLL_STEP_FACTOR:Number = 10;

        private static const SCROLL_PANE_DEFAULT_X:int = 19;

        private static const SCROLL_PANE_WITH_BAR_X:int = 42;

        private static const MIN_BACKGROUND_HEIGHT:int = 244;

        private static const BACKGROUND_OFFSET:int = 230;

        private static const INV_CURRENT_VIEW:String = "invCurrentView";

        public var background:Sprite;

        public var tabButtonBar:ButtonBarEx;

        public var scrollPane:ResizableScrollPane;

        public var scrollBar:ScrollBar;

        private var _tabViewStack:ViewStack;

        private var _data:VehPreviewInfoPanelVO;

        public function VehPreviewInfoPanel()
        {
            super();
            this._tabViewStack = ViewStack(this.scrollPane.target);
            this._tabViewStack.cache = true;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._tabViewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onTabViewStackViewChangedHandler);
            this.scrollBar.addEventListener(ComponentEvent.SHOW,this.onScrollBarShowHandler);
            this.scrollBar.addEventListener(ComponentEvent.HIDE,this.onScrollBarHideHandler);
            mouseEnabled = false;
            this.background.mouseEnabled = this.background.mouseChildren = false;
            this.scrollPane.scrollBar = this.scrollBar;
            this.scrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
            this._tabViewStack.groupRef = this.tabButtonBar;
        }

        override protected function onBeforeDispose() : void
        {
            this._tabViewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onTabViewStackViewChangedHandler);
            this.scrollBar.removeEventListener(ComponentEvent.SHOW,this.onScrollBarShowHandler);
            this.scrollBar.removeEventListener(ComponentEvent.HIDE,this.onScrollBarHideHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._tabViewStack = null;
            this.background = null;
            this.tabButtonBar.dispose();
            this.tabButtonBar = null;
            this.scrollPane.dispose();
            this.scrollPane = null;
            this.scrollBar.dispose();
            this.scrollBar = null;
            this._data = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc2_:DAAPIDataClass = null;
            var _loc3_:IVehPreviewInfoPanelTab = null;
            var _loc4_:* = 0;
            var _loc5_:* = NaN;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            super.draw();
            var _loc1_:IViewStackContent = this._tabViewStack.currentView;
            if(_loc1_ != null)
            {
                if(isInvalid(INV_CURRENT_VIEW))
                {
                    _loc2_ = this.getSelectedTabData();
                    _loc1_.update(_loc2_);
                    invalidateSize();
                }
                if(isInvalid(InvalidationType.SIZE))
                {
                    _loc3_ = IVehPreviewInfoPanelTab(_loc1_);
                    _loc4_ = height;
                    _loc5_ = this.scrollPane.y;
                    _loc6_ = _loc5_ + _loc3_.height + _loc3_.bottomMargin;
                    if(_loc6_ > _loc4_)
                    {
                        _loc6_ = _loc4_;
                    }
                    else if(_loc6_ < MIN_BACKGROUND_HEIGHT)
                    {
                        _loc6_ = MIN_BACKGROUND_HEIGHT;
                    }
                    _loc7_ = _loc6_ - _loc5_ + _loc3_.bottomMargin;
                    this.scrollPane.height = _loc7_;
                    this.scrollBar.height = _loc7_;
                    this.background.height = _loc5_ + _loc7_ + BACKGROUND_OFFSET;
                    this.setScrollPaneOffset();
                }
            }
        }

        public function update(param1:Object) : void
        {
            this._data = VehPreviewInfoPanelVO(param1);
            this.tabButtonBar.selectedIndex = this._data.selectedTab;
            invalidate(INV_CURRENT_VIEW);
        }

        public function updateTabButtonsData(param1:DataProvider) : void
        {
            this.tabButtonBar.dataProvider = param1;
        }

        private function getSelectedTabData() : DAAPIDataClass
        {
            var _loc1_:int = this.tabButtonBar.selectedIndex;
            App.utils.asserter.assert(_loc1_ >= 0 && _loc1_ < this._data.tabData.length,"Invalid selected index.");
            return this._data.tabData[_loc1_].voData;
        }

        private function setScrollPaneOffset() : void
        {
            this.scrollPane.x = this.scrollBar.visible?SCROLL_PANE_WITH_BAR_X:SCROLL_PANE_DEFAULT_X;
        }

        private function onScrollBarShowHandler(param1:ComponentEvent) : void
        {
            this.setScrollPaneOffset();
        }

        private function onScrollBarHideHandler(param1:ComponentEvent) : void
        {
            this.setScrollPaneOffset();
        }

        private function onTabViewStackViewChangedHandler(param1:ViewStackEvent) : void
        {
            dispatchEvent(new VehPreviewInfoPanelEvent(VehPreviewInfoPanelEvent.INFO_TAB_CHANGED,this.tabButtonBar.selectedIndex,true));
            invalidate(INV_CURRENT_VIEW);
        }
    }
}
