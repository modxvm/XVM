package net.wg.gui.lobby.profile.components
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Graphics;
   import scaleform.clik.constants.InvalidationType;


   public class DashLine extends UIComponent
   {
          
      public function DashLine() {
         this.maskObj = new Sprite();
         super();
      }

      private static const REDRAW_INV:String = "redrawInv";

      public var background:MovieClip;

      private var maskObj:Sprite;

      private var _gap:uint = 2;

      private var _dashLength:uint = 1;

      override protected function configUI() : void {
         super.configUI();
         addChild(this.maskObj);
         this.background.mask = this.maskObj;
      }

      override protected function draw() : void {
         var _loc1_:Graphics = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.background.width = width;
            invalidate(REDRAW_INV);
         }
         if(isInvalid(REDRAW_INV))
         {
            _loc1_ = this.maskObj.graphics;
            _loc1_.clear();
            _loc1_.beginFill(0);
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc2_ < _width)
            {
               _loc4_ = _loc2_ + this._dashLength;
               if(_loc4_ <= _width)
               {
                  _loc3_ = this._dashLength;
               }
               else
               {
                  _loc3_ = _width - _loc4_;
               }
               _loc1_.drawRect(_loc2_,0,_loc3_,_height);
               _loc2_ = _loc2_ + (_loc3_ + this._gap);
            }
         }
      }

      public function get gap() : uint {
         return this._gap;
      }

      public function set gap(param1:uint) : void {
         this._gap = param1;
         invalidate(REDRAW_INV);
      }

      public function get dashLength() : uint {
         return this._dashLength;
      }

      public function set dashLength(param1:uint) : void {
         this._dashLength = param1;
         invalidate(REDRAW_INV);
      }

      override public function dispose() : void {
         this.background.mask = null;
         this.background = null;
         this.maskObj = null;
         super.dispose();
      }
   }

}