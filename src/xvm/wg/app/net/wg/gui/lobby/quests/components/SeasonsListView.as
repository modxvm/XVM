package net.wg.gui.lobby.quests.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.IContentSize;
    import flash.display.Sprite;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Linkages;
    import flash.events.Event;
    
    public class SeasonsListView extends UIComponentEx implements IContentSize
    {
        
        public function SeasonsListView()
        {
            super();
        }
        
        public var container:Sprite;
        
        private var _dataProvider:Array;
        
        public function get dataProvider() : Array
        {
            return this._dataProvider;
        }
        
        public function set dataProvider(param1:Array) : void
        {
            this._dataProvider = param1;
            invalidateData();
        }
        
        public function get contentWidth() : Number
        {
            return width;
        }
        
        public function get contentHeight() : Number
        {
            var _loc2_:SeasonViewRenderer = null;
            var _loc1_:Number = 0;
            if(this.container.numChildren > 0)
            {
                _loc2_ = this.container.getChildAt(this.container.numChildren - 1) as SeasonViewRenderer;
                _loc1_ = _loc2_.y + _loc2_.contentHeight;
            }
            return _loc1_;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            this.clearItems();
            if(this._dataProvider)
            {
                this._dataProvider.splice(0);
                this._dataProvider = null;
            }
            this.container = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.redrawItems();
            }
        }
        
        private function redrawItems() : void
        {
            var _loc1_:SeasonViewRenderer = null;
            this.clearItems();
            if(!this._dataProvider)
            {
                return;
            }
            var _loc2_:Number = 0;
            var _loc3_:* = 0;
            while(_loc3_ < this._dataProvider.length)
            {
                _loc1_ = App.utils.classFactory.getComponent(Linkages.SEASON_VIEW_RENDERER,SeasonViewRenderer);
                _loc1_.model = this._dataProvider[_loc3_];
                _loc1_.y = _loc2_;
                this.container.addChild(_loc1_);
                _loc2_ = _loc2_ + _loc1_.contentHeight;
                _loc3_++;
            }
            initSize();
            dispatchEvent(new Event(Event.RESIZE));
        }
        
        private function clearItems() : void
        {
            var _loc1_:SeasonViewRenderer = null;
            while(this.container.numChildren)
            {
                _loc1_ = this.container.getChildAt(0) as SeasonViewRenderer;
                this.container.removeChild(_loc1_);
                _loc1_.dispose();
            }
        }
    }
}
