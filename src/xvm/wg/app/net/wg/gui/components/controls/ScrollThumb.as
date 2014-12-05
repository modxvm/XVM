package net.wg.gui.components.controls
{
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    
    public class ScrollThumb extends SoundButton
    {
        
        public function ScrollThumb()
        {
            super();
        }
        
        public var icon:MovieClip;
        
        override public function gotoAndPlay(param1:Object, param2:String = null) : void
        {
            super.gotoAndPlay(param1,param2);
            if(this.icon)
            {
                this.icon.gotoAndPlay(param1);
            }
        }
        
        override public function gotoAndStop(param1:Object, param2:String = null) : void
        {
            super.gotoAndStop(param1,param2);
            if(this.icon)
            {
                this.icon.gotoAndStop(param1);
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.icon.scaleX = 1 / scaleX;
                this.icon.scaleY = 1 / scaleY;
            }
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.icon = null;
        }
    }
}
