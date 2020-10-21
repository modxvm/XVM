package net.wg.gui.lobby.eventItemPackTrade.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.eventItemPackTrade.data.ItemVO;

    public class EventItemsPackPanel extends Sprite implements IDisposable
    {

        private static const ITEM_UI:String = "EventItemUI";

        private static const ITEM_OFFSET_X:int = 100;

        private static const ITEM_OFFSET_Y:int = 90;

        private static const ITEM_COUNT_MAX_ROW:int = 10;

        private var _dynItems:Vector.<DisplayObject> = null;

        private var _countLines:int = 0;

        public function EventItemsPackPanel()
        {
            super();
        }

        private function clearItems() : void
        {
            var _loc1_:IDisposable = null;
            if(this._dynItems)
            {
                for each(_loc1_ in this._dynItems)
                {
                    _loc1_.dispose();
                    this.removeChild(DisplayObject(_loc1_));
                }
                this._dynItems.splice(0,this._dynItems.length);
                this._dynItems = null;
            }
        }

        public final function dispose() : void
        {
            this.clearItems();
        }

        public function layoutElements() : void
        {
            var _loc1_:DisplayObject = null;
            this._countLines = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            for each(_loc1_ in this._dynItems)
            {
                _loc1_.x = _loc2_;
                _loc1_.y = _loc3_;
                _loc2_ = _loc2_ + ITEM_OFFSET_X;
                _loc4_ = ++_loc4_ % ITEM_COUNT_MAX_ROW;
                if(!_loc4_)
                {
                    _loc2_ = 0;
                    _loc3_ = _loc3_ + ITEM_OFFSET_Y;
                    this._countLines++;
                }
            }
            if(_loc4_ && this._countLines)
            {
                for each(_loc1_ in this._dynItems)
                {
                    if(_loc1_.y == _loc3_)
                    {
                        _loc1_.x = _loc1_.x + (ITEM_COUNT_MAX_ROW - _loc4_) * ITEM_OFFSET_X / 2;
                    }
                }
            }
        }

        public function setData(param1:Vector.<ItemVO>) : void
        {
            var _loc4_:EventItem = null;
            this.clearItems();
            this._dynItems = new Vector.<DisplayObject>();
            var _loc2_:int = param1.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = App.utils.classFactory.getComponent(ITEM_UI,EventItem);
                _loc4_.configUI();
                _loc4_.setItem(param1[_loc3_]);
                this.addChild(_loc4_);
                this._dynItems.push(_loc4_);
                _loc3_++;
            }
        }

        public function get countLines() : int
        {
            return this._countLines;
        }
    }
}
