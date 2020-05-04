package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.gui.lobby.eventBattleResult.data.ResultPointsVO;
    import net.wg.data.constants.Values;
    import flash.events.MouseEvent;

    public class ResultPointsNoBonusAnim extends ResultPointsAnim
    {

        public var descr:AnimatedTextContainer = null;

        private var _data:ResultPointsVO = null;

        private var _sizeFrame:int = 1;

        public function ResultPointsNoBonusAnim()
        {
            super();
        }

        override public function setSizeFrame(param1:int) : void
        {
            super.setSizeFrame(param1);
            if(_disposed)
            {
                return;
            }
            this._sizeFrame = param1;
            this.descr.gotoAndStop(param1);
            if(this._data)
            {
                this.setDescrText();
            }
        }

        override public function appear() : void
        {
            super.appear();
            playIncrease(Values.ZERO,_total);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.descr.addEventListener(MouseEvent.ROLL_OVER,this.onDescrRollOverHandler);
            this.descr.addEventListener(MouseEvent.ROLL_OUT,this.onDescrRollOutHandler);
        }

        override protected function onDispose() : void
        {
            this.descr.removeEventListener(MouseEvent.ROLL_OVER,this.onDescrRollOverHandler);
            this.descr.removeEventListener(MouseEvent.ROLL_OUT,this.onDescrRollOutHandler);
            this.descr.dispose();
            this.descr = null;
            this._data = null;
            super.onDispose();
        }

        override public function setData(param1:ResultPointsVO) : void
        {
            super.setData(param1);
            this._data = param1;
            this.setDescrText();
        }

        private function setDescrText() : void
        {
            this.descr.htmlText = this._sizeFrame == 1?this._data.bonusText:this._data.bonusTextMin;
            App.utils.commons.updateTextFieldSize(this.descr.textField,true,false);
            this.descr.textField.x = -this.descr.textField.width >> 1;
        }

        private function onDescrRollOverHandler(param1:MouseEvent) : void
        {
            showTooltip();
        }

        private function onDescrRollOutHandler(param1:MouseEvent) : void
        {
            hideTooltip();
        }
    }
}
