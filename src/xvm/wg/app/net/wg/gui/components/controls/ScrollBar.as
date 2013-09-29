package net.wg.gui.components.controls 
{
    import flash.events.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class ScrollBar extends scaleform.clik.controls.ScrollBar
    {
        public function ScrollBar()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            upArrow = this.upArrowWg;
            downArrow = this.downArrowWg;
            thumb = this.thumbWg;
            super.initialize();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        protected override function handleThumbPress(arg1:flash.events.Event):void
        {
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.buttonIdx : 0;
            if (loc2 != 0) 
            {
                return;
            }
            super.handleThumbPress(arg1);
            return;
        }

        protected override function handleTrackPress(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.buttonIdx : 0;
            if (loc2 != 0) 
            {
                return;
            }
            super.handleTrackPress(arg1);
            return;
        }

        protected override function handleTrackClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (arg1.buttonIdx != 0) 
            {
                return;
            }
            super.handleTrackClick(arg1);
            return;
        }

        public var upArrowWg:net.wg.gui.components.controls.SoundButton;

        public var downArrowWg:net.wg.gui.components.controls.SoundButton;

        public var thumbWg:net.wg.gui.components.controls.SoundButton;
    }
}
