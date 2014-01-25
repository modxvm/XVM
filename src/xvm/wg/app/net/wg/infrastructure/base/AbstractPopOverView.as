package net.wg.infrastructure.base
{
   import net.wg.infrastructure.base.meta.impl.PopOverViewMeta;
   import net.wg.infrastructure.interfaces.IAbstractPopOverView;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.components.popOvers.PopOver;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.interfaces.IManagedContent;


   public class AbstractPopOverView extends PopOverViewMeta implements IAbstractPopOverView
   {
          
      public function AbstractPopOverView() {
         super();
      }

      private static const ARROW_DIRECTION_INV:String = "arrowDirectionInvalid";

      private static const ARROW_POSITION_INV:String = "arrowPositionInvalid";

      private var _wrapper:IWrapper;

      private var _arrowDirection:uint = 0;

      private var _arrowPosition:int = 0;

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.SIZE)) && (this._wrapper))
         {
            PopOver(this._wrapper).invalidateLayout();
         }
         if((isInvalid(ARROW_DIRECTION_INV)) && (this._wrapper))
         {
            PopOver(this._wrapper).arrowDirection = this._arrowDirection;
            invalidate(ARROW_DIRECTION_INV);
         }
         if((isInvalid(ARROW_POSITION_INV)) && (this._wrapper))
         {
            PopOver(this._wrapper).arrowPosition = this._arrowPosition;
         }
      }

      public function get arrowDirection() : uint {
         return this._arrowDirection;
      }

      public function set arrowDirection(param1:uint) : void {
         if(this._arrowDirection != param1)
         {
            this._arrowDirection = param1;
            invalidate(ARROW_DIRECTION_INV);
         }
      }

      public function get arrowPosition() : int {
         return this._arrowPosition;
      }

      public function set arrowPosition(param1:int) : void {
         this._arrowPosition = param1;
         invalidate(ARROW_POSITION_INV);
      }

      public function as_setArrowDirection(param1:Number) : void {
         this.arrowDirection = param1;
      }

      public function as_setArrowPosition(param1:Number) : void {
         this.arrowPosition = param1;
      }

      public function get wrapper() : IWrapper {
         return this._wrapper;
      }

      public function set wrapper(param1:IWrapper) : void {
         this._wrapper = param1;
         invalidateSize();
         invalidate(ARROW_DIRECTION_INV);
      }

      override public function handleInput(param1:InputEvent) : void {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            App.popoverMgr.hide();
         }
      }

      public function get wrapperLinkage() : String {
         return Linkages.SMART_POPOVER;
      }

      override public function get containerContent() : IManagedContent {
         return this._wrapper;
      }
   }

}