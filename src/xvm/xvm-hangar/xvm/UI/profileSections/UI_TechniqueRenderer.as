package xvm.UI.profileSections
{
    import com.xvm.*;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import xvm.hangar.components.BattleLoading.*;
    import xvm.hangar.components.Company.CompanyOwnerItemRenderer;

    public class UI_TechniqueRenderer extends TechniqueRenderer_UI
    {
        //private var worker:CompanyOwnerItemRenderer;

        public function UI_TechniqueRenderer()
        {
            //Logger.add("UI_TechniqueRenderer::ctor()");
            super();
            //worker = new CompanyOwnerItemRenderer(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            //worker.configUI();
        }

        override public function setData(data:Object):void
        {
            //Logger.add("UI_TechniqueRenderer::setData()");
            super.setData(data);
            //worker.setData(data);
        }

        /*override protected function handleMouseRollOver(e:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(e);
            worker.handleMouseRollOver(e);
        }*/
    }
}
