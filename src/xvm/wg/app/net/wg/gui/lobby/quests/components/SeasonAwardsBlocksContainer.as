package net.wg.gui.lobby.quests.components
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    
    public class SeasonAwardsBlocksContainer extends UIComponent
    {
        
        public function SeasonAwardsBlocksContainer()
        {
            super();
        }
        
        public var basicAwardsContainer:SeasonAwardsBlock;
        
        public var extraAwardsContainer:SeasonAwardsBlock;
        
        public var delimiterLine:MovieClip;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.basicAwardsContainer.addEventListener(Event.RESIZE,this.onBlockResize);
            this.extraAwardsContainer.addEventListener(Event.RESIZE,this.onBlockResize);
            this.delimiterLine.mouseEnabled = false;
            this.delimiterLine.mouseChildren = false;
        }
        
        private function onBlockResize(param1:Event) : void
        {
            invalidateSize();
        }
        
        public function addBasicAward(param1:SeasonAward) : void
        {
            this.basicAwardsContainer.addItem(param1);
            invalidateSize();
        }
        
        public function addExtraAward(param1:SeasonAward) : void
        {
            this.extraAwardsContainer.addItem(param1);
            invalidateSize();
        }
        
        public function setBasicAwardsBlockTitle(param1:String) : void
        {
            this.basicAwardsContainer.setTitle(param1);
        }
        
        public function setExtraAwardsBlockTitle(param1:String) : void
        {
            this.extraAwardsContainer.setTitle(param1);
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
            var _loc2_:* = false;
            var _loc3_:* = false;
            var _loc1_:Number = 0.0;
            _loc2_ = this.basicAwardsContainer.getItemsCount() > 0;
            this.basicAwardsContainer.visible = _loc2_;
            if(_loc2_)
            {
                this.basicAwardsContainer.x = 0;
                this.basicAwardsContainer.y = _loc1_;
                _loc1_ = _loc1_ + this.basicAwardsContainer.actualHeight;
            }
            _loc3_ = this.extraAwardsContainer.getItemsCount() > 0;
            this.delimiterLine.visible = _loc3_;
            this.extraAwardsContainer.visible = _loc3_;
            if(_loc3_)
            {
                this.delimiterLine.x = 0;
                this.delimiterLine.y = _loc1_;
                this.delimiterLine.width = width;
                this.extraAwardsContainer.x = 0;
                this.extraAwardsContainer.y = _loc1_;
            }
            setSize(width,actualHeight);
            dispatchEvent(new Event(Event.RESIZE));
        }
        
        override protected function onDispose() : void
        {
            this.basicAwardsContainer.removeEventListener(Event.RESIZE,this.onBlockResize);
            this.extraAwardsContainer.removeEventListener(Event.RESIZE,this.onBlockResize);
            this.basicAwardsContainer.dispose();
            this.basicAwardsContainer = null;
            this.extraAwardsContainer.dispose();
            this.extraAwardsContainer = null;
            this.delimiterLine = null;
            super.onDispose();
        }
        
        public function getTabIndexItems() : Array
        {
            var _loc1_:Array = this.basicAwardsContainer.getTabIndexItems();
            var _loc2_:Array = this.extraAwardsContainer.getTabIndexItems();
            var _loc3_:Array = new Array();
            if(_loc1_ != null)
            {
                _loc3_ = _loc3_.concat(_loc1_);
            }
            if(_loc2_ != null)
            {
                _loc3_ = _loc3_.concat(_loc2_);
            }
            return _loc3_;
        }
    }
}
