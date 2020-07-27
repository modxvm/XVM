/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public class BattleXvmComponentController implements IBattleComponentDataController, IDisposable
    {
        public function BattleXvmComponentController()
        {
            //Logger.add("BattleXvmComponentController");
            super();
        }

        public final function dispose():void
        {
            onDispose();
        }

        protected function onDispose():void
        {
            // empty
        }

        public function addVehiclesInfo(data:IDAAPIDataClass):void
        {
            BattleState.instance.addVehiclesInfo(data);
        }

        public function resetFrags():void
        {
            BattleState.instance.resetFrags();
        }

        public function setArenaInfo(data:IDAAPIDataClass):void
        {
            // empty
        }

        public function setFrags(data:IDAAPIDataClass):void
        {
            BattleState.instance.setFrags(data);
        }

        public function setPersonalStatus(param1:uint):void
        {
            BattleState.instance.setPersonalStatus(param1);
        }

        public function setQuestStatus(data:IDAAPIDataClass):void
        {
            BattleState.instance.setQuestStatus(data);
        }

        public function setUserTags(data:IDAAPIDataClass):void
        {
            BattleState.instance.setUserTags(data);
        }

        public function setVehiclesData(data:IDAAPIDataClass):void
        {
            BattleState.instance.setVehiclesData(data);
        }

        public function updateInvitationsStatuses(data:IDAAPIDataClass) : void
        {
            BattleState.instance.updateInvitationsStatuses(data);
        }

        public function updatePersonalStatus(param1:uint, param2:uint):void
        {
            BattleState.instance.updatePersonalStatus(param1, param2);
        }

        public function updatePlayerStatus(data:IDAAPIDataClass):void
        {
            BattleState.instance.updatePlayerStatus(data);
        }

        public function updateUserTags(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateUserTags(data);
        }

        public function updateVehiclesData(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateVehiclesData(data);
        }

        public function updateVehiclesStat(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateVehiclesStat(data);
        }

        public function updateVehicleStatus(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateVehicleStatus(data);
        }

        public function updateTriggeredChatCommands(data:IDAAPIDataClass):void
        {
            BattleState.instance.updateTriggeredChatCommands(data);
        }
    }
}
