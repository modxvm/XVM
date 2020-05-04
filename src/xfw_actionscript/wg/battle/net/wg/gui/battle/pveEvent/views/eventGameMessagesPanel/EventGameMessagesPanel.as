package net.wg.gui.battle.pveEvent.views.eventGameMessagesPanel
{
    import net.wg.gui.battle.views.gameMessagesPanel.GameMessagesPanel;
    import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;
    import net.wg.data.constants.Linkages;

    public class EventGameMessagesPanel extends GameMessagesPanel
    {

        public function EventGameMessagesPanel()
        {
            super();
        }

        override protected function setMsgLinkageTypeDict() : void
        {
            msgLinkageTypeDict[GAME_MESSAGES_CONSTS.WIN] = Linkages.DRAW_UI_LINKAGE;
            msgLinkageTypeDict[GAME_MESSAGES_CONSTS.DEFEAT] = Linkages.DRAW_UI_LINKAGE;
            msgLinkageTypeDict[GAME_MESSAGES_CONSTS.DRAW] = Linkages.DRAW_UI_LINKAGE;
        }
    }
}
