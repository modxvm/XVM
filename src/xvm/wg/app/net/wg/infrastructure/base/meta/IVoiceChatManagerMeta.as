package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IVoiceChatManagerMeta extends flash.events.IEventDispatcher
    {
        function isPlayerSpeakingS(arg1:uint):Boolean;

        function isVivoxS():Boolean;

        function isYYS():Boolean;

        function isVOIPEnabledS():Boolean;

        function as_onPlayerSpeak(arg1:uint, arg2:Boolean, arg3:Boolean):void;
    }
}
