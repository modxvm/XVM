package net.wg.gui.lobby.epicBattles.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.hangar.data.AlertMessageBlockVO;

    public class EpicBattlesWidgetVO extends DAAPIDataClass
    {

        private static const CALENDAR_STATUS_LBL:String = "calendarStatus";

        private static const EPIC_META_LEVEL_ICON_VO:String = "epicMetaLevelIconData";

        public var skillPoints:uint = 0;

        public var calendarStatus:AlertMessageBlockVO = null;

        public var epicMetaLevelIconData:EpicMetaLevelIconVO = null;

        public var showAlert:Boolean = false;

        public var canPrestige:Boolean = false;

        public function EpicBattlesWidgetVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            if(this.calendarStatus != null)
            {
                this.calendarStatus.dispose();
                this.calendarStatus = null;
            }
            if(this.epicMetaLevelIconData != null)
            {
                this.epicMetaLevelIconData.dispose();
                this.epicMetaLevelIconData = null;
            }
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == CALENDAR_STATUS_LBL)
            {
                this.calendarStatus = new AlertMessageBlockVO(param2);
                return false;
            }
            if(param1 == EPIC_META_LEVEL_ICON_VO)
            {
                this.epicMetaLevelIconData = new EpicMetaLevelIconVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
    }
}
