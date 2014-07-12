package net.wg.infrastructure.interfaces
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public interface IVehicleButton extends IUIComponentEx, IResettable
   {
      
      function selectState(param1:Boolean, param2:String = null) : void;
      
      function setVehicle(param1:DAAPIDataClass) : void;
      
      function get showAlertIcon() : Boolean;
      
      function set showAlertIcon(param1:Boolean) : void;
      
      function get currentState() : int;
      
      function get vehicleCount() : int;
      
      function set vehicleCount(param1:int) : void;
      
      function get showCommanderSettings() : Boolean;
      
      function set showCommanderSettings(param1:Boolean) : void;
   }
}
