package net.wg.data.constants 
{
    import __AS3__.vec.*;
    
    public class ContainerTypes extends Object
    {
        public function ContainerTypes()
        {
            super();
            return;
        }

        public static const VIEW:String="view";

        public static const LOBBY_SUB_VIEW:String="lobbySubView";

        public static const WINDOW:String="window";

        public static const DIALOG:String="dialog";

        public static const CURSOR:String="cursor";

        public static const WAITING:String="waiting";

        public static const SERVICE_LAYOUT:String="serviceLayout";

        public static const CTNR_ORDER:__AS3__.vec.Vector.<String>=Vector.<String>([SERVICE_LAYOUT, DIALOG, WINDOW, LOBBY_SUB_VIEW, VIEW]);
    }
}
