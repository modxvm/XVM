package net.wg.infrastructure.interfaces
{
   import scaleform.clik.interfaces.IUIComponent;
   import net.wg.infrastructure.interfaces.entity.IIdentifiable;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDisplayable;
   import flash.display.Sprite;
   import flash.geom.Transform;
   
   public interface IUIComponentEx extends IUIComponent, IIdentifiable, IDisposable, IDisplayable
   {
      
      function setActualSize(param1:Number, param2:Number) : void;
      
      function setActualScale(param1:Number, param2:Number) : void;
      
      function gotoAndPlay(param1:Object, param2:String = null) : void;
      
      function gotoAndStop(param1:Object, param2:String = null) : void;
      
      function get scaleX() : Number;
      
      function set scaleX(param1:Number) : void;
      
      function get scaleY() : Number;
      
      function set scaleY(param1:Number) : void;
      
      function get enableInitCallback() : Boolean;
      
      function set enableInitCallback(param1:Boolean) : void;
      
      function get name() : String;
      
      function get mouseEnabled() : Boolean;
      
      function set mouseEnabled(param1:Boolean) : void;
      
      function get mouseChildren() : Boolean;
      
      function set mouseChildren(param1:Boolean) : void;
      
      function get actualWidth() : Number;
      
      function get actualHeight() : Number;
      
      function get actualScaleX() : Number;
      
      function get actualScaleY() : Number;
      
      function set hitArea(param1:Sprite) : void;
      
      function set blendMode(param1:String) : void;
      
      function get transform() : Transform;
   }
}
