package net.wg.gui.lobby.quests.components
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import flash.display.Sprite;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import net.wg.gui.lobby.quests.components.interfaces.ISeasonAward;
    import flash.display.InteractiveObject;
    
    public class SeasonAwardsBlock extends UIComponent
    {
        
        public function SeasonAwardsBlock()
        {
            super();
        }
        
        private static var NUM_ITEMS_IN_ROW:int = 4;
        
        public var titleTf:TextField;
        
        public var container:Sprite;
        
        private var _items:Vector.<SeasonAward>;
        
        public function setTitle(param1:String) : void
        {
            this.titleTf.htmlText = param1;
        }
        
        public function addItem(param1:SeasonAward) : void
        {
            if(this._items == null)
            {
                this._items = new Vector.<SeasonAward>();
            }
            this._items.push(param1);
            this.container.addChild(param1);
            invalidateSize();
        }
        
        public function getItemsCount() : int
        {
            return this._items != null?this._items.length:0;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.layoutContainer();
            }
        }
        
        private function layoutContainer() : void
        {
            var _loc1_:UIComponent = null;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:* = NaN;
            var _loc6_:* = NaN;
            if(this._items != null)
            {
                _loc5_ = 0;
                _loc2_ = 0;
                while(_loc2_ < this._items.length)
                {
                    _loc1_ = this._items[_loc2_];
                    if(_loc5_ < _loc1_.height)
                    {
                        _loc5_ = _loc1_.height;
                    }
                    _loc2_++;
                }
                _loc6_ = this.width / NUM_ITEMS_IN_ROW;
                _loc2_ = 0;
                while(_loc2_ < this._items.length)
                {
                    _loc3_ = _loc2_ % NUM_ITEMS_IN_ROW;
                    _loc4_ = _loc2_ / NUM_ITEMS_IN_ROW;
                    _loc1_ = this._items[_loc2_];
                    _loc1_.x = _loc3_ * _loc6_;
                    _loc1_.y = _loc4_ * _loc5_;
                    _loc2_++;
                }
                dispatchEvent(new Event(Event.RESIZE));
            }
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:UIComponent = null;
            this.titleTf = null;
            if(this._items != null)
            {
                while(this._items.length > 0)
                {
                    _loc1_ = this._items.pop();
                    this.container.removeChild(_loc1_);
                    _loc1_.dispose();
                }
                this._items = null;
            }
            this.container = null;
            super.onDispose();
        }
        
        public function getTabIndexItems() : Array
        {
            var _loc1_:Array = null;
            var _loc2_:ISeasonAward = null;
            var _loc3_:InteractiveObject = null;
            if(this._items != null)
            {
                _loc1_ = new Array();
                for each(_loc2_ in this._items)
                {
                    for each(_loc3_ in _loc2_.getTabIndexItems())
                    {
                        if(_loc3_ != null)
                        {
                            _loc1_.push(_loc3_);
                        }
                    }
                }
                return _loc1_;
            }
            return null;
        }
    }
}
