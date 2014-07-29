package net.wg.gui.lobby.browser
{
    import flash.events.Event;
    
    public class BrowserEvent extends Event
    {
        
        public function BrowserEvent(param1:String, param2:Number = 0, param3:Number = 0, param4:int = 0)
        {
            super(param1,true,true);
            this.mouseX = param2;
            this.mouseY = param3;
            this.delta = param4;
        }
        
        public static var ACTION_LOADING:String = "loading";
        
        public static var ACTION_RELOAD:String = "reload";
        
        public static var BROWSER_MOVE:String = "browserMove";
        
        public static var BROWSER_DOWN:String = "browserDown";
        
        public static var BROWSER_UP:String = "browserUp";
        
        public static var BROWSER_FOCUS_IN:String = "browserFocusIn";
        
        public static var BROWSER_FOCUS_OUT:String = "browserFocusOut";
        
        public var mouseX:Number;
        
        public var mouseY:Number;
        
        public var delta:int;
        
        override public function clone() : Event
        {
            return new BrowserEvent(type,this.mouseX,this.mouseY,this.delta);
        }
    }
}
