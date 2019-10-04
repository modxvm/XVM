package net.wg.gui.lobby.sessionStats
{
    import net.wg.infrastructure.base.meta.impl.SessionBattleStatsViewMeta;
    import net.wg.gui.lobby.components.IResizableContent;
    import net.wg.gui.components.containers.GroupEx;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.ScrollingListEx;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsViewVO;
    import net.wg.gui.components.common.containers.TiledLayout;
    import net.wg.data.constants.generated.TEXT_ALIGN;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.components.common.containers.VerticalGroupLayout;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsPopoverVO;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.sessionStats.events.SessionStatsPopoverResizedEvent;

    public class SessionBattleStatsView extends SessionBattleStatsViewMeta implements IResizableContent
    {

        public static const TILE_COLS:int = 2;

        public static const TILE_GAP:int = 25;

        public static const TILE_WIDTH:int = 132;

        public static const TILE_HEIGHT:int = 40;

        public static const COLLAPSE_GAP:int = 7;

        private static const TOTAL_GAP:int = 8;

        private static const ROW_HEIGHT:int = 31;

        private static const LIST_GAP:int = 10;

        public var lastBattle:GroupEx = null;

        public var total:GroupEx = null;

        public var collapseBtn:ISoundButtonEx = null;

        public var collapsedList:ScrollingListEx = null;

        public var totalBg:MovieClip = null;

        public var hoverBg:MovieClip = null;

        private var _data:SessionBattleStatsViewVO = null;

        public function SessionBattleStatsView()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:TiledLayout = new TiledLayout(TILE_WIDTH,TILE_HEIGHT,TILE_COLS,TEXT_ALIGN.LEFT);
            _loc1_.gap = TILE_GAP;
            this.lastBattle.layout = _loc1_;
            this.lastBattle.itemRendererLinkage = Linkages.SESSION_LAST_BATTLE_STATS_RENDERER_UI;
            var _loc2_:VerticalGroupLayout = new VerticalGroupLayout();
            _loc2_.gap = TOTAL_GAP;
            this.total.layout = _loc2_;
            this.total.itemRendererLinkage = Linkages.SESSION_TOTAL_STATS_RENDERER_UI;
            this.collapsedList.itemRenderer = App.utils.classFactory.getClass(Linkages.SESSION_BATTLE_EFFICIENCY_STATS_RENDERER_UI);
            this.collapsedList.scrollBar = Linkages.SCROLL_BAR;
            this.collapsedList.rowHeight = ROW_HEIGHT;
            this.collapsedList._gap = LIST_GAP;
            this.collapsedList.smartScrollBar = true;
            this.collapsedList.widthAutoResize = false;
            this.collapsedList.visible = this.collapseBtn.toggle;
            this.collapseBtn.toggle = true;
            this.collapseBtn.useHtmlText = true;
            this.collapseBtn.addEventListener(ButtonEvent.CLICK,this.onCollapseBtnClickHandler);
            this.collapseBtn.addEventListener(MouseEvent.ROLL_OVER,this.onCollapseBtnRollOverHandler);
            this.collapseBtn.addEventListener(MouseEvent.ROLL_OUT,this.onCollapseBtnRollOutHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA) && this._data)
            {
                this.lastBattle.dataProvider = this._data.lastBattle;
                this.total.dataProvider = this._data.total;
                this.collapsedList.dataProvider = this._data.battleEfficiency;
                this.collapseBtn.label = this._data.collapseLabel;
            }
        }

        override protected function onDispose() : void
        {
            this.lastBattle.dispose();
            this.lastBattle = null;
            this.total.dispose();
            this.total = null;
            this.collapsedList.dispose();
            this.collapsedList = null;
            this.collapseBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onCollapseBtnRollOverHandler);
            this.collapseBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onCollapseBtnRollOutHandler);
            this.collapseBtn.removeEventListener(ButtonEvent.CLICK,this.onCollapseBtnClickHandler);
            this.collapseBtn.dispose();
            this.collapseBtn = null;
            this.totalBg = null;
            this.hoverBg = null;
            this._data = null;
            super.onDispose();
        }

        override protected function setData(param1:SessionBattleStatsViewVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function canShowAutomatically() : Boolean
        {
            return true;
        }

        public function update(param1:Object) : void
        {
            if(!param1)
            {
                return;
            }
            var _loc2_:SessionStatsPopoverVO = SessionStatsPopoverVO(param1);
            this.collapseBtn.selected = _loc2_.isExpanded;
            this.expand(_loc2_.isExpanded);
        }

        public function getComponentForFocus() : InteractiveObject
        {
            return this;
        }

        private function onCollapseBtnClickHandler(param1:ButtonEvent) : void
        {
            this.expand(this.collapseBtn.selected);
            dispatchEvent(new SessionStatsPopoverResizedEvent(this.collapseBtn.selected));
        }

        private function expand(param1:Boolean) : void
        {
            this.collapsedList.visible = param1;
        }

        public function setViewSize(param1:Number, param2:Number) : void
        {
            setSize(param1,param2);
            this.collapsedList.height = height - this.collapsedList.y;
        }

        public function get centerOffset() : int
        {
            return 0;
        }

        public function set centerOffset(param1:int) : void
        {
        }

        public function get active() : Boolean
        {
            return false;
        }

        public function set active(param1:Boolean) : void
        {
        }

        private function onCollapseBtnRollOverHandler(param1:MouseEvent) : void
        {
            this.hoverBg.visible = true;
        }

        private function onCollapseBtnRollOutHandler(param1:MouseEvent) : void
        {
            this.hoverBg.visible = false;
        }
    }
}
