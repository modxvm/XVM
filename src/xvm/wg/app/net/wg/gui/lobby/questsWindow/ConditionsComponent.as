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

      private static const BOTTOM_PADDING:int = 15;

      private var _data:Array;

      private var _blocks:Vector.<ConditionsBlock> = null;

      private var totalBlocks:int = 0;

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
         this.line = null;
         super.dispose();
      }

      public function setData(param1:Array) : void {
         this._data = param1;
         invalidateData();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
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
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:ConditionsBlock = null;
         var _loc5_:* = 0;
         if(this._data)
         {
            this.totalBlocks = this._data.length;
            if(this._blocks.length < this.totalBlocks)
            {
               _loc2_ = this.totalBlocks - this._blocks.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = App.utils.classFactory.getComponent("ConditionsBlock_UI",ConditionsBlock);
                  this._blocks.push(_loc4_);
                  addChild(_loc4_);
                  _loc3_++;
               }
            }
            else
            {
               if(this._blocks.length > this.totalBlocks)
               {
                  _loc5_ = this.totalBlocks;
                  while(_loc5_ < this._blocks.length)
                  {
                     this._blocks[_loc5_].visible = false;
                     _loc5_++;
                  }
               }
            }
            _loc1_ = 0;
            while(_loc1_ < this.totalBlocks)
            {
               this._blocks[_loc1_].setData(this._data[_loc1_]);
               this._blocks[_loc1_].visible = true;
               if(_loc1_ == this.totalBlocks-1)
               {
                  this._blocks[_loc1_].line.visible = false;
               }
               this._blocks[_loc1_].validateNow();
               _loc1_++;
            }
         }
         else
         {
            this.clearBlocks();
         }
      }

      private function layoutBlocks() : void {
         var _loc1_:* = 1;
         while(_loc1_ < this.totalBlocks)
         {
            this._blocks[_loc1_].y = Math.round(this._blocks[_loc1_-1].y + this._blocks[_loc1_-1].height);
            _loc1_++;
         }
         var _loc2_:Number = Math.round(this.totalBlocks > 0?this._blocks[this.totalBlocks-1].height + this._blocks[this.totalBlocks-1].y + BOTTOM_PADDING:0);
         this.line.y = _loc2_;
         this.line.visible = this.totalBlocks > 0;
         setSize(this.width,_loc2_);
      }
   }

}