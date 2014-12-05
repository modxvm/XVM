package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
    
    public class JoinSortieDetailsSection extends JoinSortieSection
    {
        
        public function JoinSortieDetailsSection()
        {
            super();
            this.alertView.visible = false;
        }
        
        public var alertView:JoinSortieDetailsSectionAlertView = null;
        
        override protected function updateElements() : void
        {
            var _loc1_:LegionariesSortieVO = null;
            var _loc2_:* = false;
            if(model)
            {
                _loc1_ = LegionariesSortieVO(model);
                _loc2_ = _loc1_.isShowAlertView;
                if(_loc2_)
                {
                    updateNoRallyScreenVisibility(false);
                    updateElementsVisibility(false);
                    this.alertView.update(_loc1_.alertView);
                    this.alertView.visible = true;
                    return;
                }
                this.alertView.visible = false;
            }
            super.updateElements();
        }
        
        override protected function onDispose() : void
        {
            this.alertView.dispose();
            this.alertView = null;
            super.onDispose();
        }
    }
}
