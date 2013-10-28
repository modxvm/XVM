package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;


   public class NullPointerException extends WGGUIException
   {
          
      public function NullPointerException(param1:*=undefined, param2:*=undefined) {
         super(param1,param2);
      }
   }

}