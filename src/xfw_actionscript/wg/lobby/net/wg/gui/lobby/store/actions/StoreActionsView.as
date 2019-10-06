package net.wg.gui.lobby.store.actions
{
    import net.wg.infrastructure.base.meta.impl.StoreActionsViewMeta;
    import net.wg.infrastructure.base.meta.IStoreActionsViewMeta;
    import net.wg.gui.components.controls.ResizableScrollPane;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.lobby.store.actions.data.StoreActionsViewVo;
    import flash.events.Event;
    import net.wg.gui.lobby.store.actions.evnts.StoreActionsEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.store.actions.data.StoreActionTimeVo;
    import net.wg.gui.lobby.store.evnts.StoreViewStackEvent;
    import net.wg.data.constants.generated.STORE_CONSTANTS;

    public class StoreActionsView extends StoreActionsViewMeta implements IStoreActionsViewMeta
    {

        private static const SCROLL_BAR_RIGHT_PADDING:Number = 10;

        private static const SCROLL_BAR_BOTTOM_PADDING:Number = 11;

        private static const SCROLL_BAR_TOP_PADDING:Number = 11;

        private static const SCROLL_STEP_FACTOR:Number = 30;

        public var resizableScrollPane:ResizableScrollPane = null;

        public var scrollBar:ScrollBar = null;

        public var storeActionsContainer:StoreActionsContainer = null;

        private var _data:StoreActionsViewVo = null;

        public function StoreActionsView()
        {
            super();
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.storeActionsContainer.visible = false;
            this.scrollBar.y = SCROLL_BAR_TOP_PADDING;
            this.resizableScrollPane.scrollBar = this.scrollBar;
            this.resizableScrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
            this.resizableScrollPane.target = this.storeActionsContainer;
            this.storeActionsContainer.addEventListener(Event.COMPLETE,this.onStoreActionsContainerCompleteHandler);
            this.storeActionsContainer.addEventListener(StoreActionsEvent.ACTION_CLICK,this.onStoreActionsContainerActionClickHandler);
            this.storeActionsContainer.addEventListener(StoreActionsEvent.ACTION_SEEN,this.onStoreActionsContainerActionSeenHandler);
            this.storeActionsContainer.addEventListener(StoreActionsEvent.BATTLE_TASK_CLICK,this.onStoreActionsContainerBattleTaskClickHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.resize(_width,_height);
            }
        }

        override protected function onDispose() : void
        {
            this.scrollBar.dispose();
            this.scrollBar = null;
            this.storeActionsContainer.removeEventListener(Event.COMPLETE,this.onStoreActionsContainerCompleteHandler);
            this.storeActionsContainer.removeEventListener(StoreActionsEvent.ACTION_CLICK,this.onStoreActionsContainerActionClickHandler);
            this.storeActionsContainer.removeEventListener(StoreActionsEvent.ACTION_SEEN,this.onStoreActionsContainerActionSeenHandler);
            this.storeActionsContainer.removeEventListener(StoreActionsEvent.BATTLE_TASK_CLICK,this.onStoreActionsContainerBattleTaskClickHandler);
            this.storeActionsContainer = null;
            this.resizableScrollPane.dispose();
            this.resizableScrollPane = null;
            this._data = null;
            super.onDispose();
        }

        override protected function setData(param1:StoreActionsViewVo) : void
        {
            this._data = param1;
            this.storeActionsContainer.setData(this._data);
            invalidateSize();
        }

        override protected function actionTimeUpdate(param1:Vector.<StoreActionTimeVo>) : void
        {
            this.storeActionsContainer.updateActionsTime(param1);
        }

        private function resize(param1:Number, param2:Number) : void
        {
            this.storeActionsContainer.setSize(param1,param2);
            this.resizableScrollPane.setSize(param1,param2);
            this.scrollBar.x = App.appWidth - this.scrollBar.width - SCROLL_BAR_RIGHT_PADDING ^ 0;
            this.scrollBar.height = this.resizableScrollPane.height - SCROLL_BAR_BOTTOM_PADDING - SCROLL_BAR_TOP_PADDING;
        }

        private function onStoreActionsContainerBattleTaskClickHandler(param1:StoreActionsEvent) : void
        {
            onBattleTaskSelectS(param1.actionId);
        }

        private function onStoreActionsContainerCompleteHandler(param1:Event) : void
        {
            var _loc2_:* = NaN;
            if(this._data.cards)
            {
                _loc2_ = this.storeActionsContainer.getCardYPositionById(this._data.cards.linkedBattleQuest,true);
                this.resizableScrollPane.scrollPosition = Math.floor(_loc2_ / SCROLL_STEP_FACTOR);
            }
            this.storeActionsContainer.visible = true;
        }

        private function onStoreActionsContainerActionSeenHandler(param1:StoreActionsEvent) : void
        {
            onActionSeenS(param1.actionId);
        }

        private function onStoreActionsContainerActionClickHandler(param1:StoreActionsEvent) : void
        {
            if(param1.actionId == StoreActionsEmpty.ACTION_ID_EMPTY)
            {
                dispatchEvent(new StoreViewStackEvent(StoreViewStackEvent.SWITCH_TO_VIEW,STORE_CONSTANTS.SHOP));
            }
            else
            {
                actionSelectS(param1.triggerChainID);
            }
        }
    }
}
