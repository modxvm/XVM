package net.wg.gui.bootcamp.battleResult.containers.base
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.bootcamp.containers.AnimatedLoaderTextContainer;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.battleResult.data.RewardVideoDataVO;
    import scaleform.clik.constants.InvalidationType;

    public class BattleResultVideoButton extends SoundButtonEx
    {

        public var content:AnimatedLoaderTextContainer = null;

        public var emptyFocusIndicator:MovieClip = null;

        private var _videoData:RewardVideoDataVO = null;

        public function BattleResultVideoButton()
        {
            super();
        }

        public function setData(param1:RewardVideoDataVO) : void
        {
            this._videoData = param1;
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            textField.mouseEnabled = false;
            focusIndicator = this.emptyFocusIndicator;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._videoData != null && isInvalid(InvalidationType.DATA))
            {
                this.validateData();
            }
        }

        override protected function onDispose() : void
        {
            this.content.dispose();
            this.content = null;
            this.emptyFocusIndicator = null;
            this._videoData = null;
            super.onDispose();
        }

        private function validateData() : void
        {
            this.content.source = this._videoData.image;
            textField.text = this._videoData.label;
        }
    }
}
