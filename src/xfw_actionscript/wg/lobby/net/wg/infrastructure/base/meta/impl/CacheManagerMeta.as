package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIModule;
    import net.wg.data.constants.Errors;

    public class CacheManagerMeta extends BaseDAAPIModule
    {

        public var getSettings:Function;

        public function CacheManagerMeta()
        {
            super();
        }

        public function getSettingsS() : Object
        {
            App.utils.asserter.assertNotNull(this.getSettings,"getSettings" + Errors.CANT_NULL);
            return this.getSettings();
        }
    }
}
