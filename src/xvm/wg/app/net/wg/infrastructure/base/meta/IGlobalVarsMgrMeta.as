package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IGlobalVarsMgrMeta extends flash.events.IEventDispatcher
    {
        function isDevelopmentS():Boolean;

        function isShowLangaugeBarS():Boolean;

        function isShowServerStatsS():Boolean;

        function isChinaS():Boolean;

        function isTutorialDisabledS():Boolean;

        function setTutorialDisabledS(arg1:Boolean):void;

        function isTutorialRunningS():Boolean;

        function setTutorialRunningS(arg1:Boolean):void;

        function isFreeXpToTankmanS():Boolean;

        function getLocaleOverrideS():String;
    }
}
