package net.wg.gui.components.controls.achievements 
{
    import flash.display.*;
    import net.wg.gui.components.controls.*;
    
    public class AchievementProgressBar extends net.wg.gui.components.controls.ProgressBar
    {
        public function AchievementProgressBar()
        {
            super();
            return;
        }

        protected override function applyDataChanges():void
        {
            super.applyDataChanges();
            var loc1:*=(value - minimum) / (maximum - minimum);
            var loc2:*=Math.round(_originalWidth * loc1);
            this.mcMask.width = loc2;
            if (loc2 != 0) 
            {
                this.dot.visible = true;
                this.dot.x = loc2;
            }
            else 
            {
                this.dot.x = 3;
                this.dot.visible = false;
            }
            return;
        }

        public var mcMask:flash.display.MovieClip;

        public var dot:flash.display.MovieClip;
    }
}
