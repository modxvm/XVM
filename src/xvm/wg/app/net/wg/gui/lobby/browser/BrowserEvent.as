package net.wg.gui.lobby.browser 
{
    import flash.events.*;
    
    public class BrowserEvent extends flash.events.Event
    {
        public function BrowserEvent(arg1:String, arg2:Number=0, arg3:Number=0, arg4:int=0)
        {
            super(arg1, true, true);
            this.mouseX = arg2;
            this.mouseY = arg3;
            this.delta = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.lobby.browser.BrowserEvent(type, this.mouseX, this.mouseY, this.delta);
        }

        public static const ACTION_LOADING:String="loading";

        public static const ACTION_RELOAD:String="reload";

        public static const BROWSER_MOVE:String="browserMove";

        public static const BROWSER_DOWN:String="browserDown";

        public static const BROWSER_UP:String="browserUp";

        public static const BROWSER_FOCUS_IN:String="browserFocusIn";

        public static const BROWSER_FOCUS_OUT:String="browserFocusOut";

        public var mouseX:Number;

        public var mouseY:Number;

        public var delta:int;
    }
}
