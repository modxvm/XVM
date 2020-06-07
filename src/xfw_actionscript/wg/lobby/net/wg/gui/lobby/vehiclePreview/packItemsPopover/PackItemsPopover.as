package net.wg.gui.lobby.vehiclePreview.packItemsPopover
{
    import net.wg.infrastructure.base.meta.impl.PackItemsPopoverMeta;
    import net.wg.infrastructure.base.meta.IPackItemsPopoverMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.EmptyItemsScrollingList;
    import flash.display.MovieClip;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.InteractiveObject;
    import net.wg.gui.components.popovers.PopOverConst;
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.gui.components.popovers.PopOver;

    public class PackItemsPopover extends PackItemsPopoverMeta implements IPackItemsPopoverMeta
    {

        private static const LIST_BOTTOM_MARGIN:int = 2;

        private static const BOTTOM_PADDING:int = 22;

        private static const MAX_ITEMS:int = 7;

        public var titleTf:TextField = null;

        public var itemsList:EmptyItemsScrollingList = null;

        public var bottomSeparator:MovieClip = null;

        public var topSeparator:MovieClip = null;

        public function PackItemsPopover()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.titleTf.autoSize = TextFieldAutoSize.LEFT;
            this.setEmptyHitArea(this.topSeparator);
            this.setEmptyHitArea(this.bottomSeparator);
        }

        override protected function setItems(param1:String, param2:DataProvider) : void
        {
            this.titleTf.htmlText = param1;
            this.itemsList.height = this.itemsList.rowHeight * Math.min(param2.length,MAX_ITEMS);
            this.itemsList.dataProvider = param2;
            invalidateSize();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = this.itemsList.y + this.itemsList.height;
                this.bottomSeparator.y = _loc1_ + (this.bottomSeparator.height >> 1) + LIST_BOTTOM_MARGIN;
                height = _loc1_ + BOTTOM_PADDING;
            }
        }

        override protected function onDispose() : void
        {
            this.titleTf = null;
            this.itemsList.dispose();
            this.itemsList = null;
            this.bottomSeparator.hitArea = null;
            this.bottomSeparator = null;
            this.topSeparator.hitArea = null;
            this.topSeparator = null;
            super.onDispose();
        }

        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.itemsList);
        }

        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
            super.initLayout();
        }

        private function setEmptyHitArea(param1:Sprite) : void
        {
            var _loc2_:Sprite = new Sprite();
            addChild(_loc2_);
            param1.hitArea = _loc2_;
        }

        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            PopOver(param1).isCloseBtnVisible = true;
        }
    }
}
