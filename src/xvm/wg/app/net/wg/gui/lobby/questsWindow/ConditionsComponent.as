package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import __AS3__.vec.Vector;
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;


   public class ConditionsComponent extends UIComponent
   {
          
      public function ConditionsComponent() {
         this._data = [];
         super();
         this._blocks = new Vector.<ConditionsBlock>();
      }

      private static const BOTTOM_PADDING:int = 5;

      private var _data:Array;

      private var _blocks:Vector.<ConditionsBlock> = null;

      public var line:MovieClip;

      override public function dispose() : void {
         if(this._blocks)
         {
            this.clearBlocks();
            this._blocks = null;
         }
         if(this._data)
         {
            this._data.splice(0,this._data.length);
            this._data = null;
         }
         super.dispose();
      }

      public function setData(param1:Array) : void {
         this._data = param1;
         invalidateData();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this._data))
         {
            this.clearBlocks();
            this.createBlocks();
            this.layoutBlocks();
         }
      }

      private function clearBlocks() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._blocks.length)
         {
            this._blocks[_loc1_].dispose();
            removeChild(this._blocks[_loc1_]);
            _loc1_++;
         }
         this._blocks.splice(0,this._blocks.length);
      }

      private function createBlocks() : void {
         var _loc3_:ConditionsBlock = null;
         var _loc1_:int = this._data.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = App.utils.classFactory.getComponent("ConditionsBlock_UI",ConditionsBlock);
            this._blocks.push(_loc3_);
            addChild(_loc3_);
            _loc3_.setData(this._data[_loc2_]);
            if(_loc2_ == _loc1_-1)
            {
               _loc3_.line.visible = false;
            }
            _loc3_.validateNow();
            _loc2_++;
         }
      }

      private function layoutBlocks() : void {
         var _loc1_:* = 1;
         while(_loc1_ < this._blocks.length)
         {
            this._blocks[_loc1_].y = this._blocks[_loc1_-1].y + this._blocks[_loc1_-1].height;
            _loc1_++;
         }
         var _loc2_:Number = this._blocks.length > 0?this._blocks[this._blocks.length-1].height + this._blocks[this._blocks.length-1].y + BOTTOM_PADDING:0;
         this.line.y = _loc2_-1;
         this.line.visible = this._blocks.length > 0;
         setSize(this.width,_loc2_);
      }
   }

}