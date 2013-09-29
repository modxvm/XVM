package scaleform.clik.utils 
{
    public class Padding extends Object
    {
        public function Padding(... rest)
        {
            super();
            var loc1:*=rest.length;
            switch (loc1) 
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    this.left = loc1 = Number(rest[0]);
                    this.bottom = loc1 = loc1;
                    this.right = loc1 = loc1;
                    this.top = loc1;
                    break;
                }
                case 2:
                {
                    this.bottom = loc1 = Number(rest[0]);
                    this.top = loc1;
                    this.left = loc1 = Number(rest[1]);
                    this.right = loc1;
                    break;
                }
                case 4:
                {
                    this.top = Number(rest[0]);
                    this.right = Number(rest[1]);
                    this.bottom = Number(rest[2]);
                    this.left = Number(rest[3]);
                    break;
                }
                default:
                {
                    throw new Error("Padding can not have " + rest.length + " values");
                }
            }
            return;
        }

        public function get vertical():Number
        {
            return this.top + this.bottom;
        }

        public function get horizontal():Number
        {
            return this.left + this.right;
        }

        public function toString():String
        {
            return "[Padding top=" + this.top + " bottom=" + this.bottom + " left=" + this.left + " right=" + this.right + "]";
        }

        public var top:Number=0;

        public var bottom:Number=0;

        public var left:Number=0;

        public var right:Number=0;
    }
}
