package net.wg.gui.lobby.storage.categories.inhangar
{
    import net.wg.infrastructure.base.meta.impl.StorageCategoryInHangarViewMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryInHangarViewMeta;
    import net.wg.infrastructure.interfaces.IViewStackExContent;
    import net.wg.gui.lobby.storage.categories.ICategory;
    import flash.text.TextField;
    import net.wg.gui.components.controls.tabs.OrangeTabMenu;
    import net.wg.gui.components.advanced.ViewStackEx;
    import flash.display.Sprite;
    import net.wg.gui.events.ViewStackEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.IDAAPIModule;

    public class StorageCategoryInHangarView extends StorageCategoryInHangarViewMeta implements IStorageCategoryInHangarViewMeta, IViewStackExContent, ICategory
    {

        public var title:TextField;

        public var tabButtonBar:OrangeTabMenu = null;

        public var content:ViewStackEx;

        private var _hitArea:Sprite;

        public function StorageCategoryInHangarView()
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
            this.tabButtonBar.dispose();
            this.tabButtonBar = null;
            this.title = null;
            this._hitArea = null;
            super.onDispose();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.content.addEventListener(ViewStackEvent.NEED_UPDATE,this.onContentNeedUpdateHandler);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.title.autoSize = TextFieldAutoSize.LEFT;
            this.title.text = STORAGE.INHANGAR_SECTIONTITLE;
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
                this.title.x = width - _loc1_.contentWidth >> 1;
                this.tabButtonBar.x = this.title.x;
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
            setActiveStateS(param1);
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
