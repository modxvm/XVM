package net.wg.gui.components.controls
{
    import scaleform.clik.controls.ScrollBar;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import scaleform.gfx.MouseEventEx;
    import scaleform.clik.events.ButtonEvent;
    
    public class ScrollBar extends scaleform.clik.controls.ScrollBar
    {
        
        public function ScrollBar()
        {
            _minThumbSize = MIN_THUMB_SIZE;
            super();
        }
        
        private static var MIN_THUMB_SIZE:int = 53;
        
        public var upArrowWg:SoundButton;
        
        public var downArrowWg:SoundButton;
        
        public var thumbWg:SoundButton;
        
        override public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = undefined) : void
        {
            trackScrollPageSize = param1;
            super.setScrollProperties(param1,param2,param3,param4);
        }
        
        override public function get minThumbSize() : Number
        {
            return _minThumbSize;
        }
        
        override public function set minThumbSize(param1:Number) : void
        {
            var param1:Number = Math.max(MIN_THUMB_SIZE,param1);
            _minThumbSize = param1;
            invalidateSize();
        }
        
        override public function get enabled() : Boolean
        {
            return super.enabled;
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            upArrow.enabled = param1;
            downArrow.enabled = param1;
            thumb.enabled = param1;
            mouseEnabled = mouseChildren = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function scrollUp() : void
        {
            position = position - 1;
        }
        
        override protected function scrollDown() : void
        {
            position = position + 1;
        }
        
        override protected function initialize() : void
        {
            upArrow = this.upArrowWg;
            downArrow = this.downArrowWg;
            thumb = this.thumbWg;
            super.initialize();
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
        
        override protected function handleMouseWheel(param1:MouseEvent) : void
        {
            super.handleMouseWheel(param1);
            param1.stopPropagation();
        }
        
        override protected function handleThumbPress(param1:Event) : void
        {
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
            if(_loc3_ != 0)
            {
                return;
            }
            super.handleThumbPress(param1);
        }
        
        override protected function handleTrackPress(param1:MouseEvent) : void
        {
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
            if(_loc3_ != 0)
            {
                return;
            }
            super.handleTrackPress(param1);
        }
        
        override protected function handleTrackClick(param1:ButtonEvent) : void
        {
            if(param1.buttonIdx != 0)
            {
                return;
            }
            super.handleTrackClick(param1);
        }
    }
}
