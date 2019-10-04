package net.wg.gui.lobby.storage
{
    import net.wg.infrastructure.base.meta.impl.StorageViewMeta;
    import net.wg.infrastructure.base.meta.IStorageViewMeta;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.gui.lobby.components.SideBar;
    import net.wg.gui.components.advanced.ViewStackEx;
    import net.wg.gui.lobby.storage.categories.NoItemsView;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import net.wg.gui.events.ViewStackEvent;
    import flash.events.Event;
    import net.wg.gui.lobby.storage.categories.ICategory;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.storage.data.StorageVO;
    import net.wg.utils.StageSizeBoundaries;
    import net.wg.data.constants.Linkages;
    import net.wg.infrastructure.interfaces.IDAAPIModule;

    public class StorageView extends StorageViewMeta implements IStorageViewMeta, IStageSizeDependComponent
    {

        private static const HIT_AREA_NAME:String = "hitArea";

        private static const MENU_SIZE_FLAG:String = "menuSizeFlag";

        private static const SMALL_CONTENT_V_OFFSET:int = 66;

        private static const BIG_CONTENT_V_OFFSET:int = 88;

        public var menu:SideBar;

        public var content:ViewStackEx;

        public var noItemsView:NoItemsView;

        private var _hitArea:Sprite;

        public function StorageView()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            setSize(param1,param2);
            this.menu.height = height;
            this.content.setSize(width - this.content.x,height - this.content.y);
            var _loc3_:Graphics = this._hitArea.graphics;
            _loc3_.clear();
            _loc3_.beginFill(16711680,0);
            _loc3_.drawRect(0,0,param1,param2);
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._hitArea = new Sprite();
            this._hitArea.name = HIT_AREA_NAME;
            addChildAt(this._hitArea,0);
            this.content.addEventListener(ViewStackEvent.NEED_UPDATE,this.onContentNeedUpdateHandler);
            this.menu.addEventListener(Event.RESIZE,this.onMenuResizeHandler);
            this.noItemsView.setTexts(STORAGE.NOTAVAILABLE_TITLE,STORAGE.NOTAVAILABLE_NAVIGATIONBUTTON);
            this.noItemsView.addEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
            App.stageSizeMgr.register(this);
        }

        override protected function onDispose() : void
        {
            this.menu.removeEventListener(Event.RESIZE,this.onMenuResizeHandler);
            this.menu.dispose();
            this.menu = null;
            this.content.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onContentNeedUpdateHandler);
            this.content.dispose();
            this.content = null;
            this.noItemsView.removeEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
            this.noItemsView.dispose();
            this.noItemsView = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:ICategory = null;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.noItemsView.width = width;
                this.noItemsView.validateNow();
                this.noItemsView.y = height - this.noItemsView.actualHeight >> 1;
                invalidate(MENU_SIZE_FLAG);
            }
            if(this.content.currentView && isInvalid(MENU_SIZE_FLAG))
            {
                _loc1_ = ICategory(this.content.currentView);
                this.menu.x = (this.content.x + width - _loc1_.contentWidth >> 1) - this.menu.width >> 1;
            }
        }

        override protected function setData(param1:StorageVO) : void
        {
            if(param1.showDummyScreen)
            {
                this.noItemsView.visible = true;
                this.menu.visible = false;
                this.content.visible = false;
            }
            else
            {
                this.noItemsView.visible = false;
                this.content.visible = true;
                this.menu.visible = true;
                this.menu.dataProvider = param1.sections;
            }
            setBackground(param1.bgSource);
            this.updateStage(width,height);
        }

        override protected function onEscapeKeyDown() : void
        {
            super.onEscapeKeyDown();
            onCloseS();
        }

        override protected function onCloseBtn() : void
        {
            super.onCloseBtn();
            onCloseS();
        }

        public function as_selectSection(param1:int) : void
        {
            this.menu.selectedIndex = param1;
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            if(param1 == StageSizeBoundaries.WIDTH_1024)
            {
                this.menu.y = this.content.y = SMALL_CONTENT_V_OFFSET;
                this.menu.itemRendererName = Linkages.SIDE_BAR_SMALL_RENDERER;
            }
            else
            {
                this.menu.y = this.content.y = BIG_CONTENT_V_OFFSET;
                this.menu.itemRendererName = Linkages.SIDE_BAR_NORMAL_RENDERER;
            }
        }

        private function onContentNeedUpdateHandler(param1:ViewStackEvent) : void
        {
            var _loc2_:ICategory = ICategory(param1.view);
            _loc2_.setHitArea(this._hitArea);
            registerFlashComponentS(IDAAPIModule(_loc2_),param1.viewId);
        }

        private function onMenuResizeHandler(param1:Event) : void
        {
            invalidate(MENU_SIZE_FLAG);
        }

        private function onNoItemViewCloseHandler(param1:Event) : void
        {
            navigateToHangarS();
        }
    }
}
