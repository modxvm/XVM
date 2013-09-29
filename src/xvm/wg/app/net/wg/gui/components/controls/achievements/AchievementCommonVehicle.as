package net.wg.gui.components.controls.achievements 
{
    public class AchievementCommonVehicle extends net.wg.gui.components.controls.achievements.AchievementCommon
    {
        public function AchievementCommonVehicle()
        {
            super();
            return;
        }

        protected override function setRecordRepeatable(arg1:String):void
        {
            super.setRecordRepeatable(net.wg.gui.components.controls.achievements.AchievementCounter.GREY);
            return;
        }
    }
}
