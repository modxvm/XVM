package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;


   public class TrainingRoomMeta extends AbstractView
   {
          
      public function TrainingRoomMeta() {
         super();
      }

      public var showTrainingSettings:Function = null;

      public var selectCommonVoiceChat:Function = null;

      public var startTraining:Function = null;

      public var swapTeams:Function = null;

      public var changeTeam:Function = null;

      public var closeTrainingRoom:Function = null;

      public var showPrebattleInvitationsForm:Function = null;

      public var onEscape:Function = null;

      public function showTrainingSettingsS() : void {
         App.utils.asserter.assertNotNull(this.showTrainingSettings,"showTrainingSettings" + Errors.CANT_NULL);
         this.showTrainingSettings();
      }

      public function selectCommonVoiceChatS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.selectCommonVoiceChat,"selectCommonVoiceChat" + Errors.CANT_NULL);
         this.selectCommonVoiceChat(param1);
      }

      public function startTrainingS() : void {
         App.utils.asserter.assertNotNull(this.startTraining,"startTraining" + Errors.CANT_NULL);
         this.startTraining();
      }

      public function swapTeamsS() : void {
         App.utils.asserter.assertNotNull(this.swapTeams,"swapTeams" + Errors.CANT_NULL);
         this.swapTeams();
      }

      public function changeTeamS(param1:Number, param2:Number) : void {
         App.utils.asserter.assertNotNull(this.changeTeam,"changeTeam" + Errors.CANT_NULL);
         this.changeTeam(param1,param2);
      }

      public function closeTrainingRoomS() : void {
         App.utils.asserter.assertNotNull(this.closeTrainingRoom,"closeTrainingRoom" + Errors.CANT_NULL);
         this.closeTrainingRoom();
      }

      public function showPrebattleInvitationsFormS() : void {
         App.utils.asserter.assertNotNull(this.showPrebattleInvitationsForm,"showPrebattleInvitationsForm" + Errors.CANT_NULL);
         this.showPrebattleInvitationsForm();
      }

      public function onEscapeS() : void {
         App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
         this.onEscape();
      }
   }

}