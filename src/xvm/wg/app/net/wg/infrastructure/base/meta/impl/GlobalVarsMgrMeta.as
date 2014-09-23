package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIModule;
    import net.wg.data.constants.Errors;
    
    public class GlobalVarsMgrMeta extends BaseDAAPIModule
    {
        
        public function GlobalVarsMgrMeta()
        {
            super();
        }
        
        public var isDevelopment:Function = null;
        
        public var isShowLangaugeBar:Function = null;
        
        public var isShowServerStats:Function = null;
        
        public var isShowServersList:Function = null;
        
        public var isChina:Function = null;
        
        public var isKorea:Function = null;
        
        public var isTutorialDisabled:Function = null;
        
        public var setTutorialDisabled:Function = null;
        
        public var isTutorialRunning:Function = null;
        
        public var isRoamingEnabled:Function = null;
        
        public var isInRoaming:Function = null;
        
        public var setTutorialRunning:Function = null;
        
        public var isFreeXpToTankman:Function = null;
        
        public var getLocaleOverride:Function = null;
        
        public var isFortificationAvailable:Function = null;
        
        public var isFortificationBattleAvailable:Function = null;
        
        public var isShowTicker:Function = null;
        
        public function isDevelopmentS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isDevelopment,"isDevelopment" + Errors.CANT_NULL);
            return this.isDevelopment();
        }
        
        public function isShowLangaugeBarS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isShowLangaugeBar,"isShowLangaugeBar" + Errors.CANT_NULL);
            return this.isShowLangaugeBar();
        }
        
        public function isShowServerStatsS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isShowServerStats,"isShowServerStats" + Errors.CANT_NULL);
            return this.isShowServerStats();
        }
        
        public function isShowServersListS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isShowServersList,"isShowServersList" + Errors.CANT_NULL);
            return this.isShowServersList();
        }
        
        public function isChinaS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isChina,"isChina" + Errors.CANT_NULL);
            return this.isChina();
        }
        
        public function isKoreaS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isKorea,"isKorea" + Errors.CANT_NULL);
            return this.isKorea();
        }
        
        public function isTutorialDisabledS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isTutorialDisabled,"isTutorialDisabled" + Errors.CANT_NULL);
            return this.isTutorialDisabled();
        }
        
        public function setTutorialDisabledS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setTutorialDisabled,"setTutorialDisabled" + Errors.CANT_NULL);
            this.setTutorialDisabled(param1);
        }
        
        public function isTutorialRunningS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isTutorialRunning,"isTutorialRunning" + Errors.CANT_NULL);
            return this.isTutorialRunning();
        }
        
        public function isRoamingEnabledS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isRoamingEnabled,"isRoamingEnabled" + Errors.CANT_NULL);
            return this.isRoamingEnabled();
        }
        
        public function isInRoamingS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isInRoaming,"isInRoaming" + Errors.CANT_NULL);
            return this.isInRoaming();
        }
        
        public function setTutorialRunningS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setTutorialRunning,"setTutorialRunning" + Errors.CANT_NULL);
            this.setTutorialRunning(param1);
        }
        
        public function isFreeXpToTankmanS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isFreeXpToTankman,"isFreeXpToTankman" + Errors.CANT_NULL);
            return this.isFreeXpToTankman();
        }
        
        public function getLocaleOverrideS() : String
        {
            App.utils.asserter.assertNotNull(this.getLocaleOverride,"getLocaleOverride" + Errors.CANT_NULL);
            return this.getLocaleOverride();
        }
        
        public function isFortificationAvailableS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isFortificationAvailable,"isFortificationAvailable" + Errors.CANT_NULL);
            return this.isFortificationAvailable();
        }
        
        public function isFortificationBattleAvailableS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isFortificationBattleAvailable,"isFortificationBattleAvailable" + Errors.CANT_NULL);
            return this.isFortificationBattleAvailable();
        }
        
        public function isShowTickerS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isShowTicker,"isShowTicker" + Errors.CANT_NULL);
            return this.isShowTicker();
        }
    }
}
