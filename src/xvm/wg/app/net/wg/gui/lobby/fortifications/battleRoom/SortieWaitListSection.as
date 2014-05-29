package net.wg.gui.lobby.fortifications.battleRoom
{
   import net.wg.gui.rally.views.room.BaseWaitListSection;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   import flash.events.MouseEvent;
   import net.wg.gui.cyberSport.data.CandidatesDataProvider;


   public class SortieWaitListSection extends BaseWaitListSection
   {
          
      public function SortieWaitListSection() {
         super();
         candidatesDP = new CandidatesDataProvider();
      }

      override protected function configUI() : void {
         super.configUI();
         lblCandidatesHeader.text = FORTIFICATIONS.SORTIE_ROOM_CANDIDATES;
         btnInviteFriend.label = FORTIFICATIONS.SORTIE_ROOM_INVITEFRIENDS;
         btnInviteFriend.UIID = 52;
      }

      override protected function onInviteFriendClick() : void {
         App.eventLogManager.logUIElement(btnInviteFriend,EVENT_LOG_CONSTANTS.EVENT_TYPE_CLICK,0);
      }

      override protected function onControlRollOver(param1:MouseEvent) : void {
         super.onControlRollOver(param1);
         switch(param1.target)
         {
            case btnInviteFriend:
               App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_INVITEBTN);
               break;
         }
      }
   }

}