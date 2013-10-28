package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;


   public class IndexOutOfBoundsException extends WGGUIException
   {
          
      public function IndexOutOfBoundsException(param1:*=undefined, param2:*=undefined) {
         super(param1,param2);
      }
   }

}