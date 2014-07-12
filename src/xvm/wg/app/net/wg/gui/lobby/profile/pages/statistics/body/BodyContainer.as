package net.wg.gui.lobby.profile.pages.statistics.body
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.advanced.ContentTabBar;
    import net.wg.gui.lobby.profile.components.ResizableViewStack;
    import flash.geom.Point;
    import scaleform.clik.events.IndexEvent;
    import scaleform.clik.data.DataProvider;
    
    public class BodyContainer extends UIComponent
    {
        
        public function BodyContainer() {
            this.availableSize = new Point();
            super();
            this.barStartYPosition = this.bar.y;
            this.viewStackStartYPosition = this.viewStack.y;
        }
        
        private static var MIN_BTN_WIDTH:Number = 136;
        
        private static var LAYOUT_INVALID:String = "layoutInv";
        
        public var bar:ContentTabBar;
        
        public var viewStack:ResizableViewStack;
        
        private var barStartYPosition:int;
        
        private var viewStackStartYPosition:int;
        
        private var availableSize:Point;
        
        private var dataList:Vector.<StatisticsLabelDataVO>;
        
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
                this.updateDataAt(_loc2_);
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
                this.bar.x = (this.availableSize.x - this.bar.width) / 2;
            }
        }
        
        public function setDossierData(param1:Object) : void {
            var _loc3_:String = null;
            var _loc5_:StatisticsLabelDataVO = null;
            var _loc2_:Array = [];
            this.dataList = new StatisticsBodyVO(param1).dataListVO;
            var _loc4_:* = 0;
            while(_loc4_ < this.dataList.length)
            {
                _loc5_ = this.dataList[_loc4_];
                if(_loc5_ is DetailedLabelDataVO)
                {
                    _loc3_ = "DetailedStatisticsView_UI";
                }
                else if(_loc5_ is StatisticsChartsTabDataVO)
                {
                    _loc3_ = "ChartsStatisticsView_UI";
                }
                
                _loc2_.push(new BodyBarData(_loc5_.label,_loc3_));
                _loc4_++;
            }
            this.bar.dataProvider = new DataProvider(_loc2_);
            if(_loc4_ > 1)
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
            this.viewStack.show(BodyBarData(_loc2_[this.bar.selectedIndex]).linkage);
            this.updateDataAt(this.bar.selectedIndex);
            invalidate(LAYOUT_INVALID);
        }
        
        private function updateDataAt(param1:int) : void {
            if(this.dataList)
            {
                this.viewStack.updateData(this.dataList[param1]);
            }
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
