package mx.core
{
   import flash.display.Bitmap;
   import mx.utils.NameUtil;
   import flash.display.BitmapData;

   use namespace mx_internal;

   public class FlexBitmap extends Bitmap
   {
          
      public function FlexBitmap(param1:BitmapData=null, param2:String=undefined, param3:Boolean=false) {
         super(param1,param2,param3);
         try
         {
            name = NameUtil.createUniqueName(this);
         }
         catch(e:Error)
         {
         }
      }

      mx_internal  static const VERSION:String = "4.5.1.21328";

      override public function toString() : String {
         return NameUtil.displayObjectToString(this);
      }
   }

}