package net.wg.gui.lobby.profile.pages.statistics.body
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.profile.components.IResizableContent;
    import flash.text.TextField;
    import flash.display.InteractiveObject;
    import net.wg.gui.components.common.containers.EqualGapsHorizontalLayout;
    import net.wg.gui.components.common.containers.Group;
    
    public class ChartsStatisticsView extends UIComponentEx implements IResizableContent
    {
        
        public function ChartsStatisticsView()
        {
            super();
            this.group.layout = new EqualGapsHorizontalLayout();
        }
        
        public var label:TextField;
        
        public var group:ChartsStatisticsGroup;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.label.text = App.utils.locale.makeString(PROFILE.SECTION_STATISTICS_LABELS_BATTLESONTECH);
        }
        
        public function update(param1:Object) : void
        {
            if(param1 is StatisticsChartsTabDataVO)
            {
                this.group.setDossierData(StatisticsChartsTabDataVO(param1).chartsData);
            }
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }
        
        public function setViewSize(param1:Number, param2:Number) : void
        {
            this.label.width = param1;
            EqualGapsHorizontalLayout(this.group.layout).availableSize = param1;
            this.group.invalidate(Group.LAYOUT_INVALID);
        }
        
        public function set centerOffset(param1:int) : void
        {
        }
        
        public function get centerOffset() : int
        {
            return 0;
        }
        
        public function set active(param1:Boolean) : void
        {
        }
        
        public function get active() : Boolean
        {
            return false;
        }
        
        override protected function onDispose() : void
        {
            this.label = null;
            this.group.dispose();
            this.group = null;
            super.onDispose();
        }
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
    }
}
