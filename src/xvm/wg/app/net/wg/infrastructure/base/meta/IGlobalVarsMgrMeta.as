package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IGlobalVarsMgrMeta extends IEventDispatcher
    {
        
        function isDevelopmentS() : Boolean;
        
        function isShowLangaugeBarS() : Boolean;
        
        function isShowServerStatsS() : Boolean;
        
        function isChinaS() : Boolean;
        
        function isKoreaS() : Boolean;
        
        function isTutorialDisabledS() : Boolean;
        
        function setTutorialDisabledS(param1:Boolean) : void;
        
        function isTutorialRunningS() : Boolean;
        
        function isRoamingEnabledS() : Boolean;
        
        function isInRoamingS() : Boolean;
        
        function setTutorialRunningS(param1:Boolean) : void;
        
        function isFreeXpToTankmanS() : Boolean;
        
        function getLocaleOverrideS() : String;
        
        function isFortificationAvailableS() : Boolean;
        
        function isFortificationBattleAvailableS() : Boolean;
        
        function isShowTickerS() : Boolean;
        
        function isRentalsEnabledS() : Boolean;
        
        function isPotapovQuestEnabledS() : Boolean;
    }
}
