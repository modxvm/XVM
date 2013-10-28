package net.wg.gui.lobby.profile.pages.statistics
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import flash.geom.Point;
   import flash.events.Event;
   import __AS3__.vec.*;
   import net.wg.utils.INations;
   import net.wg.data.constants.VehicleTypes;


   public class TechniqueStatistics extends UIComponent
   {
          
      public function TechniqueStatistics() {
         super();
      }

      private static const LAYOUT_INV:String = "layoutInv";

      private static function formTypeChartItem(param1:Object, param2:String) : StatisticChartInfo {
         var _loc3_:StatisticChartInfo = new StatisticChartInfo();
         _loc3_.xField = param2;
         _loc3_.yField = param1[param2];
         return _loc3_;
      }

      private static function formChartItemProvider(param1:Object) : DataProvider {
         var _loc3_:StatisticChartInfo = null;
         var _loc4_:String = null;
         var _loc2_:Array = [];
         for (_loc4_ in param1)
         {
            _loc3_ = new StatisticChartInfo();
            _loc3_.xField = uint(_loc4_);
            _loc3_.yField = param1[_loc4_];
            _loc2_.push(_loc3_);
         }
         if(_loc3_.hasOwnProperty("xField"))
         {
            _loc2_.sortOn("xField",[Array.NUMERIC]);
            return new DataProvider(_loc2_);
         }
         throw new Error("There is no property: \'xField\' in the target Array. Couldn\'t perform sort operation!");
      }

      public var typeChart:TypesStatisticsChart;

      public var nationChart:NationsStatisticsChart;

      public var levelChart:LevelsStatisticChart;

      private var currentDimension:Point;

      override protected function configUI() : void {
         super.configUI();
         this.typeChart.mainHorizontalAxis.pointClass = AxisPointTypes;
         this.nationChart.mainHorizontalAxis.pointClass = AxisPointNations;
         this.levelChart.mainHorizontalAxis.pointClass = AxisPointLevels;
         addEventListener(Event.RESIZE,this.resizeMainHandler,false,0,true);
      }

      override protected function draw() : void {
         var _loc1_:Vector.<UIComponent> = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:UIComponent = null;
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         super.draw();
         if((isInvalid(LAYOUT_INV)) && (this.currentDimension))
         {
            _loc1_ = new Vector.<UIComponent>(0);
            _loc1_.push(this.typeChart);
            _loc1_.push(this.nationChart);
            _loc1_.push(this.levelChart);
            _loc2_ = _loc1_.length;
            _loc3_ = 0;
            for each (_loc4_ in _loc1_)
            {
               _loc3_ = _loc3_ + Math.round(_loc4_.actualWidth);
            }
            _loc5_ = Math.round((this.currentDimension.x - _loc3_) / (_loc2_ + 1));
            _loc6_ = _loc5_;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc4_ = _loc1_[_loc7_];
               _loc4_.x = _loc6_;
               _loc6_ = _loc6_ + Math.round(_loc4_.actualWidth + _loc5_);
               _loc7_++;
            }
         }
      }

      private function resizeMainHandler(param1:Event) : void {
         param1.stopImmediatePropagation();
         invalidate(LAYOUT_INV);
      }

      override public function dispose() : void {
         super.dispose();
         removeEventListener(Event.RESIZE,this.resizeMainHandler);
         this.typeChart.dispose();
         this.nationChart.dispose();
         this.levelChart.dispose();
      }

      public function setChartsTitles(param1:Array) : void {
         this.typeChart.mainHorizontalAxis.lineText.text = param1[0];
         this.nationChart.mainHorizontalAxis.lineText.text = param1[1];
         this.levelChart.mainHorizontalAxis.lineText.text = param1[2];
      }

      public function setDossierData(param1:Array) : void {
         var _loc10_:String = null;
         var _loc2_:Object = param1[1];
         var _loc3_:INations = App.utils.nations;
         var _loc4_:Array = _loc3_.getNations();
         var _loc5_:Array = [];
         var _loc6_:uint = _loc4_.length;
         var _loc7_:* = 0;
         while(_loc7_ < _loc6_)
         {
            _loc10_ = _loc3_.getNationID(_loc4_[_loc7_]).toString();
            _loc5_.push(formTypeChartItem(_loc2_,_loc10_));
            _loc7_++;
         }
         this.nationChart.dataProvider = new DataProvider(_loc5_);
         this.levelChart.dataProvider = formChartItemProvider(param1[2]);
         var _loc8_:Array = [];
         var _loc9_:Object = param1[0];
         _loc8_.push(formTypeChartItem(_loc9_,VehicleTypes.LIGHT_TANK));
         _loc8_.push(formTypeChartItem(_loc9_,VehicleTypes.MEDIUM_TANK));
         _loc8_.push(formTypeChartItem(_loc9_,VehicleTypes.HEAVY_TANK));
         _loc8_.push(formTypeChartItem(_loc9_,VehicleTypes.AT_SPG));
         _loc8_.push(formTypeChartItem(_loc9_,VehicleTypes.SPG));
         this.typeChart.dataProvider = new DataProvider(_loc8_);
      }

      public function setViewSize(param1:Number, param2:Number) : void {
         if(!this.currentDimension)
         {
            this.currentDimension = new Point();
         }
         this.currentDimension.x = param1;
         this.currentDimension.y = param2;
         invalidate(LAYOUT_INV);
      }
   }

}