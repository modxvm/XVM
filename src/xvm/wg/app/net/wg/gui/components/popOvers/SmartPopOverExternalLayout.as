package net.wg.gui.components.popOvers
{
   import flash.geom.Point;
   import __AS3__.vec.Vector;
   import flash.geom.Rectangle;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.IAbstractWrapperView;


   public class SmartPopOverExternalLayout extends PopoverInternalLayout
   {
          
      public function SmartPopOverExternalLayout() {
         super();
      }

      public static function getLayoutOptions(param1:Point, param2:Vector.<Point>, param3:Point, param4:Point, param5:Rectangle) : SmartPopOverLayoutInfo {
         var _loc15_:* = NaN;
         var _loc6_:int = PopOverConst.ARROW_LEFT;
         var _loc7_:Point = param2[PopOverConst.ARROW_LEFT];
         var _loc8_:int = -_loc7_.x;
         if(param1.x + _loc7_.x + param4.x > param3.x)
         {
            _loc6_ = PopOverConst.ARROW_RIGHT;
            _loc7_ = param2[PopOverConst.ARROW_RIGHT];
            _loc8_ = param1.x + _loc7_.x;
         }
         var _loc9_:Number = param5.height - _loc7_.y;
         var _loc10_:int = param5.y + _loc7_.y / 2;
         var _loc11_:int = param1.y - (param5.y + param5.height) + _loc7_.y / 2;
         var _loc12_:int = param4.y - _loc10_;
         _loc12_ = _loc12_ > 0?_loc12_:0;
         var _loc13_:int = Math.round(_loc12_ / (param3.y - _loc10_ - _loc11_) * _loc9_ + _loc7_.y / 2) + param5.y;
         var _loc14_:int = _loc13_;
         if(param4.y <= _loc13_)
         {
            _loc7_ = param2[PopOverConst.ARROW_TOP];
            _loc6_ = PopOverConst.ARROW_TOP;
            _loc14_ = -Math.round(_loc7_.y);
         }
         else
         {
            if(param3.y - param4.y <= _loc11_)
            {
               _loc7_ = param2[PopOverConst.ARROW_BOTTOM];
               _loc6_ = PopOverConst.ARROW_BOTTOM;
               _loc14_ = Math.round(param1.y + _loc7_.y);
            }
         }
         if(_loc6_ == PopOverConst.ARROW_BOTTOM || _loc6_ == PopOverConst.ARROW_TOP)
         {
            _loc15_ = param1.x / 2;
            if(param4.x < _loc15_)
            {
               _loc13_ = Math.round(_loc7_.x / 2);
            }
            else
            {
               if(param3.x - param4.x < _loc15_)
               {
                  _loc13_ = Math.round(param1.x - _loc7_.x / 2);
               }
               else
               {
                  _loc13_ = Math.round(param1.x / 2);
               }
            }
            _loc8_ = _loc13_;
         }
         return new SmartPopOverLayoutInfo(_loc6_,_loc13_,_loc8_,_loc14_);
      }

      private var _stageDimensions:Point;

      private var _positionKeyPoint:Point;

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
         var _loc8_:IAbstractWrapperView = _loc2_.wrapperContent;
         var _loc9_:Rectangle = new Rectangle(_loc8_.x - _loc2_.hitMc.x,_loc8_.y - _loc2_.hitMc.y,_loc8_.width,_loc8_.height);
         var _loc10_:SmartPopOverLayoutInfo = getLayoutOptions(_loc1_,_loc3_,this._stageDimensions,this._positionKeyPoint,_loc9_);
         _loc2_.arrowDirection = _loc10_.arrowDirection;
         _loc2_.arrowPosition = _loc10_.arrowPosition;
         _loc2_.x = this.positionKeyPoint.x - _loc10_.popupPaddingLeft - _bgInternalPadding.left;
         _loc2_.y = this.positionKeyPoint.y - _loc10_.popupPaddingTop - _bgInternalPadding.top;
         updateArrowPosition(_loc2_,_loc10_.arrowDirection,_loc10_.arrowPosition);
         return _loc10_;
      }

      public function set stageDimensions(param1:Point) : void {
         this._stageDimensions = param1;
      }

      public function set positionKeyPoint(param1:Point) : void {
         this._positionKeyPoint = param1;
      }

      public function get stageDimensions() : Point {
         return this._stageDimensions;
      }

      public function get positionKeyPoint() : Point {
         return this._positionKeyPoint;
      }
   }

}