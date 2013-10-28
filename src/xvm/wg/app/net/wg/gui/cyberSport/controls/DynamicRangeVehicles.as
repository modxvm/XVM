package net.wg.gui.cyberSport.controls
{
   import scaleform.clik.core.UIComponent;
   import net.wg.utils.IUtils;
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import flash.display.MovieClip;


   public class DynamicRangeVehicles extends UIComponent
   {
          
      public function DynamicRangeVehicles() {
         super();
      }

      private var model:SettingRosterVO;

      private const UPDATE_DYNAMIC_DATA:String = "updateDynamicData";

      public function setData(param1:SettingRosterVO) : void {
         if(param1 == null)
         {
            return;
         }
         this.model = param1;
         invalidate(this.UPDATE_DYNAMIC_DATA);
      }

      override protected function draw() : void {
         super.draw();
         if((this.model) && (isInvalid(this.UPDATE_DYNAMIC_DATA)))
         {
            this.redrawComponents();
         }
      }

      private var utils:IUtils;

      override protected function configUI() : void {
         super.configUI();
         this.utils = App.utils;
      }

      private function redrawComponents() : void {
         var _loc4_:uint = 0;
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:* = 0;
         var _loc1_:Boolean = (this.model.nationIDRange) && this.model.nationIDRange.length > 0;
         var _loc2_:Boolean = (this.model.vTypeRange) && this.model.vTypeRange.length > 0;
         var _loc3_:Boolean = (this.model.vLevelRange) && this.model.vLevelRange.length > 0;
         if(_loc1_)
         {
            _loc4_ = this.model.nationIDRange.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.addChild(this.createNationsElements(this.model.nationIDRange[_loc5_]));
               _loc5_++;
            }
            this.initSeparator(_loc2_);
         }
         if(_loc2_)
         {
            _loc6_ = this.model.vTypeRange.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               this.addChild(this.createVehicleTypes(this.model.vTypeRange[_loc7_]));
               _loc7_++;
            }
            this.initSeparator(_loc3_);
         }
         if(_loc3_)
         {
            _loc8_ = this.model.vLevelRange.length;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               this.addChild(this.createVehicleTypes(this.model.vLevelRange[_loc9_]));
               _loc9_++;
            }
         }
      }

      private function initSeparator(param1:Boolean=false) : void {
         if(param1)
         {
            this.addChild(this.createSeparators());
         }
      }

      private function createNationsElements(param1:int) : Sprite {
         var _loc2_:Sprite = new Sprite();
         return _loc2_;
      }

      private function createSeparators() : Sprite {
         var _loc1_:Sprite = new Sprite();
         this.classFactory(Linkages.PERSONAL_CASE_BLOCK_ITEM);
         return _loc1_;
      }

      private function createVehicleTypes(param1:String) : Sprite {
         var _loc2_:Sprite = new Sprite();
         return _loc2_;
      }

      private function createVehiclesLevels() : void {
          
      }

      private function classFactory(param1:String) : * {
         return App.utils.classFactory.getComponent(param1,MovieClip);
      }
   }

}