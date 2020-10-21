package net.wg.gui.lobby.eventQuests
{
    import net.wg.infrastructure.base.meta.impl.EventQuestsPanelMeta;
    import net.wg.infrastructure.base.meta.IEventQuestsPanelMeta;
    import net.wg.gui.components.controls.SimpleTileList;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.data.DataProvider;
    import scaleform.gfx.MouseEventEx;

    public class EventHangarQuests extends EventQuestsPanelMeta implements IEventQuestsPanelMeta
    {

        private static const SMALL_HEIGHT:int = 62;

        private static const NORMAL_HEIGHT:int = 82;

        private static const GROUP_RENDERER:String = "EventQuestRendererUI";

        private static const GROUP_RENDERER_SMALL:String = "EventQuestRendererSmallUI";

        private static const SIZE_SMALL:int = 820;

        private static const OFFSET:int = 173;

        public var list:SimpleTileList = null;

        private var _spacing:int = -1;

        private var _bottom:int = -1;

        public function EventHangarQuests()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(ButtonEvent.CLICK,this.onMouseClickHandler);
        }

        override protected function onDispose() : void
        {
            removeEventListener(ButtonEvent.CLICK,this.onMouseClickHandler);
            this.list.dispose();
            this.list = null;
            super.onDispose();
        }

        override protected function setListDataProvider(param1:DataProvider) : void
        {
            this.list.dataProvider = param1;
            this.updatePosition();
        }

        public function updateLayout(param1:Number, param2:int, param3:int) : void
        {
            this._spacing = param3;
            this._bottom = param1;
            if(param1 < SIZE_SMALL)
            {
                this.list.itemRenderer = App.utils.classFactory.getClass(GROUP_RENDERER_SMALL);
                this.list.tileHeight = SMALL_HEIGHT;
            }
            else
            {
                this.list.itemRenderer = App.utils.classFactory.getClass(GROUP_RENDERER);
                this.list.tileHeight = NORMAL_HEIGHT;
            }
            this.updatePosition();
        }

        private function updatePosition() : void
        {
            if(this.list.dataProvider)
            {
                y = this._bottom - this.list.dataProvider.length * this.list.tileHeight - OFFSET;
            }
        }

        private function onMouseClickHandler(param1:ButtonEvent) : void
        {
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                onQuestPanelClickS();
            }
        }
    }
}
