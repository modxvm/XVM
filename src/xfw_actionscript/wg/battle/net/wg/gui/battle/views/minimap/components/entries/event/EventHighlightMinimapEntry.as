package net.wg.gui.battle.views.minimap.components.entries.event
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.MovieClip;

    public class EventHighlightMinimapEntry extends BattleUIComponent
    {

        public var targetAnimation:MovieClip = null;

        public function EventHighlightMinimapEntry()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.targetAnimation = null;
            super.onDispose();
        }
    }
}
