package net.wg.gui.components.popOvers
{
   import net.wg.infrastructure.base.BaseLayout;
   import flash.geom.Point;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.interfaces.IUIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   
   public class PopoverInternalLayout extends BaseLayout
   {
      
      public function PopoverInternalLayout() {
         this._buttonPadding = new Point(5,5);
         this._bgFormPadding = new Padding();
         this._bgInternalPadding = new Padding(59);
         this._bgFormInternalPadding = new Padding(16,0,20,0);
         super();
         this._contentPadding = new PopoverContentPadding();
         this._contentPadding.top = 7;
         this._contentPadding.right = 0;
         this._contentPadding.bottom = 6;
         this._contentPadding.left = 0;
         this._contentPadding.titleTop = 2;
      }
      
      private var _buttonPadding:Point;
      
      private var _contentPadding:PopoverContentPadding;
      
      private var _bgFormPadding:Padding;
      
      protected const _bgInternalPadding:Padding;
      
      protected var _bgFormInternalPadding:Padding;
      
      override public function invokeLayout() : Object {
         var _loc1_:PopOver = null;
         var _loc2_:IUIComponent = null;
         var _loc3_:TextField = null;
         var _loc4_:* = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         _loc1_ = PopOver(target);
         if(_loc1_)
         {
            _loc2_ = _loc1_.wrapperContent;
            _loc3_ = _loc1_.titleTextField;
            if(_loc1_.title != "")
            {
               _loc4_ = _loc3_.y + _loc3_.height + this._contentPadding.titleTop;
            }
            else
            {
               _loc4_ = this._bgInternalPadding.top + this._contentPadding.top;
            }
            _loc2_.x = this._contentPadding.left + this._bgInternalPadding.left;
            _loc2_.y = _loc4_;
            _loc5_ = _loc1_.bgForm;
            _loc5_.x = _loc2_.x + this._bgFormPadding.left;
            _loc5_.y = _loc2_.y + this._bgFormPadding.top - this._bgFormInternalPadding.top;
            _loc5_.width = _loc2_.width - this._bgFormPadding.horizontal + this._bgFormInternalPadding.left + this._bgFormInternalPadding.right;
            _loc5_.height = _loc2_.height - this._bgFormPadding.vertical + this._bgFormInternalPadding.top + this._bgFormInternalPadding.bottom;
            _loc6_ = _loc1_.background;
            _loc6_.width = this._bgInternalPadding.left + this._contentPadding.left + _loc2_.width + this._contentPadding.right + this._bgInternalPadding.right;
            _loc6_.height = _loc4_ + _loc2_.height + this._contentPadding.bottom + this._bgInternalPadding.bottom;
            _loc7_ = _loc1_.hitMc;
            _loc7_.x = this._bgInternalPadding.left;
            _loc7_.y = this._bgInternalPadding.top;
            _loc7_.width = _loc6_.width - this._bgInternalPadding.left - this._bgInternalPadding.right;
            _loc7_.height = _loc6_.height - this._bgInternalPadding.top - this._bgInternalPadding.bottom;
            if(_loc1_.isCloseBtnVisible)
            {
               if(_loc1_.title != "")
               {
                  _loc1_.closeBtn.x = _loc7_.x + _loc7_.width - _loc1_.closeBtn.width - this._buttonPadding.x;
                  _loc1_.closeBtn.y = _loc7_.y + this._buttonPadding.y;
               }
               else
               {
                  _loc1_.closeBtn.x = _loc5_.x + _loc5_.width - _loc1_.closeBtn.width - this._buttonPadding.x;
                  _loc1_.closeBtn.y = _loc4_ + this._buttonPadding.y;
               }
            }
            _loc8_ = _loc1_.arrowPosition;
            _loc9_ = _loc1_.arrowPosition;
            this.updateArrowPosition(_loc1_,_loc9_,_loc8_);
         }
         return null;
      }
      
      protected function updateArrowPosition(param1:PopOver, param2:int, param3:int) : void {
         if(param2 == PopOverConst.ARROW_LEFT)
         {
            param1.arrowLeft.y = param3 + this._bgInternalPadding.top;
         }
         else if(param2 == PopOverConst.ARROW_RIGHT)
         {
            param1.arrowRight.y = param3 + this._bgInternalPadding.top;
            param1.arrowRight.x = this._bgInternalPadding.left + param1.width;
         }
         else if(param2 == PopOverConst.ARROW_TOP)
         {
            param1.arrowTop.x = param3 + this._bgInternalPadding.left;
         }
         else if(param2 == PopOverConst.ARROW_BOTTOM)
         {
            param1.arrowBottom.x = param3 + this._bgInternalPadding.left;
            param1.arrowBottom.y = this._bgInternalPadding.top + param1.height;
         }
         
         
         
      }
      
      public function get contentPadding() : PopoverContentPadding {
         return this._contentPadding;
      }
      
      public function set contentPadding(param1:PopoverContentPadding) : void {
         this._contentPadding = param1;
      }
      
      public function get bgInternalPadding() : Padding {
         return this._bgInternalPadding;
      }
      
      public function get bgFormInternalPadding() : Padding {
         return this._bgFormInternalPadding;
      }
      
      public function get bgFormPadding() : Padding {
         return this._bgFormPadding;
      }
      
      public function set bgFormPadding(param1:Padding) : void {
         this._bgFormPadding = param1;
      }
      
      public function get buttonPadding() : Point {
         return this._buttonPadding;
      }
      
      public function set buttonPadding(param1:Point) : void {
         this._buttonPadding = param1;
      }
   }
}
