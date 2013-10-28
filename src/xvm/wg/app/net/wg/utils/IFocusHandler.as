package net.wg.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.Stage;
   import flash.display.InteractiveObject;
   import scaleform.clik.ui.InputDetails;


   public interface IFocusHandler extends IDisposable
   {
          
      function set stage(param1:Stage) : void;

      function getFocus(param1:uint) : InteractiveObject;

      function setFocus(param1:InteractiveObject, param2:uint=0, param3:Boolean=false) : void;

      function input(param1:InputDetails) : void;
   }

}