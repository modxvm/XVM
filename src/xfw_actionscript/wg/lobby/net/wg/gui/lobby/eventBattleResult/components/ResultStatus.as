package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.eventHangar.components.EventHeaderText;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;

    public class ResultStatus extends ResultAppearMovieClip implements IDisposable
    {

        public var header:EventHeaderText = null;

        public function ResultStatus()
        {
            super();
        }

        public function setData(param1:ResultDataVO) : void
        {
            this.header.text = param1.captureStatus;
        }

        public function setSizeFrame(param1:int) : void
        {
            var _loc2_:String = this.header.text;
            this.header.gotoAndStop(param1);
            if(this.header != null)
            {
                this.header.text = _loc2_;
            }
        }

        public final function dispose() : void
        {
            this.header.dispose();
            this.header = null;
        }
    }
}
