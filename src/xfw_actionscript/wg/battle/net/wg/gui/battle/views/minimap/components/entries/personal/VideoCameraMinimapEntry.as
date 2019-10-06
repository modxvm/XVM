package net.wg.gui.battle.views.minimap.components.entries.personal
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.Sprite;
    import net.wg.infrastructure.managers.IAtlasManager;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import net.wg.gui.battle.views.minimap.components.entries.constants.PersonalMinimapEntryConst;
    import net.wg.gui.battle.views.minimap.MinimapEntryController;

    public class VideoCameraMinimapEntry extends BattleUIComponent
    {

        public var directionPlaceholder:Sprite = null;

        public var cameraPlaceholder:Sprite = null;

        private var _atlasManager:IAtlasManager;

        public function VideoCameraMinimapEntry()
        {
            this._atlasManager = App.atlasMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,PersonalMinimapEntryConst.GREEN_DIRECTION_ATLAS_ITEM_NAME,this.directionPlaceholder.graphics,"",true);
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,PersonalMinimapEntryConst.CAMERA_ATLAS_ITEM_NAME,this.cameraPlaceholder.graphics,"",true);
            MinimapEntryController.instance.registerScalableEntry(this);
        }

        override protected function onDispose() : void
        {
            MinimapEntryController.instance.unregisterScalableEntry(this);
            this.directionPlaceholder = null;
            this.cameraPlaceholder = null;
            this._atlasManager = null;
            super.onDispose();
        }
    }
}
