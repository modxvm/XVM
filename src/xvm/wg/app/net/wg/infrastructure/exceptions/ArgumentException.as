package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;


   public class ArgumentException extends WGGUIException
   {
          
      public function ArgumentException(param1:*=undefined, param2:*=undefined) {
         super(param1,param2);
      }
   }

}