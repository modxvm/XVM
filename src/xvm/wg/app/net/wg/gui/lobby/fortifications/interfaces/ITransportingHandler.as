package net.wg.gui.lobby.fortifications.interfaces
{
   import net.wg.gui.lobby.fortifications.cmp.build.IFortBuilding;
   
   public interface ITransportingHandler
   {
      
      function onTransportingSuccess(param1:IFortBuilding, param2:IFortBuilding) : void;
      
      function onStartImporting() : void;
      
      function onStartExporting() : void;
   }
}
