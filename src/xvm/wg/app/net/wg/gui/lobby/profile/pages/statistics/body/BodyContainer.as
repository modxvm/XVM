package net.wg.gui.lobby.profile.pages.statistics.body
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.lobby.profile.components.ResizableViewStack;
   import flash.geom.Point;
   import scaleform.clik.events.IndexEvent;
   import __AS3__.vec.Vector;
   import scaleform.clik.data.DataProvider;


   public class BodyContainer extends UIComponent
   {
          
      public function BodyContainer() {
         this.availableSize = new Point();
         super();
         this.barStartYPosition = this.bar.y;
         this.viewStackStartYPosition = this.viewStack.y;
      }

      private static const MIN_BTN_WIDTH:Number = 136;

      private static const LAYOUT_INVALID:String = "layoutInv";

      public var bar:ContentTabBar;

      public var viewStack:ResizableViewStack;

      private var barStartYPosition:int;

      private var viewStackStartYPosition:int;

      private var availableSize:Point;

      override protected function configUI() : void {
         super.configUI();
         this.viewStack.cache = true;
         this.bar.minRendererWidth = MIN_BTN_WIDTH;
         this.bar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChanged,false,0,true);
         this.bar.selectedIndex = 0;
      }

      private function onTabBarIndexChanged(param1:IndexEvent) : void {
         var _loc2_:int = param1.index;
         if(!(_loc2_ == -1) && (param1.data))
         {
            this.viewStack.show(BodyBarData(param1.data).linkage);
         }
      }

      override protected function draw() : void {
         var _loc1_:uint = 0;
         if(_baseDisposed)
         {
            return;
         }
         super.draw();
         if(isInvalid(LAYOUT_INVALID))
         {
            this.viewStack.setAvailableSize(this.availableSize.x,this.availableSize.y);
            _loc1_ = this.bar.dataProvider?this.bar.dataProvider.length:0;
            this.bar.x = (this.availableSize.x - MIN_BTN_WIDTH * _loc1_) / 2;
         }
      }

      public function setDossierData(param1:Object) : void {
         var _loc4_:String = null;
         var _loc6_:StatisticsLabelDataVO = null;
         var _loc2_:Array = [];
         var _loc3_:Vector.<StatisticsLabelDataVO> = new StatisticsBodyVO(param1).dataListVO;
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_];
            if(_loc5_ == 0)
            {
               _loc4_ = "DetailedStatisticsView_UI";
            }
            else
            {
               _loc4_ = "ChartsStatisticsView_UI";
            }
            _loc2_.push(new BodyBarData(_loc6_.label,_loc4_));
            _loc5_++;
         }
         this.bar.dataProvider = new DataProvider(_loc2_);
         if(_loc5_ > 1)
         {
            this.bar.visible = true;
            if(this.bar.selectedIndex == -1)
            {
               this.bar.selectedIndex = 0;
            }
            this.viewStack.y = this.viewStackStartYPosition;
         }
         else
         {
            this.bar.selectedIndex = 0;
            this.bar.visible = false;
            this.viewStack.y = this.barStartYPosition;
         }
         this.viewStack.updateData(_loc3_);
         invalidate(LAYOUT_INVALID);
      }

      public function setAvailableSize(param1:Number, param2:Number) : void {
         this.availableSize.x = param1;
         this.availableSize.y = param2;
         invalidate(LAYOUT_INVALID);
      }

      override protected function onDispose() : void {
         this.bar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChanged);
         this.bar.dispose();
         this.bar = null;
         this.availableSize = null;
         this.viewStack.dispose();
         this.viewStack = null;
         super.onDispose();
      }
   }

}

   class BodyBarData extends Object
   {
          
      function BodyBarData(param1:String, param2:String) {
         super();
         this.label = param1;
         this.linkage = param2;
      }

      public var label:String;

      public var linkage:String;
   }
