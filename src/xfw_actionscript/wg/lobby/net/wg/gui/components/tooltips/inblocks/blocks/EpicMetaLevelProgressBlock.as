package net.wg.gui.components.tooltips.inblocks.blocks
{
    import net.wg.gui.lobby.epicBattles.components.common.EpicProgressBar;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesMetaLevelVO;
    import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;

    public class EpicMetaLevelProgressBlock extends BaseTooltipBlock
    {

        public var progressBar:EpicProgressBar = null;

        private var _data:EpicBattlesMetaLevelVO = null;

        private var _isDataApplied:Boolean = false;

        public function EpicMetaLevelProgressBlock()
        {
            super();
        }

        override public function cleanUp() : void
        {
            this.clearData();
        }

        override public function setBlockData(param1:Object) : void
        {
            this.clearData();
            this._data = new EpicBattlesMetaLevelVO(param1);
            this._isDataApplied = false;
            invalidateBlock();
        }

        override public function setBlockWidth(param1:int) : void
        {
        }

        override public function getWidth() : Number
        {
            return this.progressBar.width;
        }

        override public function getHeight() : Number
        {
            return this.progressBar.height;
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

        override protected function onDispose() : void
        {
            this.clearData();
            this.progressBar.dispose();
            this.progressBar = null;
            super.onDispose();
        }

        private function applyData() : void
        {
            var _loc1_:ProgressBarAnimVO = this._data.progressBarData;
            this.progressBar.setData(_loc1_);
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
