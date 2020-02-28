package net.wg.gui.components.tooltips.inblocks.blocks
{
    import net.wg.gui.lobby.epicBattles.components.EpicBattlesMetaLevel;
    import net.wg.gui.lobby.epicBattles.data.EpicMetaLevelIconVO;

    public class EpicMetaLevelIconBlock extends BaseTooltipBlock
    {

        private static const IMAGE_SIZE:int = 130;

        public var metaLevel:EpicBattlesMetaLevel = null;

        private var _data:EpicMetaLevelIconVO = null;

        private var _isDataApplied:Boolean = false;

        public function EpicMetaLevelIconBlock()
        {
            super();
        }

        override public function setBlockData(param1:Object) : void
        {
            this.clearData();
            this._data = new EpicMetaLevelIconVO(param1);
            this._isDataApplied = false;
            invalidateBlock();
        }

        override public function setBlockWidth(param1:int) : void
        {
        }

        override public function getWidth() : Number
        {
            return IMAGE_SIZE;
        }

        override public function getHeight() : Number
        {
            return IMAGE_SIZE;
        }

        override protected function onDispose() : void
        {
            this.clearData();
            this.metaLevel.dispose();
            this.metaLevel = null;
            super.onDispose();
        }

        override protected function onValidateBlock() : Boolean
        {
            if(!this._isDataApplied)
            {
                this.applyData();
                return true;
            }
            return false;
        }

        private function applyData() : void
        {
            this.metaLevel.setIconSize(IMAGE_SIZE);
            this.metaLevel.setData(this._data);
            this._isDataApplied = true;
        }

        private function clearData() : void
        {
            if(this._data != null)
            {
                this._data.dispose();
                this._data = null;
            }
        }
    }
}
