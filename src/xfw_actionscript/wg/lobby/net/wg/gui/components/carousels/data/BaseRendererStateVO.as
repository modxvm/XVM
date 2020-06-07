package net.wg.gui.components.carousels.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class BaseRendererStateVO extends DAAPIDataClass
    {

        public var enabled:Boolean = true;

        public var selected:Boolean = true;

        public var visible:Boolean = true;

        public function BaseRendererStateVO(param1:Object)
        {
            super(param1);
        }
    }
}
