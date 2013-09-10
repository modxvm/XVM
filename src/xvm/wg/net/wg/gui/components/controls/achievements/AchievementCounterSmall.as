package net.wg.gui.components.controls.achievements 
{
    public class AchievementCounterSmall extends net.wg.gui.components.controls.achievements.AchievementCounter
    {
        public function AchievementCounterSmall()
        {
            super();
            return;
        }

        protected override function applyData():void
        {
            super.applyData();
            if (data && data.hasOwnProperty("value") && data.value == 0) 
            {
                counterType = net.wg.gui.components.controls.achievements.AchievementCounter.NONE;
            }
            else 
            {
                counterType = net.wg.gui.components.controls.achievements.AchievementCounter.SMALL;
            }
            return;
        }

        protected override function applyLayoutChanges():void
        {
            if (counter && !(loader.width == 0) && !(loader.height == 0)) 
            {
                counter.x = _originalWidth - counter.actualWidth ^ 0;
                counter.y = _originalHeight - counter.actualHeight - counter.receiveBottomPadding() ^ 0;
                addChild(counter);
            }
            return;
        }
    }
}
