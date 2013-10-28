package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import __AS3__.vec.Vector;
   import net.wg.gui.lobby.questsWindow.data.ConditionElementVO;
   import scaleform.clik.constants.InvalidationType;


   public class ConditionElement extends UIComponent
   {
          
      public function ConditionElement() {
         super();
         this._tanks = new Vector.<VehicleBlock>();
      }

      private static const PADDING:int = 20;

      private static const TEXT_PADDING:int = 5;

      private static const ONLY_TEXT_PADDING:int = 8;

      private static const AFTER_TANKS_PADDING:int = 17;

      public var descrTF:TextField;

      private var _tanks:Vector.<VehicleBlock> = null;

      private var _data:ConditionElementVO = null;

      override public function dispose() : void {
         if(this._tanks)
         {
            this.clearTanks();
            this._tanks = null;
         }
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.dispose();
      }

      public function setData(param1:Object) : void {
         this._data = new ConditionElementVO(param1);
         invalidateData();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this._data))
         {
            this.descrTF.htmlText = this._data.descr;
            this.descrTF.height = this.descrTF.textHeight + 10;
            this.clearTanks();
            this.createTanks();
            this.layoutTanks();
         }
      }

      private function clearTanks() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._tanks.length)
         {
            this._tanks[_loc1_].dispose();
            removeChild(this._tanks[_loc1_]);
            _loc1_++;
         }
         this._tanks.splice(0,this._tanks.length);
      }

      private function createTanks() : void {
         var _loc3_:VehicleBlock = null;
         var _loc1_:int = this._data.vehicles.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = App.utils.classFactory.getComponent("VehicleBlock_UI",VehicleBlock);
            this._tanks.push(_loc3_);
            addChild(_loc3_);
            _loc3_.setData(this._data.vehicles[_loc2_]);
            _loc3_.validateNow();
            _loc2_++;
         }
      }

      private function layoutTanks() : void {
         var _loc1_:Number = this._tanks.length?this._tanks[0].height:0;
         var _loc2_:Number = Math.round(this.descrTF.y + this.descrTF.textHeight + TEXT_PADDING);
         var _loc3_:* = 0;
         while(_loc3_ < this._tanks.length)
         {
            this._tanks[_loc3_].y = _loc2_ + _loc3_ * _loc1_;
            this._tanks[_loc3_].x = PADDING;
            _loc3_++;
         }
         var _loc4_:Number = this._tanks.length * _loc1_;
         var _loc5_:Number = 0;
         if(_loc4_ > 0)
         {
            _loc5_ = _loc2_ + _loc4_ + AFTER_TANKS_PADDING;
         }
         else
         {
            _loc5_ = _loc2_ + ONLY_TEXT_PADDING;
         }
         setSize(this.width,_loc5_);
      }
   }

}