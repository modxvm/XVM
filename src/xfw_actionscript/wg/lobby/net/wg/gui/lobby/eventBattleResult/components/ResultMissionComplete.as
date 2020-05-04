package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;

    public class ResultMissionComplete extends ResultAppearMovieClip implements IDisposable
    {

        public var content:AnimatedTextContainer = null;

        public var contentComplete:AnimatedTextContainer = null;

        public function ResultMissionComplete()
        {
            super();
        }

        public final function dispose() : void
        {
            this.content.dispose();
            this.content = null;
            this.contentComplete.dispose();
            this.contentComplete = null;
        }

        public function setLabels(param1:String, param2:String) : void
        {
            this.content.text = param1;
            this.contentComplete.text = param2;
        }
    }
}
