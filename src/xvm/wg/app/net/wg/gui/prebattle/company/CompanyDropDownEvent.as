package net.wg.gui.prebattle.company
{
    import flash.events.Event;
    import flash.display.MovieClip;
    
    public class CompanyDropDownEvent extends Event
    {
        
        public function CompanyDropDownEvent(param1:String, param2:MovieClip)
        {
            super(param1,true,true);
            this._dropDownref = param2;
        }
        
        public static var SHOW_DROP_DOWN:String = "showCrewDropDown";
        
        private var _dropDownref:MovieClip = null;
        
        public function get dropDownref() : MovieClip
        {
            return this._dropDownref;
        }
    }
}
