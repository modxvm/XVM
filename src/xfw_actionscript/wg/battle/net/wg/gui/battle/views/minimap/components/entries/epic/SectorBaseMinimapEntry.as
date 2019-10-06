package net.wg.gui.battle.views.minimap.components.entries.epic
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import net.wg.gui.battle.components.EpicProgressCircle;
    import net.wg.infrastructure.managers.IAtlasManager;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;

    public class SectorBaseMinimapEntry extends BattleUIComponent
    {

        private static const BASE_ID_MAX:int = 6;

        private static const INDEX_WARNING_TEXT:String = "[SectorBaseMinimapEntry] Base Letter id out of range!";

        public var atlasPlaceholder:Sprite = null;

        public var baseLetter:MovieClip = null;

        public var progressAnimation:EpicProgressCircle = null;

        private var _atlasManager:IAtlasManager;

        public function SectorBaseMinimapEntry()
        {
            this._atlasManager = App.atlasMgr;
            super();
        }

        override protected function onDispose() : void
        {
            this._atlasManager = null;
            this.atlasPlaceholder = null;
            this.baseLetter.stop();
            this.baseLetter = null;
            this.progressAnimation.stop();
            this.progressAnimation.dispose();
            this.progressAnimation = null;
            super.onDispose();
        }

        public function setCapturePoints(param1:Number) : void
        {
            this.progressAnimation.updateProgress(param1);
        }

        public function setIdentifier(param1:int) : void
        {
            this.setBaseLetter(param1);
        }

        public function setOwningTeam(param1:Boolean) : void
        {
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.EPIC_BASE_CAP_MINIMAP_ENTRY_BACKGROUND,this.atlasPlaceholder.graphics,EpicMinimapEntryConst.EMPTY_DOUBLE_STR,true);
            this.progressAnimation.setOwner(param1);
        }

        private function setBaseLetter(param1:int) : void
        {
            if(param1 < 1 || param1 > BASE_ID_MAX)
            {
                DebugUtils.LOG_WARNING(INDEX_WARNING_TEXT);
            }
            this.baseLetter.gotoAndStop(param1);
        }
    }
}
