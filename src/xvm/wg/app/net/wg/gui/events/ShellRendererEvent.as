package net.wg.gui.events 
{
    import flash.events.*;
    import net.wg.gui.lobby.hangar.maintenance.data.*;
    
    public class ShellRendererEvent extends flash.events.Event
    {
        public function ShellRendererEvent(arg1:String, arg2:net.wg.gui.lobby.hangar.maintenance.data.ShellVO=null, arg3:net.wg.gui.lobby.hangar.maintenance.data.ShellVO=null)
        {
            super(arg1, true, true);
            this.shell = arg2;
            this.shellToReplace = arg3;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.ShellRendererEvent(type, this.shell, this.shellToReplace);
        }

        public static const USER_COUNT_CHANGED:String="userCountChanged";

        public static const TOTAL_PRICE_CHANGED:String="totalPriceChanged";

        public static const CHANGE_ORDER:String="changeOrder";

        public var shell:net.wg.gui.lobby.hangar.maintenance.data.ShellVO=null;

        public var shellToReplace:net.wg.gui.lobby.hangar.maintenance.data.ShellVO=null;
    }
}
