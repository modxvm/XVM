package net.wg.gui.lobby.profile.pages.statistics.body
{
    import net.wg.gui.lobby.profile.pages.statistics.detailedStatistics.DetailedStatisticsGroupEx;
    import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
    
    public class DetailedStatisticsRootUnit extends DetailedStatisticsGroupEx
    {
        
        public function DetailedStatisticsRootUnit() {
            super();
        }
        
        override protected function configUI() : void {
            super.configUI();
            var _loc1_:Vertical100PercWidthLayout = new Vertical100PercWidthLayout();
            _loc1_.gap = 20;
            layout = _loc1_;
            unitRendererClass = App.utils.classFactory.getClass("StatisticsDashLineTextItemIRenderer_UI");
        }
        
        public function set data(param1:Object) : void {
            dataProvider = param1 as Array;
        }
        
        override public function set width(param1:Number) : void {
            super.width = param1;
            invalidateLayout();
        }
    }
}
