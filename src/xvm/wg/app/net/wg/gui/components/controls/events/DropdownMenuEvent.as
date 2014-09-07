package net.wg.gui.components.controls.events
{
    import flash.events.Event;
    import flash.display.MovieClip;
    
    public class DropdownMenuEvent extends Event
    {
        
        public function DropdownMenuEvent(param1:String, param2:MovieClip)
        {
            super(param1,true,true);
            this._dropDownRef = param2;
        }
        
        public static var SHOW_DROP_DOWN:String = "showDropDown";
        
        public static var CLOSE_DROP_DOWN:String = "closeDropDown";
        
        private var _dropDownRef:MovieClip = null;
        
        public function get dropDownRef() : MovieClip
        {
            return this._dropDownRef;
        }
    }
}
