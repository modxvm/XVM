package net.wg.gui.prebattle.squads.simple
{
    import net.wg.gui.prebattle.squads.SquadChatSectionBase;

    public class SimpleSquadChatSection extends SquadChatSectionBase
    {

        public function SimpleSquadChatSection()
        {
            super();
            lblChatHeader.mouseEnabled = false;
            lblChatHeader.multiline = true;
            lblChatHeader.wordWrap = true;
            channelComponent.externalHintTF = lblChatHeader;
        }

        override protected function getHeader() : String
        {
            return channelComponent.getChatInfo();
        }

        override protected function configUI() : void
        {
            super.configUI();
            lblChatHeader.htmlText = this.getHeader();
        }
    }
}
