package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.utils.IFocusHandler;
   import scaleform.clik.managers.FocusHandler;
   import flash.display.Stage;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.gfx.FocusManager;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
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
         this.assertIfParentHasNoModalFocus(param1);
         this._focusHandler.setFocus(param1,param2,param3);
      }

      private function assertIfParentHasNoModalFocus(param1:InteractiveObject) : void {
         var _loc3_:* = false;
         var _loc4_:IWindow = null;
         var _loc5_:String = null;
         var _loc2_:InteractiveObject = param1;
         if(_loc2_ != null)
         {
            App.utils.asserter.assertNotNull(FocusManager.getModalClip(),"current modal focus " + Errors.CANT_NULL);
            _loc3_ = false;
            _loc4_ = null;
            while(_loc2_ != null)
            {
               if(_loc2_  is  IAbstractWindowView)
               {
                  _loc4_ = IAbstractWindowView(_loc2_).window;
               }
               if(FocusManager.getModalClip() == _loc2_)
               {
                  _loc3_ = true;
                  break;
               }
               _loc2_ = _loc2_.parent;
            }
            if(!_loc3_ && !(_loc4_ == null))
            {
               _loc3_ = FocusManager.getModalClip() == _loc4_;
            }
            _loc5_ = "one of parents of \"" + param1 + "\" must have a modal focus!";
            if(!_loc3_)
            {
               DebugUtils.LOG_DEBUG(_loc5_);
            }
         }
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