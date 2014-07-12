package net.wg.gui.components.icons
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    
    public class SquadIcon extends MovieClip
    {
        
        public function SquadIcon() {
            super();
            stop();
        }
        
        public var numTf:TextField;
        
        public function show(param1:Boolean, param2:uint) : void {
            if(param1)
            {
                this.numTf.text = param2.toString();
                this.setLabel("gold");
            }
            else
            {
                this.numTf.text = param2.toString();
                this.setLabel("silver");
            }
        }
        
        public function hide() : void {
            this.numTf.text = "";
            this.setLabel("empty");
        }
        
        override public function toString() : String {
            return "[WG SquadIcon " + name + "]";
        }
        
        private function setLabel(param1:String) : void {
            if(param1 != currentFrameLabel)
            {
                gotoAndStop(param1);
            }
        }
    }
}
