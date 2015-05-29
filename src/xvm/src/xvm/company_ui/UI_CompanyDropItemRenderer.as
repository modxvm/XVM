/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.company_ui
{
    import flash.events.*;
    import xvm.company_ui.renderers.*;

    public dynamic class UI_CompanyDropItemRenderer extends CompanyDropItemRendererUI
    {
        private var worker:CompanyDropItemRenderer;

        public function UI_CompanyDropItemRenderer()
        {
            super();
            worker = new CompanyDropItemRenderer(this);
        }

        override public function setData(data:Object):void
        {
            super.setData(data);
            worker.setData(data);
        }

        override protected function handleMouseRollOver(e:MouseEvent):void
        {
            super.handleMouseRollOver(e);
            worker.handleMouseRollOver(e);
        }

        override protected function handleMouseRollOut(e:MouseEvent):void
        {
            super.handleMouseRollOut(e);
            worker.handleMouseRollOut(e);
        }
    }
}
