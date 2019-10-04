package mx.core
{
    import flash.display.Bitmap;
    import mx.utils.NameUtil;
    import flash.display.BitmapData;

    public class FlexBitmap extends Bitmap
    {

        mx_internal static const VERSION:String = "4.5.1.21328";

        public function FlexBitmap(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
        {
            super(param1,param2,param3);
            try
            {
                name = NameUtil.createUniqueName(this);
                return;
            }
            catch(e:Error)
            {
                return;
            }
        }

        override public function toString() : String
        {
            return NameUtil.displayObjectToString(this);
        }
    }
}
