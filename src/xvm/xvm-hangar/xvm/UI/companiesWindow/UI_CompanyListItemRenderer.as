package xvm.UI.companiesWindow
{
    import com.xvm.*;
    import xvm.hangar.components.BattleLoading.*;

    public class UI_CompanyListItemRenderer extends CompanyListItemRendererUI
    {
        //private var worker:BattleLoadingItemRenderer;

        public function UI_CompanyListItemRenderer()
        {
            //Logger.add("UI_CompanyListItemRenderer::ctor()");
            super();
            //worker = new BattleLoadingItemRenderer(this);
        }

        override public function setData(data:Object):void
        {
            //Logger.add("UI_CompanyListItemRenderer::setData()");
            super.setData(data);
            //worker.setData(data);
        }

        override protected function draw():void
        {
            //Logger.add("UI_CompanyListItemRenderer::draw()");
            super.draw();
            //worker.draw();
        }
    }
}
