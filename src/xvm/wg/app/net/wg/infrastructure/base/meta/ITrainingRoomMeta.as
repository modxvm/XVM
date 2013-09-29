package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ITrainingRoomMeta extends flash.events.IEventDispatcher
    {
        function showTrainingSettingsS():void;

        function selectCommonVoiceChatS(arg1:Number):void;

        function startTrainingS():void;

        function swapTeamsS():void;

        function changeTeamS(arg1:Number, arg2:Number):void;

        function closeTrainingRoomS():void;

        function showPrebattleInvitationsFormS():void;

        function onEscapeS():void;

        function as_updateComment(arg1:String):void;

        function as_updateMap(arg1:Number, arg2:Number, arg3:String, arg4:String, arg5:String, arg6:String):void;

        function as_updateTimeout(arg1:String):void;

        function as_setTeam1(arg1:Array):void;

        function as_setTeam2(arg1:Array):void;

        function as_setOther(arg1:Array):void;

        function as_setInfo(arg1:Object):void;

        function as_setArenaVoipChannels(arg1:Number):void;

        function as_disableStartButton(arg1:Boolean):void;

        function as_startCoolDownVoiceChat(arg1:Number):void;

        function as_startCoolDownSetting(arg1:Number):void;

        function as_startCoolDownSwapButton(arg1:Number):void;

        function as_setPlayerStateInTeam1(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void;

        function as_setPlayerStateInTeam2(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void;

        function as_setPlayerStateInOther(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void;

        function as_setPlayerChatRosterInTeam1(arg1:Number, arg2:Number):void;

        function as_setPlayerChatRosterInTeam2(arg1:Number, arg2:Number):void;

        function as_setPlayerChatRosterInOther(arg1:Number, arg2:Number):void;
    }
}
