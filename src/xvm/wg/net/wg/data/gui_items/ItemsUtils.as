package net.wg.data.gui_items 
{
    public class ItemsUtils extends Object
    {
        public function ItemsUtils()
        {
            super();
            return;
        }

        public static function formatFloatStr(arg1:Number):String
        {
            if (App.utils) 
                return App.utils.locale.numberWithoutZeros(arg1);
            return arg1.toString();
        }

        public static function formatIntegerStr(arg1:Number):String
        {
            if (App.utils) 
                return App.utils.locale.integer(arg1);
            return arg1.toString();
        }

        public static function floatToPercent(arg1:Number):String
        {
            arg1 = arg1 * 100;
            if (App.utils) 
                return App.utils.locale.numberWithoutZeros(arg1) + "%";
            return arg1.toString();
        }
    }
}
