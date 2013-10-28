package net.wg.gui.cyberSport.controls.events
{
   import flash.events.Event;


   public class VehicleSelectorEvent extends Event
   {
          
      public function VehicleSelectorEvent(param1:String, param2:Array, param3:Boolean=false, param4:Boolean=false, param5:Boolean=false) {
         super(param1,param3,param4);
         this.selectedDescriptors = param2;
         this.forceSelect = param5;
      }

      public static const SELECTION_CHANGED:String = "selectionChanged";

      public var selectedDescriptors:Array;

      public var forceSelect:Boolean = false;
   }

}