package net.wg.infrastructure
{
   import flash.display.Sprite;
   import __AS3__.vec.Vector;
   import flash.utils.getQualifiedClassName;


   public class BaseImporter extends Sprite
   {
          
      public function BaseImporter() {
         super();
      }

      protected final function importClasses(param1:Vector.<Class>, param2:Boolean=false) : void {
         var _loc3_:Class = null;
         if((param2) && (param1))
         {
            trace("Importing " + getQualifiedClassName(this) + ":...");
            for each (_loc3_ in param1)
            {
               trace("--" + _loc3_);
            }
         }
      }
   }

}