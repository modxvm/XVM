package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import flash.geom.Point;
   import scaleform.clik.controls.Button;


   public class ContentTabBar extends ButtonBarEx
   {
          
      public function ContentTabBar() {
         super();
         this.selectionIndicator.visible = false;
      }

      private static const INVALID_LAYOUT:String = "invalidLayout";

      private static const INVALID_SEPARATOR_VISIBLE:String = "invalidSeparatorVisible";

      public var selectionIndicator:MovieClip;

      public var lineMC:MovieClip;

      private var _textPadding:Number = 20;

      private var _minRendererWidth:Number = 40;

      private var _showSeparator:Boolean = false;

      private var _centerTabs:Boolean = true;

      override protected function configUI() : void {
         super.configUI();
         this.selectionIndicator.mouseChildren = this.selectionIndicator.mouseEnabled = false;
         if(selectedIndex == -1)
         {
            this.selectedIndex = 0;
         }
      }

      override protected function draw() : void {
         var _loc1_:Boolean = (isInvalid(InvalidationType.RENDERERS)) || (isInvalid(InvalidationType.DATA)) || (isInvalid(InvalidationType.SETTINGS)) || (isInvalid(InvalidationType.SIZE));
         if(_loc1_)
         {
            this.calculateRendererWidth();
         }
         super.draw();
         if(isInvalid(INVALID_SEPARATOR_VISIBLE))
         {
            this.lineMC.visible = this._showSeparator;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.lineMC.width = _originalWidth;
            this.selectionIndicator.scaleX = 1 / scaleX;
         }
         if((_loc1_) || (INVALID_LAYOUT))
         {
            if(this._centerTabs)
            {
               this.doCenterTabs();
            }
            else
            {
               container.x = 0;
            }
            this.updateSelectionIndicator();
         }
      }

      private function doCenterTabs() : void {
         container.x = _originalWidth - container.width >> 1;
      }

      override public function set selectedIndex(param1:int) : void {
         super.selectedIndex = param1;
         this.updateSelectionIndicator();
      }

      private function updateSelectionIndicator() : void {
         var _loc1_:UIComponent = null;
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         if(_selectedIndex >= 0 && _renderers.length > 0)
         {
            this.moveSelectionIndicatorToTop();
            _loc1_ = _renderers[_selectedIndex];
            _loc2_ = _loc1_.localToGlobal(new Point(0,0));
            _loc3_ = globalToLocal(_loc2_);
            this.selectionIndicator.x = _loc3_.x + _loc1_.width * container.scaleX / 2 ^ 0;
            this.selectionIndicator.visible = _loc1_.enabled;
         }
         else
         {
            this.selectionIndicator.visible = false;
         }
      }

      private function moveSelectionIndicatorToTop() : void {
         if(getChildIndex(this.selectionIndicator) != numChildren-1)
         {
            removeChild(this.selectionIndicator);
            addChild(this.selectionIndicator);
         }
      }

      private function calculateRendererWidth() : void {
         var _loc1_:Button = null;
         var _loc2_:Number = 0;
         var _loc3_:* = 0;
         while(_loc3_ < _dataProvider.length)
         {
            _loc1_ = new _itemRendererClass();
            this.populateRendererData(_loc1_,_loc3_);
            _loc1_.validateNow();
            _loc2_ = Math.max(_loc2_,_loc1_.textField.textWidth);
            _loc1_ = null;
            _loc3_++;
         }
         _buttonWidth = _loc2_ + this._textPadding * 2 ^ 0;
         _buttonWidth = Math.max(_buttonWidth,this._minRendererWidth);
      }

      override protected function populateRendererData(param1:Button, param2:uint) : void {
         if((param1.hasOwnProperty("isFirst")) && param2 == 0)
         {
            param1["isFirst"] = true;
         }
         if((param1.hasOwnProperty("isLast")) && (_dataProvider) && param2 == _dataProvider.length-1)
         {
            param1["isLast"] = true;
         }
         var _loc3_:Object = _dataProvider.requestItemAt(param2);
         if((_loc3_) && (_loc3_.hasOwnProperty("enabled")))
         {
            param1.enabled = _loc3_.enabled;
         }
         super.populateRendererData(param1,param2);
      }

      override protected function updateRenderers() : void {
         super.updateRenderers();
      }

      public function get textPadding() : Number {
         return this._textPadding;
      }

      public function set textPadding(param1:Number) : void {
         this._textPadding = param1;
         invalidate(InvalidationType.RENDERERS);
      }

      public function get minRendererWidth() : Number {
         return this._minRendererWidth;
      }

      public function set minRendererWidth(param1:Number) : void {
         this._minRendererWidth = param1;
         invalidate(InvalidationType.RENDERERS);
      }

      public function get showSeparator() : Boolean {
         return this._showSeparator;
      }

      public function set showSeparator(param1:Boolean) : void {
         this._showSeparator = param1;
         invalidate(INVALID_SEPARATOR_VISIBLE);
      }

      public function get centerTabs() : Boolean {
         return this._centerTabs;
      }

      public function set centerTabs(param1:Boolean) : void {
         this._centerTabs = param1;
         invalidate(INVALID_LAYOUT);
      }

      override protected function onDispose() : void {
         this.lineMC = null;
         this.selectionIndicator = null;
         super.onDispose();
      }
   }

}