package com.xvm.battle.fragCorrelationBar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.battle.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.generated.*;
    import net.wg.infrastructure.interfaces.*;

    public dynamic class UI_fragCorrelationBar extends fragCorrelationBarUI
    {
        public function UI_fragCorrelationBar()
        {
            //Logger.add("UI_fragCorrelationBar");
            super();
        }

        override public function addVehiclesInfo(data:IDAAPIDataClass):void
        {
            BattleState.instance.addVehiclesInfo(data);
            super.addVehiclesInfo(data);
        }

        override public function setVehicleStats(data:IDAAPIDataClass):void
        {
            BattleState.instance.setVehicleStats(data);
            super.setVehicleStats(data);
        }

        override public function setVehiclesData(data:IDAAPIDataClass):void
        {
            BattleState.instance.setVehiclesData(data);
            super.setVehiclesData(data);
        }

        override public function updateVehicleStatus(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateVehicleStatus(data);
            super.updateVehicleStatus(data);
        }

        override public function updateVehiclesInfo(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateVehiclesInfo(data);
            super.updateVehiclesInfo(data);
        }

        override public function updatePersonalStatus(param1:uint, param2:uint):void
        {
            BattleState.instance.updatePersonalStatus(param1, param2);
            super.updatePersonalStatus(param1, param2);
        }

        override public function setPersonalStatus(param1:uint):void
        {
            BattleState.instance.setPersonalStatus(param1);
            super.setPersonalStatus(param1);
        }

        override public function updateInvitationsStatuses(data:IDAAPIDataClass) : void
        {
            BattleState.instance.updateInvitationsStatuses(data);
            super.updateInvitationsStatuses(data);
        }

        override public function updatePlayerStatus(data:IDAAPIDataClass):void
        {
            BattleState.instance.updatePlayerStatus(data);
            super.updatePlayerStatus(data);
        }

        override public function updateUserTags(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateUserTags(data);
            super.updateUserTags(data);
        }

        override public function updateVehiclesStats(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateVehiclesStats(data);
            super.updateVehiclesStats(data);
        }

        override public function setUserTags(data:IDAAPIDataClass):void
        {
            BattleState.instance.setUserTags(data);
            super.setUserTags(data);
        }

        override public function setArenaInfo(data:IDAAPIDataClass):void
        {
            BattleState.instance.setArenaInfo(data);
            super.setArenaInfo(data);
        }
    }
}
