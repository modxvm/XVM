package net.wg.gui.lobby.badges.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class BadgeVO extends DAAPIDataClass
    {

        public var id:int = -1;

        public var icon:String = "";

        public var title:String = "";

        public var description:String = "";

        public var enabled:Boolean = true;

        public var selected:Boolean = false;

        public var tooltip:String = "";

        public var highlightIcon:String = "";

        public var isFirstLook:Boolean = false;

        public function BadgeVO(param1:Object)
        {
            super(param1);
        }
    }
}
