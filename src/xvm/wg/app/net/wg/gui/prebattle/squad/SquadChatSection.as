package net.wg.gui.prebattle.squad
{
    import net.wg.gui.rally.views.room.BaseChatSection;
    
    public class SquadChatSection extends BaseChatSection
    {
        
        public function SquadChatSection()
        {
            super();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override protected function getHeader() : String
        {
            return MESSENGER.DIALOGS_SQUADCHANNEL_CHATNAME;
        }
        
        override public function get chatSubmitBtnTooltip() : String
        {
            return TOOLTIPS.SQUADWINDOW_BUTTONS_SENDMESSAGE;
        }
    }
}
