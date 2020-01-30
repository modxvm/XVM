package net.wg.gui.battle.bob.stats.components.playersPanel.list
{
    public class BobPlayersPanelListLeft extends BobPlayersPanelList
    {

        private static const LINKAGE:String = "BobPlayersPanelListItemLeftUI";

        public function BobPlayersPanelListLeft()
        {
            super();
        }

        override protected function get itemLinkage() : String
        {
            return LINKAGE;
        }

        override protected function get isRightAligned() : Boolean
        {
            return false;
        }

        override public function toString() : String
        {
            return "[WG BobPlayersPanelListLeft]";
        }
    }
}
