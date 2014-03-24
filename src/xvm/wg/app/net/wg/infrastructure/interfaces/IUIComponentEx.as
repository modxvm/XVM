package net.wg.infrastructure.interfaces
{
   import scaleform.clik.interfaces.IUIComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDisplayable;


   public interface IUIComponentEx extends IUIComponent, IDisposable, IDisplayable
   {
          
      function get enableInitCallback() : Boolean;

      function set enableInitCallback(param1:Boolean) : void;

      function setActualSize(param1:Number, param2:Number) : void;

      function setActualScale(param1:Number, param2:Number) : void;

      function get name() : String;

      function get mouseEnabled() : Boolean;

      function set mouseEnabled(param1:Boolean) : void;

      function get mouseChildren() : Boolean;

      function set mouseChildren(param1:Boolean) : void;

      function get actualWidth() : Number;

      function get actualHeight() : Number;

      function get actualScaleX() : Number;

      function get actualScaleY() : Number;
   }

}