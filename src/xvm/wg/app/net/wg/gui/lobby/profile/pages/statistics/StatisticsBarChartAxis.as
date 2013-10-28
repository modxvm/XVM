package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.gui.lobby.profile.components.chart.axis.AxisBase;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.profile.components.LineTextComponent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   import flash.events.Event;
   import net.wg.gui.lobby.profile.components.chart.IChartItem;
   import flash.geom.Point;
   import net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;


   public class StatisticsBarChartAxis extends AxisBase
   {
          
      public function StatisticsBarChartAxis() {
         super();
      }

      private static const paddingTop:int = 112;

      private static const LAYOUT_INV:String = "layoutInv";

      public static const INITIALIZED:String = "inited";

      public var background:MovieClip;

      public var lineText:LineTextComponent;

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function createPoint(param1:Object) : IListItemRenderer {
         var _loc2_:StatisticBarChartAxisPoint = new _pointClass();
         _loc2_.addEventListener(SimpleLoader.LOADED,this.iconLoadingCompleteHandler,false,0,true);
         addChild(_loc2_);
         return _loc2_;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(LAYOUT_INV))
         {
            this.layoutAll(currentLayout);
         }
      }

      private function iconLoadingCompleteHandler(param1:Event) : void {
         var _loc6_:StatisticBarChartAxisPoint = null;
         var _loc2_:uint = getData().length;
         var _loc3_:* = true;
         var _loc4_:uint = 0;
         var _loc5_:* = 0;
         while(_loc5_ < numChildren)
         {
            _loc6_ = getChildAt(_loc5_) as StatisticBarChartAxisPoint;
            if(_loc6_)
            {
               _loc4_++;
               if(!_loc6_.initialized)
               {
                  _loc3_ = false;
                  break;
               }
            }
            _loc5_++;
         }
         if((_loc3_) && _loc2_ == _loc4_)
         {
            dispatchEvent(new Event(INITIALIZED));
         }
         invalidate(LAYOUT_INV);
      }

      override protected function layoutPoint(param1:IListItemRenderer, param2:IChartItem) : void {
         var _loc3_:StatisticBarChartItem = StatisticBarChartItem(param2);
         var _loc4_:Point = _loc3_.getThumbDimensions();
         param1.y = paddingTop;
         param1.x = Math.round(_loc3_.x + (_loc4_.x - param1.width >> 1));
      }

      override protected function layoutAll(param1:IChartLayout) : void {
         var _loc2_:StatisticBarChartItem = null;
         super.layoutAll(param1);
         if(!renderers)
         {
            return;
         }
         var _loc3_:* = 0;
         while(_loc3_ < renderers.length)
         {
            _loc2_ = StatisticBarChartItem(renderers[_loc3_]);
            this.layoutPoint(_points[_loc3_],_loc2_);
            _loc3_++;
         }
         if(_loc2_)
         {
            this.lineText.width = this.background.width = _loc2_.x + _loc2_.getThumbDimensions().x + param1.paddingRight;
            dispatchEvent(new Event(Event.RESIZE,true));
         }
      }

      override public function dispose() : void {
         var _loc1_:Object = null;
         while(_points.length > 0)
         {
            _loc1_ = _points.splice(_points.length-1,1)[0];
            try
            {
               _loc1_.dispose();
               _loc1_.removeEventListener(SimpleLoader.LOADED,this.iconLoadingCompleteHandler);
            }
            catch(e:Error)
            {
            }
            _loc1_ = null;
         }
      }
   }

}