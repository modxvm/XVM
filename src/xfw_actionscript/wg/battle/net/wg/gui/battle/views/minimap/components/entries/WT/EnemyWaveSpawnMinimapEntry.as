package net.wg.gui.battle.views.minimap.components.entries.WT
{
    import net.wg.infrastructure.events.ColorSchemeEvent;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import net.wg.gui.battle.views.minimap.constants.MinimapColorConst;

    public class EnemyWaveSpawnMinimapEntry extends AbstractWaveSpawnMinimapEntry
    {

        private static const ENEMY_WAVE_SPAWN_ENTRY:String = "EnemyWaveSpawnEntry";

        public function EnemyWaveSpawnMinimapEntry()
        {
            super();
        }

        override public function setPointNumber(param1:int) : void
        {
            super.setPointNumber(param1);
            App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
        }

        override protected function onDispose() : void
        {
            App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
            super.onDispose();
        }

        override protected function drawEntry() : void
        {
            atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,ENEMY_WAVE_SPAWN_ENTRY + "_" + App.colorSchemeMgr.getScheme(MinimapColorConst.TEAM_SPAWN_BASE_RED).aliasColor + "_" + pointNumber,atlasPlaceholder.graphics,"",true);
        }

        private function onColorSchemeChangeHandler(param1:ColorSchemeEvent) : void
        {
            this.drawEntry();
        }
    }
}
