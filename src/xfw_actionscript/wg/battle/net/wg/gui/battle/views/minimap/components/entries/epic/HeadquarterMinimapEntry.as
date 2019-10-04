package net.wg.gui.battle.views.minimap.components.entries.epic
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.infrastructure.managers.IAtlasManager;
    import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;

    public class HeadquarterMinimapEntry extends BattleUIComponent
    {

        private static const HQ_ID_MAX:int = 5;

        private static const IDX_WARNING_TEXT:String = "[HeadquarterMinimapEntry] HQ Letter id out of range!";

        public var hqLetter:MovieClip = null;

        public var hqIconAtlasPlaceholder:Sprite = null;

        private var _atlasManager:IAtlasManager;

        private var _statePrefix:String = null;

        public function HeadquarterMinimapEntry()
        {
            this._atlasManager = App.atlasMgr;
            super();
            this._statePrefix = EpicMinimapEntryConst.HEADQUARTER_ATLAS_ITEM_NAME + EpicMinimapEntryConst.SUFIX_ENEMY;
            this.setHeadquarterIcon(this._statePrefix);
        }

        override protected function onDispose() : void
        {
            this.hqIconAtlasPlaceholder = null;
            this.hqLetter.stop();
            this.hqLetter = null;
            this._atlasManager = null;
            super.onDispose();
        }

        public function setDead(param1:Boolean) : void
        {
            var _loc2_:String = param1?EpicMinimapEntryConst.SUFIX_DESTROYED:"";
            this.setHeadquarterIcon(this._statePrefix + _loc2_);
            if(param1)
            {
                gotoAndPlay(2);
            }
        }

        public function setIdentifier(param1:int) : void
        {
            this.setHeadquarterLetter(param1);
        }

        public function setOwningTeam(param1:Boolean) : void
        {
            var _loc2_:String = param1?EpicMinimapEntryConst.SUFIX_ALLY:EpicMinimapEntryConst.SUFIX_ENEMY;
            this._statePrefix = EpicMinimapEntryConst.HEADQUARTER_ATLAS_ITEM_NAME + _loc2_;
            this.setHeadquarterIcon(this._statePrefix);
        }

        private function setHeadquarterIcon(param1:String) : void
        {
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.hqIconAtlasPlaceholder.graphics,EpicMinimapEntryConst.EMPTY_DOUBLE_STR,true);
        }

        private function setHeadquarterLetter(param1:int) : void
        {
            if(param1 < 1 || param1 > HQ_ID_MAX)
            {
                DebugUtils.LOG_WARNING(IDX_WARNING_TEXT,param1);
                return;
            }
            this.hqLetter.gotoAndStop(param1);
        }
    }
}
