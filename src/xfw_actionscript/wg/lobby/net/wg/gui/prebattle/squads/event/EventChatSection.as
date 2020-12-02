package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.prebattle.squads.simple.SimpleSquadChatSection;
    import scaleform.clik.constants.InvalidationType;

    public class EventChatSection extends SimpleSquadChatSection
    {

        private static const CHANNEL_PADDING:int = 3;

        private var _channelSize:int = -1;

        public function EventChatSection()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            channelComponent.isReturnToNormalScale = true;
        }

        override protected function layoutChatHeader() : void
        {
            lblChatHeader.y = channelComponent.y + (this._channelSize - lblChatHeader.textHeight >> 1);
        }

        override protected function getHeader() : String
        {
            return MESSENGER.DIALOGS_SQUADCHANNEL_CHATNAME;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this._channelSize = _height - channelComponent.y + CHANNEL_PADDING;
                channelComponent.setChannelHeight(this._channelSize);
                chatSubmitButton.y = _height - chatSubmitButton.height;
                this.layoutChatHeader();
            }
        }

        override public function get chatSubmitBtnTooltip() : String
        {
            return TOOLTIPS.SQUADWINDOW_BUTTONS_SENDMESSAGE;
        }
    }
}
