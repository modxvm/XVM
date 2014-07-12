package net.wg.gui.lobby.profile.components.chart.axis
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;
   import net.wg.gui.lobby.profile.components.chart.IChartItem;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AxisBase extends UIComponent implements IChartAxis
   {
      
      public function AxisBase() {
         this._points = [];
         super();
      }
      
      protected var _points:Array;
      
      protected var currentLayout:IChartLayout;
      
      protected var renderers:Vector.<IChartItem>;
      
      private var _dataProvider:IDataProvider;
      
      protected var _pointClass:Class;
      
      override protected function draw() : void {
         var _loc1_:IListItemRenderer = null;
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         var _loc4_:* = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc2_ = this._dataProvider?this._dataProvider.length:0;
            while(this._points.length > _loc2_)
            {
               this.removePointAt(this._points.length - 1);
            }
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = this._dataProvider[_loc4_];
               if(_loc4_ == this._points.length)
               {
                  _loc1_ = this.createPoint(_loc3_);
                  this._points.push(_loc1_);
               }
               else
               {
                  _loc1_ = this._points[_loc4_];
               }
               this.layoutPoint(_loc1_,this.renderers[_loc4_]);
               _loc1_.setData(_loc3_);
               _loc4_++;
            }
            if(_loc2_ > 0)
            {
               this.layoutAll(this.currentLayout);
            }
         }
      }
      
      public function setData(param1:IDataProvider, param2:Vector.<IChartItem>, param3:IChartLayout) : void {
         this._dataProvider = param1;
         this.currentLayout = param3;
         this.renderers = param2;
         invalidateData();
      }
      
      protected function layoutAll(param1:IChartLayout) : void {
      }
      
      protected function layoutPoint(param1:IListItemRenderer, param2:IChartItem) : void {
      }
      
      protected function createPoint(param1:Object) : IListItemRenderer {
         throw new Error("this method should be overridden");
      }
      
      protected function removePointAt(param1:uint) : Object {
         var _loc2_:Object = this._points.splice(param1,1)[0];
         if(_loc2_ is IDisposable)
         {
            IDisposable(_loc2_).dispose();
         }
         return _loc2_;
      }
      
      public function get pointClass() : Class {
         return this._pointClass;
      }
      
      public function set pointClass(param1:Class) : void {
         this._pointClass = param1;
         invalidateData();
      }
      
      public function getData() : Object {
         return this._dataProvider;
      }
      
      override protected function onDispose() : void {
         var _loc1_:Object = null;
         this._dataProvider = null;
         this.currentLayout.dispose();
         this.currentLayout = null;
         this.renderers = null;
         this._pointClass = null;
         while(this._points.length > 0)
         {
            _loc1_ = this._points.splice(this._points.length - 1,1)[0];
            try
            {
               _loc1_.dispose();
            }
            catch(e:Error)
            {
            }
            _loc1_ = null;
         }
         super.onDispose();
      }
   }
}
