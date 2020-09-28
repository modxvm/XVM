package net.wg.gui.battle.views.minimap.components.entries.WT
{
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import net.wg.gui.battle.views.minimap.constants.MinimapColorConst;

    public class AllyWaveSpawnMinimapEntry extends AbstractWaveSpawnMinimapEntry
    {

        private static const ALLY_TEAM_SPAWN_ENTRY:String = "AllyWaveSpawnEntry";

        public function AllyWaveSpawnMinimapEntry()
        {
            super();
        }

        override protected function drawEntry() : void
        {
            atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,ALLY_TEAM_SPAWN_ENTRY + "_" + MinimapColorConst.GREEN + "_" + pointNumber,atlasPlaceholder.graphics,"",true);
        }
    }
}
