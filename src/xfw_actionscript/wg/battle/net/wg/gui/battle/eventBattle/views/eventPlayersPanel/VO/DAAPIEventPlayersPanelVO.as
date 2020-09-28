package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class DAAPIEventPlayersPanelVO extends DAAPIDataClass
    {

        private static const LEFT_TEAM_FIELD_NAME:String = "leftTeam";

        private static const RIGHT_TEAM_FIELD_NAME:String = "rightTeam";

        public var leftTeam:Vector.<DAAPIPlayerPanelInfoVO> = null;

        public var rightTeam:Vector.<DAAPIPlayerPanelInfoVO> = null;

        public function DAAPIEventPlayersPanelVO(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            switch(param1)
            {
                case LEFT_TEAM_FIELD_NAME:
                    this.leftTeam = Vector.<DAAPIPlayerPanelInfoVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPIPlayerPanelInfoVO));
                    return false;
                case RIGHT_TEAM_FIELD_NAME:
                    this.rightTeam = Vector.<DAAPIPlayerPanelInfoVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPIPlayerPanelInfoVO));
                    return false;
                default:
                    return super.onDataWrite(param1,param2);
            }
        }

        override protected function onDispose() : void
        {
            var _loc1_:DAAPIPlayerPanelInfoVO = null;
            if(this.leftTeam)
            {
                for each(_loc1_ in this.leftTeam)
                {
                    _loc1_.dispose();
                }
                this.leftTeam.fixed = false;
                this.leftTeam.splice(0,this.leftTeam.length);
                this.leftTeam = null;
            }
            if(this.rightTeam)
            {
                for each(_loc1_ in this.rightTeam)
                {
                    _loc1_.dispose();
                }
                this.rightTeam.fixed = false;
                this.rightTeam.splice(0,this.rightTeam.length);
                this.rightTeam = null;
            }
            super.onDispose();
        }
    }
}
