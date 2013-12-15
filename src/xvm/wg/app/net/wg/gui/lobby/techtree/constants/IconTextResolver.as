package net.wg.gui.lobby.techtree.constants
{
   import __AS3__.vec.Vector;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.IconText;


   public class IconTextResolver extends Object
   {

      public function IconTextResolver() {
         super();
      }

      private static var namedLabels:Vector.<String>;

      private static var iconTexts:Vector.<String>;

      public static function getFromNamedLabel(param1:String) : String {
         var _loc2_:String = Values.EMPTY_STR;
         var _loc3_:Number = namedLabels.indexOf(param1);
         if(_loc3_ > -1)
         {
            _loc2_ = iconTexts[_loc3_];
         }
         return _loc2_;
      }
   }

}