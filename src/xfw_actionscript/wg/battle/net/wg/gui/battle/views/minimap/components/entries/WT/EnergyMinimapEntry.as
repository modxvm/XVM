package net.wg.gui.battle.views.minimap.components.entries.WT
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.Sprite;
    import net.wg.gui.battle.views.minimap.MinimapEntryController;
    import net.wg.data.constants.Linkages;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;

    public class EnergyMinimapEntry extends BattleUIComponent
    {

        private static const IMAGE_NAME:String = "WTEnergyBonus";

        public var atlasPlaceholder:Sprite = null;

        public function EnergyMinimapEntry()
        {
            super();
            var _loc1_:WaveSpawnFlashMinimapEntry = App.utils.classFactory.getComponent(Linkages.WT_ENERGY_SPAWN_ENTRY_UI,WaveSpawnFlashMinimapEntry);
            _loc1_.scaleX = _loc1_.scaleY = 0.75;
            addChild(_loc1_);
            MinimapEntryController.instance.registerScalableEntry(this);
            App.atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,IMAGE_NAME,this.atlasPlaceholder.graphics,"",true);
        }

        override protected function onDispose() : void
        {
            MinimapEntryController.instance.unregisterScalableEntry(this);
            this.atlasPlaceholder = null;
            super.onDispose();
        }
    }
}
