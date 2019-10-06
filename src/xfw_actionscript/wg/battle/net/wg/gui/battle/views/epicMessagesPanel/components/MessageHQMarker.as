package net.wg.gui.battle.views.epicMessagesPanel.components
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.MovieClip;

    public class MessageHQMarker extends BattleUIComponent
    {

        public var epicHQId:MovieClip = null;

        public var hqProgress:MovieClip = null;

        public function MessageHQMarker()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.epicHQId = null;
            this.hqProgress = null;
            super.onDispose();
        }
    }
}
