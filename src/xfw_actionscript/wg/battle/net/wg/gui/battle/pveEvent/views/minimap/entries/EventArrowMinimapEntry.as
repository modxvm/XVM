package net.wg.gui.battle.pveEvent.views.minimap.entries
{
    import net.wg.gui.battle.components.BattleUIComponent;

    public class EventArrowMinimapEntry extends BattleUIComponent
    {

        public var arrow:EventArrowContainer = null;

        public function EventArrowMinimapEntry()
        {
            super();
        }

        public function setBlinking() : void
        {
            this.arrow.setBlinking();
        }

        public function setIcon(param1:String) : void
        {
            this.arrow.setIcon(param1);
        }

        override protected function onDispose() : void
        {
            this.arrow.dispose();
            this.arrow = null;
            super.onDispose();
        }
    }
}
