package net.wg.gui.components.controls.achievements
{
    public class AchievementCommonVehicle extends AchievementCommon
    {
        
        public function AchievementCommonVehicle()
        {
            super();
        }
        
        override protected function setRecordRepeatable(param1:String) : void
        {
            super.setRecordRepeatable(AchievementCounter.GREY);
        }
    }
}
