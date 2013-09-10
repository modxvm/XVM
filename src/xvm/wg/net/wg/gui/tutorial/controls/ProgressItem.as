package net.wg.gui.tutorial.controls 
{
    import flash.display.*;
    
    public class ProgressItem extends flash.display.MovieClip
    {
        public function ProgressItem()
        {
            super();
            return;
        }

        public function get phaseFrame():int
        {
            return this.lineMC.currentFrame;
        }

        public function setPhase(arg1:String):void
        {
            var loc1:*=this.phaseFrame;
            this.lineMC.gotoAndStop(arg1);
            if (loc1 != this.phaseFrame) 
                this.highlight();
            return;
        }

        public function highlight():void
        {
            gotoAndPlay(1);
            return;
        }

        public var lineMC:flash.display.MovieClip;
    }
}
