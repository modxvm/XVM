package net.wg.gui.login
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.geom.Rectangle;


   public interface ISparksManager extends IDisposable
   {
          
      function resetZone(param1:Rectangle) : void;

      function createSparks() : void;
   }

}