package net.wg.gui.bootcamp.containers
{
    import net.wg.infrastructure.base.meta.impl.StartBootcampTransitionMeta;
    import net.wg.infrastructure.base.meta.IStartBootcampTransitionMeta;
    import net.wg.infrastructure.interfaces.IRootAppMainContent;
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.utils.clearInterval;
    import flash.utils.setInterval;

    public class StartBootcampTransition extends StartBootcampTransitionMeta implements IStartBootcampTransitionMeta, IRootAppMainContent
    {

        private static const DOTS:String = " ...";

        private static const TEXT_UPDATE_DELAY:int = 500;

        private static const TEXT_OFFSET:int = 28;

        public var textField:TextField;

        public var dotsField:TextField;

        public var icon:Sprite;

        private var _dotIndex:int;

        private var _updateInterval:int;

        private var _stageW:int = 0;

        private var _stageH:int = 0;

        public function StartBootcampTransition()
        {
            super();
        }

        override protected function onDispose() : void
        {
            clearInterval(this._updateInterval);
            this.textField = null;
            this.dotsField = null;
            this.icon = null;
            super.onDispose();
        }

        public final function as_dispose() : void
        {
            dispose();
        }

        public final function as_populate() : void
        {
            this._updateInterval = setInterval(this.updateDotsText,TEXT_UPDATE_DELAY);
        }

        public function as_setTransitionText(param1:String) : void
        {
            this.textField.text = param1;
            this.updateDotsText();
            this.updateContentPosition();
        }

        public function as_updateStage(param1:int, param2:int) : void
        {
            this._stageW = param1;
            this._stageH = param2;
            this.updateContentPosition();
        }

        private function updateDotsText() : void
        {
            this.dotsField.text = DOTS.substr(0,this._dotIndex);
            this._dotIndex++;
            if(this._dotIndex > DOTS.length)
            {
                this._dotIndex = 1;
            }
        }

        private function updateContentPosition() : void
        {
            this.icon.x = this._stageW - this.icon.width >> 1;
            this.icon.y = this._stageH - this.icon.height >> 1;
            this.textField.x = this.icon.x + (this.icon.width - this.textField.width >> 1);
            this.textField.y = this.icon.y + TEXT_OFFSET;
            this.dotsField.y = this.textField.y;
            this.dotsField.x = this.textField.x + (this.textField.width + this.textField.textWidth >> 1);
        }
    }
}
