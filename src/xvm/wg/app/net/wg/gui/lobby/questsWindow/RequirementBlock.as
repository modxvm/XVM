package net.wg.gui.lobby.questsWindow
{
    import net.wg.gui.lobby.questsWindow.components.AbstractResizableContent;
    import net.wg.gui.lobby.questsWindow.components.MovableBlocksContainer;
    import flash.events.Event;
    import net.wg.gui.events.ResizableBlockEvent;
    import net.wg.gui.lobby.questsWindow.data.RequirementBlockVO;
    import scaleform.clik.constants.InvalidationType;
    
    public class RequirementBlock extends AbstractResizableContent
    {
        
        public function RequirementBlock()
        {
            super();
        }
        
        public static var LEFT_PADDING:int = 20;
        
        private static var CONTAINER_PADDING:int = 16;
        
        public var blocksContainer:MovableBlocksContainer;
        
        public var description:DescriptionBlock;
        
        protected var data:Object = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.blocksContainer.x = LEFT_PADDING;
            this.blocksContainer.verticalPadding = CONTAINER_PADDING;
            this.blocksContainer.visible = false;
            this.blocksContainer.bottomPadding = CONTAINER_PADDING;
            this.description.visible = false;
            this.blocksContainer.addEventListener(Event.RESIZE,this.layoutBlocks);
            this.blocksContainer.addEventListener(ResizableBlockEvent.VALIDATE_SCROLL_BAR,this.layoutBlocks);
            this.description.addEventListener(Event.RESIZE,this.layoutBlocks);
        }
        
        override public function setData(param1:Object) : void
        {
            this.data = param1;
            this.description.isReadyForLayout = false;
            this.blocksContainer.isReadyForLayout = false;
            invalidateData();
        }
        
        public function setAvailableQuests(param1:Vector.<String>) : void
        {
        }
        
        override protected function draw() : void
        {
            var _loc1_:RequirementBlockVO = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.data)
                {
                    _loc1_ = new RequirementBlockVO(this.data);
                    this.description.setLabels(_loc1_.title,_loc1_.description);
                    this.blocksContainer.setData(_loc1_.containerElements);
                }
                else
                {
                    isReadyForLayout = true;
                    setSize(this.width,0);
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }
        
        protected function layoutBlocks(param1:Event) : void
        {
            var _loc2_:* = NaN;
            if((this.blocksContainer.isReadyForLayout) && (this.description.isReadyForLayout))
            {
                this.blocksContainer.y = Math.round(this.description.y + this.description.height);
                _loc2_ = Math.round(this.description.height + this.blocksContainer.height);
                setSize(this.width,_loc2_);
                this.blocksContainer.visible = true;
                this.description.visible = true;
                isReadyForLayout = true;
                dispatchEvent(new Event(Event.RESIZE));
            }
        }
        
        override protected function onDispose() : void
        {
            this.blocksContainer.removeEventListener(Event.RESIZE,this.layoutBlocks);
            this.blocksContainer.removeEventListener(ResizableBlockEvent.VALIDATE_SCROLL_BAR,this.layoutBlocks);
            this.description.removeEventListener(Event.RESIZE,this.layoutBlocks);
            this.blocksContainer.dispose();
            this.description.dispose();
            this.data = null;
            this.blocksContainer = null;
            this.description = null;
            super.onDispose();
        }
    }
}
