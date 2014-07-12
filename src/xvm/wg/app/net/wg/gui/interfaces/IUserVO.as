package net.wg.gui.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IUserVO extends IDisposable
   {
      
      function get dbID() : Number;
   }
}
