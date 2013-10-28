package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;


   public class InfrastructureException extends WGGUIException
   {
          
      public function InfrastructureException(param1:String=undefined, param2:*=undefined) {
         super(param1,param2);
      }
   }

}