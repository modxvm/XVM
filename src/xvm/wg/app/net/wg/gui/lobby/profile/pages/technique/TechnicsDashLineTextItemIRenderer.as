package net.wg.gui.lobby.profile.pages.technique
{
    import net.wg.gui.lobby.profile.pages.statistics.body.StatisticsDashLineTextItemIRenderer;
    import flash.display.MovieClip;
    
    public class TechnicsDashLineTextItemIRenderer extends StatisticsDashLineTextItemIRenderer
    {
        
        public function TechnicsDashLineTextItemIRenderer() {
            super();
        }
        
        private static var percentSign:String = "%";
        
        private var percentSignMC:MovieClip;
        
        override protected function configUI() : void {
            super.configUI();
            width = 350;
        }
        
        override public function receiveAndSetValue(param1:*, param2:uint, param3:Function = null) : void {
            var param2:uint = 15131353;
            var _loc4_:String = param1.toString();
            var _loc5_:* = false;
            if(param1)
            {
                if(_loc4_.indexOf(percentSign) != -1)
                {
                    _loc4_ = _loc4_.split(percentSign)[0];
                    _loc5_ = true;
                }
            }
            super.receiveAndSetValue(_loc4_,param2,param3);
            if(_loc5_)
            {
                if(this.percentSignMC == null)
                {
                    this.percentSignMC = App.utils.classFactory.getComponent("TechnicueStatisticsPercentSign_UI",MovieClip);
                    addChild(this.percentSignMC);
                }
            }
            else if(this.percentSignMC)
            {
                this.percentSignMC.parent.removeChild(this.percentSignMC);
                this.percentSignMC = null;
            }
            
        }
        
        override protected function applySizeChanges() : void {
            super.applySizeChanges();
            if(this.percentSignMC)
            {
                this.percentSignMC.x = valueTextField.x + valueTextField.width;
                this.percentSignMC.y = valueTextField.y;
            }
        }
    }
}
