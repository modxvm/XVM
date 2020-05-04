package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.gui.lobby.eventBattleResult.data.ResultBottomStatusVO;

    public class BottomStatus extends ResultAppearMovieClip implements IDisposable
    {

        public var header:AnimatedTextContainer = null;

        private var _data:ResultBottomStatusVO = null;

        public function BottomStatus()
        {
            super();
        }

        public function setSizeFrame(param1:int) : void
        {
            this.header.gotoAndStop(param1);
            if(this._data)
            {
                this.header.htmlText = param1 == 1?this._data.normal:this._data.min;
            }
        }

        public function setData(param1:ResultBottomStatusVO) : void
        {
            this._data = param1;
            this.header.htmlText = this.header.currentFrame == 1?this._data.normal:this._data.min;
        }

        public final function dispose() : void
        {
            this.header.dispose();
            this.header = null;
            this._data = null;
        }
    }
}
