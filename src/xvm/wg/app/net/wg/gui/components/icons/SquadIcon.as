package net.wg.gui.components.icons 
{
    import flash.display.*;
    import flash.text.*;
    
    public class SquadIcon extends flash.display.MovieClip
    {
        public function SquadIcon()
        {
            super();
            stop();
            return;
        }

        public function setSquad(arg1:Number):void
        {
            if (arg1 > 10) 
            {
                this.numTf.text = String(arg1 - 10);
                gotoAndStop("gold");
            }
            else if (arg1 > 0) 
            {
                this.numTf.text = String(arg1);
                gotoAndStop("silver");
            }
            else 
            {
                this.numTf.text = "";
                gotoAndStop("empty");
            }
            return;
        }

        public override function toString():String
        {
            return "[WG SquadIcon " + name + "]";
        }

        public var numTf:flash.text.TextField;
    }
}
