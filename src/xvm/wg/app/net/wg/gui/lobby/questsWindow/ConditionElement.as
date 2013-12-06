package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.questsWindow.components.QuestsDashlineItem;
   import __AS3__.vec.Vector;
   import net.wg.gui.lobby.questsWindow.data.ConditionElementVO;
   import scaleform.clik.constants.InvalidationType;


   public class ConditionElement extends UIComponent
   {
          
      public function ConditionElement() {
         super();
         this._tanks = new Vector.<VehicleBlock>();
      }

      private static const PADDING:int = 30;

      private static const TEXT_PADDING:int = 5;

      private static const ONLY_TEXT_PADDING:int = 8;

      private static const AFTER_TANKS_PADDING:int = 17;

      private static const TANK_HEIGHT:int = 35;

      public var conditionDL:QuestsDashlineItem;

      private var _tanks:Vector.<VehicleBlock> = null;

      private var _data:ConditionElementVO = null;

      private var totalTanks:int = 0;

      override protected function configUI() : void {
         super.configUI();
         this.conditionDL.width = 375;
      }

      override public function dispose() : void {
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         if(this._tanks)
         {
            this.clearTanks();
            this._tanks = null;
         }
         this.conditionDL.dispose();
         this.conditionDL = null;
         super.dispose();
      }

      public function setData(param1:Object) : void {
         this._data = new ConditionElementVO(param1);
         invalidateData();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data)
            {
               this.conditionDL.label = this._data.descr;
               this.conditionDL.value = this._data.discountVal;
               this.conditionDL.validateNow();
            }
            this.createTanks();
            this.layoutTanks();
         }
      }

      private function clearTanks() : void {
         var _loc1_:VehicleBlock = null;
         while(this._tanks.length)
         {
            _loc1_ = this._tanks.pop();
            _loc1_.dispose();
            removeChild(_loc1_);
         }
      }

      private function createTanks() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:VehicleBlock = null;
         var _loc5_:* = 0;
         if(this._data)
         {
            this.totalTanks = this._data.vehicles.length;
            if(this._tanks.length < this.totalTanks)
            {
               _loc2_ = this.totalTanks - this._tanks.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = App.utils.classFactory.getComponent("VehicleBlock_UI",VehicleBlock);
                  this._tanks.push(_loc4_);
                  addChild(_loc4_);
                  _loc3_++;
               }
            }
            else
            {
               if(this._tanks.length > this.totalTanks)
               {
                  _loc5_ = this.totalTanks;
                  while(_loc5_ < this._tanks.length)
                  {
                     this._tanks[_loc5_].visible = false;
                     _loc5_++;
                  }
               }
            }
            _loc1_ = 0;
            while(_loc1_ < this.totalTanks)
            {
               this._tanks[_loc1_].setData(this._data.vehicles[_loc1_]);
               this._tanks[_loc1_].visible = true;
               _loc1_++;
            }
         }
         else
         {
            this.clearTanks();
         }
      }

      private function layoutTanks() : void {
         var _loc1_:Number = this.getDiscountHeight();
         var _loc2_:* = 0;
         while(_loc2_ < this._tanks.length)
         {
            this._tanks[_loc2_].y = _loc1_ + _loc2_ * TANK_HEIGHT;
            this._tanks[_loc2_].x = PADDING;
            _loc2_++;
         }
         var _loc3_:Number = this.totalTanks * TANK_HEIGHT;
         var _loc4_:Number = _loc1_ + (_loc3_ > 0?_loc3_ + AFTER_TANKS_PADDING:ONLY_TEXT_PADDING);
         setSize(this.width,_loc4_);
      }

      private function getDiscountHeight() : Number {
         return Math.round(this.conditionDL.y + this.conditionDL.labelTextField.textHeight + TEXT_PADDING);
      }
   }

}