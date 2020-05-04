package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.eventHangar.components.EventHeaderText;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventBattleResult.data.ResultStatusVO;

    public class ResultStatus extends ResultAppearMovieClip implements IDisposable
    {

        public var header:EventHeaderText = null;

        public var status:AnimatedTextContainer = null;

        public var bg:MovieClip = null;

        private var _disposed:Boolean = false;

        public function ResultStatus()
        {
            super();
        }

        public function setData(param1:ResultStatusVO) : void
        {
            this.header.text = param1.title;
            this.status.text = param1.subTitle;
        }

        public function setWidth(param1:int) : void
        {
            this.bg.width = param1;
            this.bg.x = -param1 >> 1;
        }

        public function setSizeFrame(param1:int) : void
        {
            var _loc2_:String = this.header.text;
            var _loc3_:String = this.status.text;
            this.header.gotoAndStop(param1);
            if(this._disposed)
            {
                return;
            }
            this.status.gotoAndStop(param1);
            if(this._disposed)
            {
                return;
            }
            this.bg.gotoAndStop(param1);
            if(this._disposed)
            {
                return;
            }
            if(this.header != null)
            {
                this.header.text = _loc2_;
                this.status.text = _loc3_;
            }
        }

        public final function dispose() : void
        {
            this.header.dispose();
            this.header = null;
            this.status.dispose();
            this.status = null;
            this.bg = null;
            this._disposed = true;
        }
    }
}
