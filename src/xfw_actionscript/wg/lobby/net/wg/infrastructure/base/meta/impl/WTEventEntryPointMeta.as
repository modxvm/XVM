package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;

    public class WTEventEntryPointMeta extends BaseDAAPIComponent
    {

        public var onEntryClick:Function;

        public function WTEventEntryPointMeta()
        {
            super();
        }

        public function onEntryClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onEntryClick,"onEntryClick" + Errors.CANT_NULL);
            this.onEntryClick();
        }
    }
}
