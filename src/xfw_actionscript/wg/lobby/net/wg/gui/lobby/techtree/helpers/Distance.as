package net.wg.gui.lobby.techtree.helpers
{
    public class Distance extends Object
    {

        public var start:Number;

        public var end:Number;

        public function Distance(param1:Number = 0, param2:Number = 0)
        {
            super();
            this.start = param1;
            this.end = param2;
        }

        public function toString() : String
        {
            return "[Distance: start = " + this.start + ", end = " + this.end + "]";
        }
    }
}
