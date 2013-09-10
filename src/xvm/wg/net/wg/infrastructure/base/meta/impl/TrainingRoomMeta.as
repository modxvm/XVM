package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class TrainingRoomMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function TrainingRoomMeta()
        {
            super();
            return;
        }

        public function showTrainingSettingsS():void
        {
            App.utils.asserter.assertNotNull(this.showTrainingSettings, "showTrainingSettings" + net.wg.data.constants.Errors.CANT_NULL);
            this.showTrainingSettings();
            return;
        }

        public function selectCommonVoiceChatS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.selectCommonVoiceChat, "selectCommonVoiceChat" + net.wg.data.constants.Errors.CANT_NULL);
            this.selectCommonVoiceChat(arg1);
            return;
        }

        public function startTrainingS():void
        {
            App.utils.asserter.assertNotNull(this.startTraining, "startTraining" + net.wg.data.constants.Errors.CANT_NULL);
            this.startTraining();
            return;
        }

        public function swapTeamsS():void
        {
            App.utils.asserter.assertNotNull(this.swapTeams, "swapTeams" + net.wg.data.constants.Errors.CANT_NULL);
            this.swapTeams();
            return;
        }

        public function changeTeamS(arg1:Number, arg2:Number):void
        {
            App.utils.asserter.assertNotNull(this.changeTeam, "changeTeam" + net.wg.data.constants.Errors.CANT_NULL);
            this.changeTeam(arg1, arg2);
            return;
        }

        public function closeTrainingRoomS():void
        {
            App.utils.asserter.assertNotNull(this.closeTrainingRoom, "closeTrainingRoom" + net.wg.data.constants.Errors.CANT_NULL);
            this.closeTrainingRoom();
            return;
        }

        public function showPrebattleInvitationsFormS():void
        {
            App.utils.asserter.assertNotNull(this.showPrebattleInvitationsForm, "showPrebattleInvitationsForm" + net.wg.data.constants.Errors.CANT_NULL);
            this.showPrebattleInvitationsForm();
            return;
        }

        public function onEscapeS():void
        {
            App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + net.wg.data.constants.Errors.CANT_NULL);
            this.onEscape();
            return;
        }

        public var showTrainingSettings:Function=null;

        public var selectCommonVoiceChat:Function=null;

        public var startTraining:Function=null;

        public var swapTeams:Function=null;

        public var changeTeam:Function=null;

        public var closeTrainingRoom:Function=null;

        public var showPrebattleInvitationsForm:Function=null;

        public var onEscape:Function=null;
    }
}
