package net.wg.gui.battle.views.minimap.components.entries.teambase
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.Sprite;
    import net.wg.infrastructure.managers.IAtlasManager;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
    import net.wg.gui.battle.views.minimap.MinimapEntryController;

    public class ControlPointMinimapEntry extends BattleUIComponent
    {

        public var atlasPlaceholder:Sprite = null;

        private var _atlasManager:IAtlasManager;

        public function ControlPointMinimapEntry()
        {
            this._atlasManager = App.atlasMgr;
            super();
            MinimapEntryController.instance.registerScalableEntry(this);
        }

        public function setPointNumber(param1:int) : void
        {
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,TeamBaseMinimapEntryConst.CONTROL_POINT_ATLAS_ITEM_NAME + "_" + param1,this.atlasPlaceholder.graphics,"",true);
        }

        override protected function onDispose() : void
        {
            MinimapEntryController.instance.unregisterScalableEntry(this);
            this.atlasPlaceholder = null;
            this._atlasManager = null;
            super.onDispose();
        }
    }
}
