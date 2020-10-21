package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;

    public class TankStatus extends ResultAppearMovieClip implements IDisposable
    {

        public var header:TankStatusHeader = null;

        public function TankStatus()
        {
            super();
        }

        public function setData(param1:ResultDataVO) : void
        {
            this.header.setData(param1);
        }

        public final function dispose() : void
        {
            this.header.dispose();
            this.header = null;
        }
    }
}
