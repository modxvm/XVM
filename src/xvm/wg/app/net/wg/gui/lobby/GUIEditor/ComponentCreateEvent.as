package net.wg.gui.lobby.GUIEditor
{
   import flash.events.Event;
   import flash.display.DisplayObject;


   public class ComponentCreateEvent extends Event
   {
          
      public function ComponentCreateEvent(param1:String, param2:DisplayObject) {
         super(param1,true,true);
         this._component = param2;
      }

      public static const COMPONENT_CREATE:String = "onComponentCreate";

      private var _component:DisplayObject = null;

      public function get component() : DisplayObject {
         return this._component;
      }

      override public function clone() : Event {
         return new ComponentCreateEvent(type,this._component);
      }
   }

}