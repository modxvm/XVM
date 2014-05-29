package net.wg.gui.components.popOvers
{
   import flash.geom.Point;
   import __AS3__.vec.Vector;
   import flash.geom.Rectangle;
   import net.wg.data.utilData.TwoDimensionalPadding;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.IAbstractWrapperView;


   public class SmartPopOverExternalLayout extends PopoverInternalLayout
   {
          
      public function SmartPopOverExternalLayout() {
         this._positionKeyPointPadding = new TwoDimensionalPadding();
         super();
      }

      public static function getLayoutOptions(param1:Point, param2:Vector.<Point>, param3:Point, param4:Point, param5:Rectangle, param6:TwoDimensionalPadding=null, param7:int=-1) : SmartPopOverLayoutInfo {
         var _loc18_:Point = null;
         var _loc19_:* = NaN;
         if(param6 == null)
         {
            param6 = new TwoDimensionalPadding();
         }
         var _loc8_:int = PopOverConst.ARROW_LEFT;
         var _loc9_:Point = param2[PopOverConst.ARROW_LEFT];
         var _loc10_:int = -Math.round(_loc9_.x + param6.right.x);
         var _loc11_:Point = param6.right;
         if(param7 == PopOverConst.ARROW_RIGHT || param1.x + _loc9_.x + param4.x + param6.right.x > param3.x)
         {
            _loc8_ = PopOverConst.ARROW_RIGHT;
            _loc9_ = param2[PopOverConst.ARROW_RIGHT];
            _loc10_ = Math.round(param1.x + _loc9_.x - param6.left.x);
            _loc11_ = param6.left;
         }
         var _loc12_:Number = param5.height - _loc9_.y;
         var _loc13_:int = param5.y + _loc9_.y / 2;
         var _loc14_:int = param1.y - (param5.y + param5.height) + _loc9_.y / 2;
         var _loc15_:int = param4.y - _loc13_;
         _loc15_ = _loc15_ > 0?_loc15_:0;
         var _loc16_:int = Math.round((_loc15_ + _loc11_.y) / (param3.y - _loc13_ - _loc14_) * _loc12_ + _loc9_.y / 2) + param5.y;
         var _loc17_:int = _loc16_ - _loc11_.y;
         if(param7 == PopOverConst.ARROW_LEFT || param7 == PopOverConst.ARROW_RIGHT)
         {
            return new SmartPopOverLayoutInfo(_loc8_,_loc16_,_loc10_,_loc17_);
         }
         if(param7 == PopOverConst.ARROW_TOP || param4.y <= _loc16_ - _loc11_.y)
         {
            _loc9_ = param2[PopOverConst.ARROW_TOP];
            _loc8_ = PopOverConst.ARROW_TOP;
            _loc17_ = -Math.round(_loc9_.y + param6.bottom.y);
            _loc18_ = param6.bottom;
         }
         else
         {
            if(param7 == PopOverConst.ARROW_BOTTOM || param3.y - param4.y - _loc11_.y <= _loc14_)
            {
               _loc9_ = param2[PopOverConst.ARROW_BOTTOM];
               _loc8_ = PopOverConst.ARROW_BOTTOM;
               _loc17_ = Math.round(param1.y + _loc9_.y - param6.top.y);
               _loc18_ = param6.top;
            }
         }
         if(_loc8_ == PopOverConst.ARROW_BOTTOM || _loc8_ == PopOverConst.ARROW_TOP)
         {
            _loc19_ = param1.x / 2;
            if(param4.x < _loc19_)
            {
               _loc16_ = Math.round(_loc9_.x / 2);
            }
            else
            {
               if(param3.x - param4.x < _loc19_)
               {
                  _loc16_ = Math.round(param1.x - _loc9_.x / 2);
               }
               else
               {
                  _loc16_ = Math.round(param1.x / 2);
               }
            }
            _loc10_ = _loc16_ - _loc18_.x;
         }
         return new SmartPopOverLayoutInfo(_loc8_,_loc16_,_loc10_,_loc17_);
      }

      private var _stageDimensions:Point;

      private var _positionKeyPoint:Point;

      private var _positionKeyPointPadding:TwoDimensionalPadding;

      private var _preferredLayout:int = -1;

      override public function invokeLayout() : Object {
         var _loc4_:DisplayObject = null;
         var _loc10_:SmartPopOverLayoutInfo = null;
         super.invokeLayout();
         if(this._positionKeyPoint == null || this._stageDimensions == null)
         {
            return null;
         }
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
         var _loc9_:Rectangle = new Rectangle(_loc8_.x - _loc2_.hitMc.x,_loc8_.y - _loc2_.hitMc.y,_loc8_.width - bgFormPadding.horizontal,_loc8_.height - bgFormPadding.vertical);
         _loc10_ = getLayoutOptions(_loc1_,_loc3_,this._stageDimensions,this._positionKeyPoint,_loc9_,this._positionKeyPointPadding,this._preferredLayout);
         _loc2_.arrowDirection = _loc10_.arrowDirection;
         _loc2_.arrowPosition = _loc10_.arrowPosition;
         _loc2_.x = Math.round(this.positionKeyPoint.x - _loc10_.popupPaddingLeft - _bgInternalPadding.left);
         _loc2_.y = Math.round(this.positionKeyPoint.y - _loc10_.popupPaddingTop - _bgInternalPadding.top);
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

      public function get positionKeyPointPadding() : TwoDimensionalPadding {
         return this._positionKeyPointPadding;
      }

      public function set positionKeyPointPadding(param1:TwoDimensionalPadding) : void {
         this._positionKeyPointPadding = param1;
      }

      override public function dispose() : void {
         this._stageDimensions = null;
         this._positionKeyPoint = null;
         this._positionKeyPointPadding = null;
         super.dispose();
      }

      public function get preferredLayout() : int {
         return this._preferredLayout;
      }

      public function set preferredLayout(param1:int) : void {
         this._preferredLayout = param1;
      }
   }

}