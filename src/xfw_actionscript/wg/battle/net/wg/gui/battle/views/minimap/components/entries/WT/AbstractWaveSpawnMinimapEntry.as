package net.wg.gui.battle.views.minimap.components.entries.WT
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.Sprite;
    import net.wg.infrastructure.managers.IAtlasManager;
    import net.wg.gui.battle.views.minimap.MinimapEntryController;
    import flash.filters.ColorMatrixFilter;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.data.constants.Errors;

    public class AbstractWaveSpawnMinimapEntry extends BattleUIComponent
    {

        public var atlasPlaceholder:Sprite = null;

        protected var pointNumber:int = -1;

        protected var atlasManager:IAtlasManager;

        public function AbstractWaveSpawnMinimapEntry()
        {
            this.atlasManager = App.atlasMgr;
            super();
            MinimapEntryController.instance.registerScalableEntry(this);
        }

        override protected function onDispose() : void
        {
            MinimapEntryController.instance.unregisterScalableEntry(this);
            this.atlasPlaceholder = null;
            this.atlasManager = null;
            super.onDispose();
        }

        public function setGrayscale(param1:Boolean) : void
        {
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            var _loc5_:ColorMatrixFilter = null;
            if(param1)
            {
                _loc2_ = 1 / 3;
                _loc3_ = 1 / 3;
                _loc4_ = 1 / 3;
                _loc5_ = new ColorMatrixFilter([_loc2_,_loc3_,_loc4_,0,0,_loc2_,_loc3_,_loc4_,0,0,_loc2_,_loc3_,_loc4_,0,0,0,0,0,1,0]);
                this.atlasPlaceholder.filters = [_loc5_];
                this.atlasPlaceholder.alpha = 0.9;
            }
            else
            {
                this.atlasPlaceholder.filters = [];
                this.atlasPlaceholder.alpha = 1;
            }
        }

        public function setPointNumber(param1:int) : void
        {
            this.pointNumber = param1;
            this.drawEntry();
        }

        protected function drawEntry() : void
        {
            throw new AbstractException("AbstractWaveSpawnMinimapEntry.drawEntry" + Errors.ABSTRACT_INVOKE);
        }
    }
}
