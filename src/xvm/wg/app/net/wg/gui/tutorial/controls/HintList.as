package net.wg.gui.tutorial.controls
{
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.tutorial.constants.HintItemType;
    
    public class HintList extends UIComponent
    {
        
        public function HintList()
        {
            this._dataProvider = [];
            this.items = [];
            super();
        }
        
        public var textItemRenderer:String;
        
        public var videoItemRenderer:String;
        
        public var verticalGap:Number = 0;
        
        private var _dataProvider:Array;
        
        private var items:Array;
        
        public function get dataProvider() : Array
        {
            return this._dataProvider;
        }
        
        public function set dataProvider(param1:Array) : void
        {
            this._dataProvider = param1;
            invalidateData();
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.removeItems();
            this._dataProvider = this._dataProvider.splice(0,this._dataProvider.length);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.repopulate();
                this.relayout();
            }
        }
        
        public function relayout() : void
        {
            var _loc2_:HintBaseItemRenderer = null;
            var _loc1_:Number = 0;
            for each(_loc2_ in this.items)
            {
                _loc2_.y = _loc1_ ^ 0;
                _loc1_ = _loc1_ + (_loc2_.height + this.verticalGap);
            }
        }
        
        private function repopulate() : void
        {
            var _loc1_:Object = null;
            var _loc2_:HintBaseItemRenderer = null;
            this.removeItems();
            for each(_loc1_ in this._dataProvider)
            {
                _loc2_ = this.createRenderer(_loc1_);
                _loc2_.addEventListener(MouseEvent.CLICK,this.onItemClick);
                addChild(_loc2_);
                _loc2_.validateNow();
                this.items.push(_loc2_);
            }
        }
        
        private function onItemClick(param1:MouseEvent) : void
        {
            var _loc2_:HintBaseItemRenderer = param1.currentTarget as HintBaseItemRenderer;
            var _loc3_:ListEvent = new ListEvent(ListEvent.ITEM_CLICK);
            _loc3_.itemData = _loc2_.data;
            dispatchEvent(_loc3_);
        }
        
        private function createRenderer(param1:Object) : HintBaseItemRenderer
        {
            var _loc2_:HintBaseItemRenderer = null;
            var _loc3_:* = "";
            switch(param1.type)
            {
                case HintItemType.TEXT:
                    _loc3_ = this.textItemRenderer;
                    break;
                case HintItemType.VIDEO_LINK:
                    _loc3_ = this.videoItemRenderer;
                    break;
            }
            _loc2_ = App.utils.classFactory.getComponent(_loc3_,HintBaseItemRenderer);
            _loc2_.data = param1;
            return _loc2_;
        }
        
        private function removeItems() : void
        {
            var _loc1_:HintBaseItemRenderer = null;
            for each(_loc1_ in this.items)
            {
                removeChild(_loc1_);
                _loc1_.dispose();
            }
            this.items = this.items.splice(0,this.items.length);
        }
    }
}
