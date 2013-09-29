package net.wg.gui.messenger.windows 
{
    import flash.display.*;
    import scaleform.clik.utils.*;
    
    public class LazyChannelWindow extends net.wg.gui.messenger.windows.BaseChannelWindow
    {
        public function LazyChannelWindow()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints.addElement("background", this.background, scaleform.clik.utils.Constraints.ALL);
            return;
        }

        public var background:flash.display.Sprite;
    }
}
