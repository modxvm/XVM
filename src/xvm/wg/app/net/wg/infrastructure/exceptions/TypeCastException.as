package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;


   public class TypeCastException extends WGGUIException
   {
          
      public function TypeCastException(param1:*=undefined, param2:*=undefined) {
         super(param1,param2);
      }
   }

}