package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.components.containers.inject.GFInjectComponent;
    import net.wg.data.constants.Errors;

    public class WTEventParamsWidgetMeta extends GFInjectComponent
    {

        public var updateWidgetLayout:Function;

        public function WTEventParamsWidgetMeta()
        {
            super();
        }

        public function updateWidgetLayoutS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.updateWidgetLayout,"updateWidgetLayout" + Errors.CANT_NULL);
            this.updateWidgetLayout(param1);
        }
    }
}
