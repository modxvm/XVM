package net.wg.gui.lobby.rankedBattles19.view
{
    import net.wg.infrastructure.base.meta.impl.RankedBattlesDivisionsViewMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesDivisionsViewMeta;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.gui.lobby.rankedBattles19.components.divisionsContainer.DivisionsContainer;
    import net.wg.gui.components.advanced.ViewStackExPadding;
    import net.wg.gui.lobby.rankedBattles19.data.DivisionsViewVO;
    import scaleform.clik.events.IndexEvent;
    import flash.events.Event;
    import net.wg.gui.events.ViewStackEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.StageSizeBoundaries;
    import scaleform.clik.utils.Padding;
    import net.wg.infrastructure.interfaces.IDAAPIModule;

    public class RankedBattlesDivisionsView extends RankedBattlesDivisionsViewMeta implements IRankedBattlesDivisionsViewMeta, IStageSizeDependComponent
    {

        private static const DIVISIONS_OFFSET:int = 90;

        private static const MIN_CONTENT_HEIGHT:int = 400;

        private static const DIVISION_PADDING_WEIGHT:Number = 0.2;

        private static const DIVISION_PADDING_TOP_MIN:int = 60;

        public var divisionsContainer:DivisionsContainer = null;

        public var content:ViewStackExPadding = null;

        private var _data:DivisionsViewVO = null;

        public function RankedBattlesDivisionsView()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.divisionsContainer.addEventListener(IndexEvent.INDEX_CHANGE,this.onDivisionsIndexChangedHandler);
            this.divisionsContainer.addEventListener(Event.RESIZE,this.onDivisionsContainerResizeHandler);
            this.content.cache = true;
            this.content.targetGroup = this.divisionsContainer.name;
            this.content.isApplyPadding = false;
            this.content.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
            App.stageSizeMgr.register(this);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null)
            {
                if(isInvalid(InvalidationType.SIZE,INV_VIEW_PADDING))
                {
                    this.updateLayoutHorizontal();
                    this.updateLayoutVertical();
                }
            }
        }

        override protected function onDispose() : void
        {
            this.divisionsContainer.removeEventListener(Event.RESIZE,this.onDivisionsContainerResizeHandler);
            this.divisionsContainer.removeEventListener(IndexEvent.INDEX_CHANGE,this.onDivisionsIndexChangedHandler);
            this.divisionsContainer.dispose();
            this.divisionsContainer = null;
            this.content.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onContentViewChangedHandler);
            this.content.dispose();
            this.content = null;
            this._data = null;
            super.onDispose();
        }

        override protected function setData(param1:DivisionsViewVO) : void
        {
            this._data = DivisionsViewVO(param1);
            this.divisionsContainer.setData(this._data.divisions);
            this.divisionsContainer.selectedIndex = this._data.selectedDivisionIdx;
            invalidateSize();
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            this.divisionsContainer.isSmall = param1 < StageSizeBoundaries.WIDTH_1366 || param2 < StageSizeBoundaries.HEIGHT_900;
            invalidateSize();
        }

        private function updateLayoutHorizontal() : void
        {
            this.divisionsContainer.x = width - this.divisionsContainer.width >> 1;
        }

        private function updateLayoutVertical() : void
        {
            var _loc1_:int = height - viewPadding.top - MIN_CONTENT_HEIGHT;
            this.divisionsContainer.y = Math.max(_loc1_ * DIVISION_PADDING_WEIGHT,DIVISION_PADDING_TOP_MIN) + viewPadding.top | 0;
            this.content.y = this.divisionsContainer.y + DIVISIONS_OFFSET;
            this.content.setSize(_width,_height - this.content.y);
            this.content.setSizePadding(new Padding(0,0,0,viewPadding.left));
        }

        private function onDivisionsContainerResizeHandler(param1:Event) : void
        {
            invalidateSize();
        }

        private function onDivisionsIndexChangedHandler(param1:IndexEvent) : void
        {
            onDivisionChangedS(param1.index);
        }

        private function onContentViewChangedHandler(param1:ViewStackEvent) : void
        {
            var _loc2_:String = param1.viewId;
            if(!isFlashComponentRegisteredS(_loc2_))
            {
                registerFlashComponentS(IDAAPIModule(param1.view),_loc2_);
            }
            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}
