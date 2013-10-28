package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.utils.IFocusHandler;
   import scaleform.clik.managers.FocusHandler;
   import flash.display.Stage;
   import flash.display.InteractiveObject;
   import scaleform.clik.ui.InputDetails;


   public class FocusHandlerEx extends Object implements IFocusHandler
   {
          
      public function FocusHandlerEx() {
         super();
         this._focusHandler = FocusHandler.getInstance();
      }

      private var _focusHandler:FocusHandler = null;

      public function set stage(param1:Stage) : void {
         this._focusHandler.stage = param1;
      }

      public function getFocus(param1:uint) : InteractiveObject {
         return this._focusHandler.getFocus(param1);
      }

      public function setFocus(param1:InteractiveObject, param2:uint=0, param3:Boolean=false) : void {
         this._focusHandler.setFocus(param1,param2,param3);
      }

      public function input(param1:InputDetails) : void {
         this._focusHandler.input(param1);
      }

      public function dispose() : void {
         this._focusHandler.setFocus(null);
         this._focusHandler = null;
      }
   }

}