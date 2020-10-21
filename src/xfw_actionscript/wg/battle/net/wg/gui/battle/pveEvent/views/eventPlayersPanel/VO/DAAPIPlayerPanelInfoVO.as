package net.wg.gui.battle.pveEvent.views.eventPlayersPanel.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class DAAPIPlayerPanelInfoVO extends DAAPIDataClass
    {

        public var name:String = "";

        public var typeVehicle:String = "";

        public var hpMax:int = 0;

        public var hpCurrent:int = 0;

        public var vehID:uint = 0;

        public var isSquad:Boolean = false;

        public var isSelf:Boolean = false;

        public var countSouls:int = 0;

        public var squadIndex:int = 0;

        public var badgeIcon:String = "";

        public var suffixBadgeIcon:String = "";

        public var suffixBadgeStripIcon:String = "";

        public function DAAPIPlayerPanelInfoVO(param1:Object = null)
        {
            super(param1);
        }
    }
}
