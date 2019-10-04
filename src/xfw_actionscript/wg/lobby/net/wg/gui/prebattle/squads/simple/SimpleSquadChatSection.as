package net.wg.gui.prebattle.squads.simple
{
    import net.wg.gui.prebattle.squads.SquadChatSectionBase;

    public class SimpleSquadChatSection extends SquadChatSectionBase
    {

        public function SimpleSquadChatSection()
        {
            super();
            lblChatHeader.mouseEnabled = false;
            channelComponent.externalHintTF = lblChatHeader;
        }

        override protected function getHeader() : String
        {
            return MESSENGER.DIALOGS_SQUADCHANNEL_SIMPLECHATNAME;
        }
    }
}
