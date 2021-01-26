package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.HangarHeaderMeta;
    import net.wg.infrastructure.base.meta.IHangarHeaderMeta;
    import net.wg.utils.helpLayout.IHelpLayoutComponent;
    import net.wg.gui.lobby.hangar.interfaces.IHangarHeader;
    import flash.display.Sprite;
    import net.wg.gui.lobby.hangar.quests.HeaderQuestsFlags;
    import net.wg.gui.lobby.hangar.data.HangarHeaderVO;
    import net.wg.gui.lobby.hangar.quests.BattlePassEntryPoint;
    import net.wg.gui.lobby.rankedBattles19.components.widget.RankedBattlesHangarWidget;
    import net.wg.gui.lobby.hangar.quests.BobHangarWidget;
    import net.wg.utils.IScheduler;
    import net.wg.gui.lobby.hangar.quests.HeaderQuestsEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Linkages;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import flash.geom.Rectangle;
    import net.wg.data.constants.Directions;
    import net.wg.gui.lobby.hangar.interfaces.IHeaderQuestsContainer;

    public class HangarHeader extends HangarHeaderMeta implements IHangarHeaderMeta, IHelpLayoutComponent, IHangarHeader
    {

        private static const SEPARATOR:String = "_";

        private static const HELP_OFFSET_HEIGHT:int = -3;

        private static const HELP_OFFSET_X:int = -30;

        public var mcBackground:Sprite;

        public var questsFlags:HeaderQuestsFlags;

        private var _data:HangarHeaderVO;

        private var _battlePassEntryPoint:BattlePassEntryPoint = null;

        private var _rankedBattlesWidget:RankedBattlesHangarWidget = null;

        private var _bobWidget:BobHangarWidget = null;

        private var _scheduler:IScheduler = null;

        public function HangarHeader()
        {
            super();
            this._scheduler = App.utils.scheduler;
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.mcBackground.mouseEnabled = this.mcBackground.mouseChildren = false;
            this.questsFlags.addEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
            App.utils.helpLayout.registerComponent(this);
        }

        override protected function onBeforeDispose() : void
        {
            this.questsFlags.removeEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.questsFlags.dispose();
            this.questsFlags = null;
            this._battlePassEntryPoint = null;
            this._rankedBattlesWidget = null;
            this.mcBackground = null;
            this._data = null;
            this._scheduler.cancelTask(this.createBattlePass);
            this._scheduler = null;
            this._bobWidget = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                visible = this._data.isVisible;
                if(this._data.isVisible)
                {
                    this.questsFlags.setData(this._data.questsGroups);
                }
            }
        }

        override protected function setData(param1:HangarHeaderVO) : void
        {
            if(param1 == null)
            {
                return;
            }
            this._data = param1;
            invalidateData();
        }

        public function as_createBattlePass() : void
        {
            if(this._battlePassEntryPoint == null)
            {
                this._scheduler.cancelTask(this.createBattlePass);
                this._scheduler.scheduleOnNextFrame(this.createBattlePass);
            }
        }

        public function as_createRankedBattles() : void
        {
            if(this._rankedBattlesWidget == null)
            {
                this._rankedBattlesWidget = App.instance.utils.classFactory.getComponent(Linkages.RANKED_BATTLES_WIDGET_UI,RankedBattlesHangarWidget);
                this.questsFlags.setEntryPoint(this._rankedBattlesWidget);
                registerFlashComponentS(this._rankedBattlesWidget,HANGAR_ALIASES.RANKED_WIDGET);
            }
        }

        public function as_removeBattlePass() : void
        {
            if(this._battlePassEntryPoint != null)
            {
                if(this.questsFlags.getEntryPoint() is BattlePassEntryPoint)
                {
                    this.questsFlags.setEntryPoint(null);
                }
                if(isFlashComponentRegisteredS(HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT))
                {
                    unregisterFlashComponentS(HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT);
                }
                this._battlePassEntryPoint = null;
            }
        }

        public function as_removeRankedBattles() : void
        {
            if(this._rankedBattlesWidget != null)
            {
                if(this.questsFlags.getEntryPoint() is RankedBattlesHangarWidget)
                {
                    this.questsFlags.setEntryPoint(null);
                }
                if(isFlashComponentRegisteredS(HANGAR_ALIASES.RANKED_WIDGET))
                {
                    unregisterFlashComponentS(HANGAR_ALIASES.RANKED_WIDGET);
                }
                this._rankedBattlesWidget = null;
            }
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            var _loc1_:HelpLayoutVO = new HelpLayoutVO();
            var _loc2_:Rectangle = this.questsFlags.getHitRect();
            _loc1_.x = this.questsFlags.x + _loc2_.x + HELP_OFFSET_X;
            _loc1_.y = this.questsFlags.y;
            _loc1_.width = _loc2_.width;
            _loc1_.height = _loc2_.height + HELP_OFFSET_HEIGHT;
            _loc1_.message = LOBBY_HELP.HANGAR_HEADER_QUESTS;
            _loc1_.extensibilityDirection = Directions.RIGHT;
            _loc1_.id = name + SEPARATOR + Math.random();
            _loc1_.scope = this;
            return new <HelpLayoutVO>[_loc1_];
        }

        public function getQuestGroupByType(param1:String) : IHeaderQuestsContainer
        {
            return this.questsFlags.getQuestGroupByID(param1);
        }

        private function createBattlePass() : void
        {
            this._battlePassEntryPoint = new BattlePassEntryPoint();
            this.questsFlags.setEntryPoint(this._battlePassEntryPoint);
            registerFlashComponentS(this._battlePassEntryPoint,HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT);
        }

        private function onBtnHeaderQuestClickHandler(param1:HeaderQuestsEvent) : void
        {
            onQuestBtnClickS(param1.questType,param1.questID);
        }

        public function as_createBob() : void
        {
            if(!this._bobWidget)
            {
                this._bobWidget = new BobHangarWidget();
                this.questsFlags.setEntryPoint(this._bobWidget);
                registerFlashComponentS(this._bobWidget,HANGAR_ALIASES.BOB_HANGAR_WIDGET);
            }
        }

        public function as_removeBob() : void
        {
            if(this._bobWidget != null)
            {
                if(this.questsFlags.getEntryPoint() is BobHangarWidget)
                {
                    this.questsFlags.setEntryPoint(null);
                }
                if(isFlashComponentRegisteredS(HANGAR_ALIASES.BOB_HANGAR_WIDGET))
                {
                    unregisterFlashComponentS(HANGAR_ALIASES.BOB_HANGAR_WIDGET);
                }
                this._bobWidget = null;
            }
        }
    }
}
