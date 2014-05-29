package net.wg.infrastructure.interfaces
{


   public interface ISoundButtonEx extends IHelpLayoutComponent, IUIComponentEx
   {
          
      function get selected() : Boolean;

      function set selected(param1:Boolean) : void;

      function get fillPadding() : Number;

      function set fillPadding(param1:Number) : void;

      function get autoRepeat() : Boolean;

      function set autoRepeat(param1:Boolean) : void;

      function get autoSize() : String;

      function set autoSize(param1:String) : void;

      function get data() : Object;

      function set data(param1:Object) : void;

      function get focusable() : Boolean;

      function set focusable(param1:Boolean) : void;

      function get helpConnectorLength() : Number;

      function set helpConnectorLength(param1:Number) : void;

      function get helpDirection() : String;

      function set helpDirection(param1:String) : void;

      function get helpText() : String;

      function set helpText(param1:String) : void;

      function get paddingHorizontal() : Number;

      function set paddingHorizontal(param1:Number) : void;

      function get soundId() : String;

      function set soundId(param1:String) : void;

      function get soundType() : String;

      function set soundType(param1:String) : void;

      function get toggle() : Boolean;

      function set toggle(param1:Boolean) : void;

      function get tooltip() : String;

      function set tooltip(param1:String) : void;

      function set label(param1:String) : void;

      function get label() : String;
   }

}