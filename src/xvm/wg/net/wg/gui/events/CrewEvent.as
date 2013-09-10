package net.wg.gui.events 
{
    import flash.events.*;
    
    public class CrewEvent extends flash.events.Event
    {
        public function CrewEvent(arg1:String, arg2:Object=null, arg3:Boolean=false, arg4:uint=0)
        {
            super(arg1, true, true);
            this.initProp = arg2;
            this.menuEnabled = arg3;
            this.selectedTab = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.CrewEvent(type, this.initProp, this.menuEnabled);
        }

        public static const OPEN_PERSONAL_CASE:String="openPersonalCase";

        public static const UNLOAD_TANKMAN:String="unloadTankman";

        public static const DISMISS_TANKMAN:String="dismissTankman";

        public static const UNLOAD_ALL_TANKMAN:String="unloadAllTankman";

        public static const SHOW_RECRUIT_WINDOW:String="showRecruitWindow";

        public static const EQUIP_TANKMAN:String="equipTankman";

        public static const SHOW_BERTH_BUY_DIALOG:String="showBerthBuyDialog";

        public var initProp:Object;

        public var menuEnabled:Boolean;

        public var selectedTab:uint=0;
    }
}
