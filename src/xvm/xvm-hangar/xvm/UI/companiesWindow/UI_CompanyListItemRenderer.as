package xvm.UI.companiesWindow
{
    import com.xvm.*;
    import flash.events.Event;
    import xvm.hangar.components.BattleLoading.*;
    import xvm.hangar.components.Company.CompanyOwnerItemRenderer;

    public class UI_CompanyListItemRenderer extends CompanyListItemRendererUI
    {
        private var worker:CompanyOwnerItemRenderer;

        public function UI_CompanyListItemRenderer()
        {
            //Logger.add("UI_CompanyListItemRenderer::ctor()");
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
            //Logger.add("UI_CompanyListItemRenderer::setData()");
            super.setData(data);
            worker.setData(data);
        }
    }
}
