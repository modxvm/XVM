package fl.motion.easing
{
    public class Back extends Object
    {

        public function Back()
        {
            super();
        }

        public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0) : Number
        {
            if(!param5)
            {
                var param5:Number = 1.70158;
            }
            return param3 * (param1 = param1 / param4) * param1 * ((param5 + 1) * param1 - param5) + param2;
        }

        public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0) : Number
        {
            if(!param5)
            {
                var param5:Number = 1.70158;
            }
            return param3 * ((param1 = param1 / param4 - 1) * param1 * ((param5 + 1) * param1 + param5) + 1) + param2;
        }

        public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0) : Number
        {
            if(!param5)
            {
                var param5:Number = 1.70158;
            }
            if((param1 = param1 / (param4 / 2)) < 1)
            {
                return param3 / 2 * param1 * param1 * (((param5 = param5 * 1.525) + 1) * param1 - param5) + param2;
            }
            return param3 / 2 * ((param1 = param1 - 2) * param1 * (((param5 = param5 * 1.525) + 1) * param1 + param5) + 2) + param2;
        }
    }
}
