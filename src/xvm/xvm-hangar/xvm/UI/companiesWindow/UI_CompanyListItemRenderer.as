package xvm.UI.companiesWindow
{
    import flash.events.*;
    import xvm.hangar.components.Company.CompanyOwnerItemRenderer;

    public dynamic class UI_CompanyListItemRenderer extends CompanyListItemRendererUI
    {
        private var worker:CompanyOwnerItemRenderer;

        public function UI_CompanyListItemRenderer()
        {
            super();
            worker = new CompanyOwnerItemRenderer(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            worker.configUI();
        }

        override public function setData(data:Object):void
        {
            super.setData(data);
            worker.setData(data);
        }

        override protected function handleMouseRollOver(e:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(e);
            worker.handleMouseRollOver(e);
        }
    }
}
