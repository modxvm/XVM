package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;

    public class ResultMissionComplete extends ResultAppearMovieClip implements IDisposable
    {

        public var content:AnimatedTextContainer = null;

        public function ResultMissionComplete()
        {
            super();
        }

        public function setData(param1:String) : void
        {
            this.content.htmlText = param1;
        }

        public final function dispose() : void
        {
            this.content.dispose();
            this.content = null;
        }
    }
}
