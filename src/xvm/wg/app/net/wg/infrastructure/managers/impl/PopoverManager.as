package net.wg.infrastructure.managers.impl
{
   import net.wg.infrastructure.base.meta.impl.PopoverManagerMeta;
   import net.wg.infrastructure.managers.IPopoverManager;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.display.DisplayObject;
   import net.wg.gui.components.popOvers.PopOver;
   import net.wg.infrastructure.interfaces.IAbstractPopOverView;


   public class PopoverManager extends PopoverManagerMeta implements IPopoverManager
   {
          
      public function PopoverManager(param1:Stage) {
         super();
         this._stage = param1;
      }

      private var _stage:Stage;

      private var _lastPopoverCaller:Object;

      private function stageMouseDownHandler(param1:MouseEvent) : void {
         App.utils.asserter.assertNotNull(this._lastPopoverCaller,this + " _lastPopoverCaller have not to be NULL!");
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(!_loc2_)
         {
            return;
         }
         while(_loc2_)
         {
            if(_loc2_ == this._lastPopoverCaller || _loc2_  is  PopOver || _loc2_  is  IAbstractPopOverView)
            {
               return;
            }
            _loc2_ = _loc2_.parent;
         }
         this.hide();
      }

      public function show(param1:Object, param2:String, param3:int, param4:int) : void {
         if(this._lastPopoverCaller == param1)
         {
            this.hide();
            return;
         }
         this._stage.addEventListener(MouseEvent.MOUSE_DOWN,this.stageMouseDownHandler,false,0,true);
         this._lastPopoverCaller = param1;
         requestShowPopoverS(param2,param3,param4);
      }

      public function hide() : void {
         if(this._lastPopoverCaller)
         {
            this._stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.stageMouseDownHandler);
            this._lastPopoverCaller = null;
            requestHidePopoverS();
         }
      }

      public function dispose() : void {
         this._lastPopoverCaller = null;
         this._stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.stageMouseDownHandler);
         this._stage = null;
      }
   }

}