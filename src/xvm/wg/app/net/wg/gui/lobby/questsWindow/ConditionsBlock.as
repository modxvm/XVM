package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.lobby.questsWindow.data.ConditionsVO;
   import __AS3__.vec.Vector;
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;


   public class ConditionsBlock extends UIComponent
   {
          
      public function ConditionsBlock() {
         super();
         this._elements = new Vector.<ConditionElement>();
      }

      private static const PADDING:int = 20;

      public var titleTF:TextField;

      private var _data:ConditionsVO = null;

      private var _elements:Vector.<ConditionElement> = null;

      private var _totalElements:int = 0;

      public var line:MovieClip;

      override public function dispose() : void {
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         if(this._elements)
         {
            this.clearElements();
            this._elements = null;
         }
         this.titleTF = null;
         this.line = null;
         super.dispose();
      }

      public function setData(param1:Object) : void {
         this._data = new ConditionsVO(param1);
         invalidateData();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._data?this._data.title:"";
            this.createElements();
            this.layoutElements();
         }
      }

      private function clearElements() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._elements.length)
         {
            this._elements[_loc1_].dispose();
            removeChild(this._elements[_loc1_]);
            _loc1_++;
         }
         this._elements.splice(0,this._elements.length);
      }

      private function createElements() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:ConditionElement = null;
         var _loc5_:* = 0;
         if(this._data)
         {
            this._totalElements = this._data.elements.length;
            if(this._elements.length < this._totalElements)
            {
               _loc2_ = this._totalElements - this._elements.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = App.utils.classFactory.getComponent("ConditionElement_UI",ConditionElement);
                  this._elements.push(_loc4_);
                  addChild(_loc4_);
                  _loc3_++;
               }
            }
            else
            {
               if(this._elements.length > this._totalElements)
               {
                  _loc5_ = this._totalElements;
                  while(_loc5_ < this._elements.length)
                  {
                     this._elements[_loc5_].visible = false;
                     _loc5_++;
                  }
               }
            }
            _loc1_ = 0;
            while(_loc1_ < this._totalElements)
            {
               this._elements[_loc1_].setData(this._data.elements[_loc1_]);
               this._elements[_loc1_].visible = true;
               this._elements[_loc1_].validateNow();
               _loc1_++;
            }
         }
         else
         {
            this.clearElements();
         }
      }

      private function layoutElements() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = 0;
         var _loc3_:* = NaN;
         if(this._data)
         {
            _loc1_ = Math.round(this._data.title?this.titleTF.y + this.titleTF.textHeight + 4:PADDING);
            _loc2_ = 0;
            while(_loc2_ < this._totalElements)
            {
               if(_loc2_ == 0)
               {
                  this._elements[_loc2_].y = _loc1_;
               }
               else
               {
                  this._elements[_loc2_].y = Math.round(this._elements[_loc2_-1].y + this._elements[_loc2_-1].height);
               }
               _loc2_++;
            }
            if(this._totalElements > 0)
            {
               this.line.y = Math.round(this._elements[this._totalElements-1].y + this._elements[this._totalElements-1].height);
            }
            else
            {
               this.line.y = _loc1_ + PADDING;
            }
            _loc3_ = Math.round(this.line.y);
            setSize(this.width,_loc3_);
         }
         else
         {
            setSize(this.width,0);
         }
      }
   }

}