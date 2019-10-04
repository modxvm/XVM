package net.wg.gui.lobby.storage.categories.storage
{
    import net.wg.infrastructure.base.meta.impl.StorageCategoryStorageViewMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryStorageViewMeta;
    import net.wg.infrastructure.interfaces.IViewStackExContent;
    import net.wg.gui.lobby.storage.categories.ICategory;
    import flash.text.TextField;
    import net.wg.gui.components.controls.tabs.OrangeTabMenu;
    import net.wg.gui.components.advanced.ViewStackEx;
    import flash.display.Sprite;
    import net.wg.gui.events.ViewStackEvent;
    import scaleform.clik.events.IndexEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import flash.display.InteractiveObject;
    import net.wg.gui.components.controls.tabs.OrangeTabsMenuVO;
    import net.wg.infrastructure.interfaces.IDAAPIModule;

    public class StorageCategoryStorageView extends StorageCategoryStorageViewMeta implements IStorageCategoryStorageViewMeta, IViewStackExContent, ICategory
    {

        public var title:TextField;

        public var tabButtonBar:OrangeTabMenu = null;

        public var content:ViewStackEx;

        private var _hitArea:Sprite;

        public function StorageCategoryStorageView()
        {
            super();
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1,param2);
            this.content.setSize(param1 - this.content.x,param2 - this.content.y);
            this.tabButtonBar.width = param1 - this.content.x;
            this.tabButtonBar.validateNow();
        }

        override protected function onDispose() : void
        {
            this.content.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onContentNeedUpdateHandler);
            this.content.dispose();
            this.content = null;
            this.tabButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabButtonBarIndexChangeHandler);
            this.tabButtonBar.dispose();
            this.tabButtonBar = null;
            this.title = null;
            this._hitArea = null;
            super.onDispose();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.tabButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabButtonBarIndexChangeHandler);
            this.content.addEventListener(ViewStackEvent.NEED_UPDATE,this.onContentNeedUpdateHandler);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.title.autoSize = TextFieldAutoSize.LEFT;
            this.title.text = STORAGE.STORAGE_SECTIONTITLE;
            this.title.mouseWheelEnabled = this.title.mouseEnabled = false;
            this.tabButtonBar.autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function draw() : void
        {
            var _loc1_:ICategory = null;
            super.draw();
            if(this.content.currentView && isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = ICategory(this.content.currentView);
                this.title.x = this.tabButtonBar.x = width - _loc1_.contentWidth >> 1;
            }
        }

        override protected function setTabsData(param1:DataProvider) : void
        {
            this.tabButtonBar.dataProvider = param1;
        }

        public function canShowAutomatically() : Boolean
        {
            return true;
        }

        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }

        public function setActive(param1:Boolean) : void
        {
        }

        public function setHitArea(param1:Sprite) : void
        {
            this._hitArea = param1;
            if(this.content.currentView)
            {
                ICategory(this.content.currentView).setHitArea(this._hitArea);
            }
        }

        public function update(param1:Object) : void
        {
        }

        public function get contentWidth() : int
        {
            return this.content.currentView?ICategory(this.content.currentView).contentWidth:0;
        }

        private function onTabButtonBarIndexChangeHandler(param1:IndexEvent) : void
        {
            var _loc2_:OrangeTabsMenuVO = OrangeTabsMenuVO(param1.data);
            onOpenTabS(_loc2_.id);
        }

        private function onContentNeedUpdateHandler(param1:ViewStackEvent) : void
        {
            if(this._hitArea)
            {
                ICategory(param1.view).setHitArea(this._hitArea);
            }
            registerFlashComponentS(IDAAPIModule(param1.view),param1.viewId);
        }
    }
}
