package net.wg.gui.lobby.hangar 
{
    import flash.display.*;
    import flash.events.*;
    
    public class CrewDropDownEvent extends flash.events.Event
    {
        public function CrewDropDownEvent(arg1:String, arg2:flash.display.MovieClip)
        {
            super(arg1, true, true);
            this._dropDownref = arg2;
            return;
        }

        public function get dropDownref():flash.display.MovieClip
        {
            return this._dropDownref;
        }

        public static const SHOW_DROP_DOWN:String="showCrewDropDown";

        internal var _dropDownref:flash.display.MovieClip=null;
    }
}
