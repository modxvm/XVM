package net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;

    public interface IPlayersPanelListItemHolder extends IDisposable
    {

        function get playerStatus() : uint;

        function setVehicleData(param1:DAAPIVehicleInfoVO) : void;

        function setFrags(param1:int) : void;

        function setChatCommand(param1:String, param2:uint) : void;

        function get vehicleID() : Number;

        function get accountDBID() : Number;

        function setUserTags(param1:Array) : void;

        function setPlayerStatus(param1:int) : void;

        function setInvitationStatus(param1:uint) : void;

        function setVehicleStatus(param1:int) : void;

        function get isInviteReceived() : Boolean;

        function get isCurrentPlayer() : Boolean;

        function triggerChatCommand(param1:String) : void;
    }
}
