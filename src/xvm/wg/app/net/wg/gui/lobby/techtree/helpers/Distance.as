package net.wg.gui.lobby.techtree.helpers 
{
    public class Distance extends Object
    {
        public function Distance(arg1:Number=0, arg2:Number=0)
        {
            super();
            this.start = arg1;
            this.end = arg2;
            return;
        }

        public function toString():String
        {
            return "[Distance: start = " + this.start + ", end = " + this.end + "]";
        }

        public var start:Number;

        public var end:Number;
    }
}
