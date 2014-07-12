package net.wg.gui.lobby.profile.pages.statistics.body
{
    import net.wg.gui.components.common.containers.GroupEx;
    import net.wg.gui.lobby.profile.components.IResizableContent;
    import net.wg.gui.components.common.containers.EqualWidthHorizontalLayout;
    import flash.display.InteractiveObject;
    
    public class DetailedStatisticsView extends GroupEx implements IResizableContent
    {
        
        public function DetailedStatisticsView() {
            super();
        }
        
        override protected function configUI() : void {
            super.configUI();
            var _loc1_:EqualWidthHorizontalLayout = new EqualWidthHorizontalLayout();
            _loc1_.gap = 50;
            layout = _loc1_;
            itemRendererClass = DetailedStatisticsRootUnit;
        }
        
        public function update(param1:Object) : void {
            if(param1 is DetailedLabelDataVO)
            {
                dataProvider = DetailedLabelDataVO(param1).detailedInfoList;
            }
        }
        
        public function getComponentForFocus() : InteractiveObject {
            return null;
        }
        
        public function setViewSize(param1:Number, param2:Number) : void {
            EqualWidthHorizontalLayout(layout).availableSize = param1;
            invalidate(LAYOUT_INVALID);
        }
        
        public function set centerOffset(param1:int) : void {
        }
        
        public function get centerOffset() : int {
            return 0;
        }
        
        public function set active(param1:Boolean) : void {
        }
        
        public function get active() : Boolean {
            return false;
        }
        
        public function canShowAutomatically() : Boolean {
            return true;
        }
    }
}
