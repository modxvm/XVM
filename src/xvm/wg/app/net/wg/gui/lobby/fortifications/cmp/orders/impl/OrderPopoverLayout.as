package net.wg.gui.lobby.fortifications.cmp.orders.impl
{
   import net.wg.gui.components.popOvers.SmartPopOverExternalLayout;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import net.wg.gui.components.popOvers.SmartPopOver;
   import net.wg.gui.components.popOvers.PopOverConst;
   import net.wg.gui.components.popOvers.SmartPopOverLayoutInfo;
   
   public class OrderPopoverLayout extends SmartPopOverExternalLayout
   {
      
      public function OrderPopoverLayout(param1:Point, param2:Point) {
         super();
         this.stageDimensions = param1;
         this.positionKeyPoint = param2;
      }
      
      override public function invokeLayout() : Object {
         var _loc4_:DisplayObject = null;
         super.invokeLayout();
         var _loc1_:Point = new Point();
         var _loc2_:SmartPopOver = SmartPopOver(target);
         _loc1_.x = _loc2_.width;
         _loc1_.y = _loc2_.height;
         var _loc3_:Vector.<Point> = new Vector.<Point>(4);
         var _loc5_:Vector.<DisplayObject> = _loc2_.getArrowsList();
         var _loc6_:uint = _loc5_.length;
         var _loc7_:* = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_ = _loc5_[_loc7_];
            _loc3_[_loc7_] = new Point(_loc4_.width,_loc4_.height);
            _loc7_++;
         }
         var _loc8_:Point = _loc3_[PopOverConst.ARROW_BOTTOM];
         var _loc9_:int = PopOverConst.ARROW_BOTTOM;
         var _loc10_:int = Math.round(_loc1_.y + _loc8_.y);
         var _loc11_:Number = _loc1_.x / 2;
         var _loc12_:* = 0;
         if(positionKeyPoint.x < _loc11_)
         {
            _loc12_ = Math.round(_loc8_.x / 2);
         }
         else if(stageDimensions.x - positionKeyPoint.x < _loc11_)
         {
            _loc12_ = Math.round(_loc1_.x - _loc8_.x / 2);
         }
         else
         {
            _loc12_ = Math.round(_loc1_.x / 2);
         }
         
         var _loc13_:SmartPopOverLayoutInfo = new SmartPopOverLayoutInfo(_loc9_,_loc12_,_loc12_,_loc10_);
         _loc2_.arrowDirection = _loc13_.arrowDirection;
         _loc2_.arrowPosition = _loc13_.arrowPosition;
         _loc2_.x = positionKeyPoint.x - _loc13_.popupPaddingLeft - _bgInternalPadding.left;
         _loc2_.y = positionKeyPoint.y - _loc13_.popupPaddingTop - _bgInternalPadding.top;
         updateArrowPosition(_loc2_,_loc13_.arrowDirection,_loc13_.arrowPosition);
         return _loc13_;
      }
   }
}
