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

      public var line:MovieClip;

      override public function dispose() : void {
         if(this._elements)
         {
            this.clearElements();
            this._elements = null;
         }
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.dispose();
      }

      public function setData(param1:Object) : void {
         this._data = new ConditionsVO(param1);
         invalidateData();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this._data))
         {
            this.titleTF.text = this._data.title;
            this.clearElements();
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
         var _loc3_:ConditionElement = null;
         var _loc1_:int = this._data.elements.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = App.utils.classFactory.getComponent("ConditionElement_UI",ConditionElement);
            this._elements.push(_loc3_);
            addChild(_loc3_);
            _loc3_.setData(this._data.elements[_loc2_]);
            _loc3_.validateNow();
            _loc2_++;
         }
      }

      private function layoutElements() : void {
         var _loc1_:Number = Math.round(this._data.title?this.titleTF.y + this.titleTF.textHeight + 4:PADDING);
         var _loc2_:* = 0;
         while(_loc2_ < this._elements.length)
         {
            if(_loc2_ == 0)
            {
               this._elements[_loc2_].y = _loc1_;
            }
            else
            {
               this._elements[_loc2_].y = this._elements[_loc2_-1].y + this._elements[_loc2_-1].height;
            }
            _loc2_++;
         }
         if(this._elements.length > 0)
         {
            this.line.y = Math.round(this._elements[this._elements.length-1].y + this._elements[this._elements.length-1].height);
         }
         else
         {
            this.line.y = _loc1_ + PADDING;
         }
         var _loc3_:Number = Math.round(this.line.y + this.line.height);
         setSize(this.width,_loc3_);
      }
   }

}