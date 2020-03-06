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
    import net.wg.gui.lobby.hangar.quests.HeaderQuestsEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import flash.geom.Rectangle;
    import net.wg.data.constants.Directions;
    import net.wg.gui.lobby.hangar.interfaces.IHeaderQuestsContainer;

    public class HangarHeader extends HangarHeaderMeta implements IHangarHeaderMeta, IHelpLayoutComponent, IHangarHeader
    {

        private static const SEPARATOR:String = "_";

        private static const HELP_OFFSET_WIDTH:int = 56;

        private static const HELP_OFFSET_HEIGHT:int = -3;

        private static const HELP_OFFSET_WIDTH_GAP:int = 199;

        public var mcBackground:Sprite;

        public var questsFlags:HeaderQuestsFlags;

        private var _data:HangarHeaderVO;

        private var _battlePassEntryPoint:BattlePassEntryPoint = null;

        public function HangarHeader()
        {
            super();
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
            this.mcBackground = null;
            this._data = null;
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
                this._battlePassEntryPoint = new BattlePassEntryPoint();
                this.questsFlags.setBattlePassEntryPoint(this._battlePassEntryPoint);
                registerFlashComponentS(this._battlePassEntryPoint,HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT);
            }
        }

        public function as_removeBattlePass() : void
        {
            if(this._battlePassEntryPoint != null)
            {
                this.questsFlags.setBattlePassEntryPoint(null);
                if(isFlashComponentRegisteredS(HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT))
                {
                    unregisterFlashComponentS(HANGAR_ALIASES.BATTLE_PASSS_ENTRY_POINT);
                }
                this._battlePassEntryPoint = null;
            }
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            var _loc1_:HelpLayoutVO = new HelpLayoutVO();
            var _loc2_:Rectangle = this.questsFlags.getHitRect();
            _loc1_.x = this.questsFlags.x + _loc2_.x;
            _loc1_.y = this.questsFlags.y;
            _loc1_.width = _loc2_.width;
            _loc1_.height = _loc2_.height + HELP_OFFSET_HEIGHT;
            _loc1_.message = LOBBY_HELP.HANGAR_HEADER_QUESTS;
            _loc1_.extensibilityDirection = Directions.RIGHT;
            _loc1_.id = name + SEPARATOR + Math.random();
            _loc1_.scope = this;
            var _loc3_:HelpLayoutVO = new HelpLayoutVO();
            _loc3_.x = _loc1_.x + _loc1_.width;
            _loc3_.y = this.questsFlags.y;
            _loc3_.width = -_loc3_.x + HELP_OFFSET_WIDTH;
            _loc3_.height = _loc1_.height;
            _loc3_.message = LOBBY_HELP.HANGAR_HEADER_VEHICLE;
            _loc3_.extensibilityDirection = Directions.RIGHT;
            _loc3_.id = name + SEPARATOR + Math.random();
            _loc3_.scope = this;
            if(_loc3_.width > HELP_OFFSET_WIDTH_GAP)
            {
                _loc3_.width = HELP_OFFSET_WIDTH_GAP;
            }
            return new <HelpLayoutVO>[_loc1_,_loc3_];
        }

        public function getQuestGroupByType(param1:String) : IHeaderQuestsContainer
        {
            return this.questsFlags.getQuestGroupByID(param1);
        }

        private function onBtnHeaderQuestClickHandler(param1:HeaderQuestsEvent) : void
        {
            onQuestBtnClickS(param1.questType,param1.questID);
        }
    }
}
