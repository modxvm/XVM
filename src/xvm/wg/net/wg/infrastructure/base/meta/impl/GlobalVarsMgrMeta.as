package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class GlobalVarsMgrMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function GlobalVarsMgrMeta()
        {
            super();
            return;
        }

        public function isDevelopmentS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isDevelopment, "isDevelopment" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isDevelopment();
        }

        public function isShowLangaugeBarS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isShowLangaugeBar, "isShowLangaugeBar" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isShowLangaugeBar();
        }

        public function isShowServerStatsS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isShowServerStats, "isShowServerStats" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isShowServerStats();
        }

        public function isChinaS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isChina, "isChina" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isChina();
        }

        public function isTutorialDisabledS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isTutorialDisabled, "isTutorialDisabled" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isTutorialDisabled();
        }

        public function setTutorialDisabledS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.setTutorialDisabled, "setTutorialDisabled" + net.wg.data.constants.Errors.CANT_NULL);
            this.setTutorialDisabled(arg1);
            return;
        }

        public function isTutorialRunningS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isTutorialRunning, "isTutorialRunning" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isTutorialRunning();
        }

        public function setTutorialRunningS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.setTutorialRunning, "setTutorialRunning" + net.wg.data.constants.Errors.CANT_NULL);
            this.setTutorialRunning(arg1);
            return;
        }

        public function isFreeXpToTankmanS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isFreeXpToTankman, "isFreeXpToTankman" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isFreeXpToTankman();
        }

        public function getLocaleOverrideS():String
        {
            App.utils.asserter.assertNotNull(this.getLocaleOverride, "getLocaleOverride" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getLocaleOverride();
        }

        public var isDevelopment:Function=null;

        public var isShowLangaugeBar:Function=null;

        public var isShowServerStats:Function=null;

        public var isChina:Function=null;

        public var isTutorialDisabled:Function=null;

        public var setTutorialDisabled:Function=null;

        public var isTutorialRunning:Function=null;

        public var setTutorialRunning:Function=null;

        public var isFreeXpToTankman:Function=null;

        public var getLocaleOverride:Function=null;
    }
}
