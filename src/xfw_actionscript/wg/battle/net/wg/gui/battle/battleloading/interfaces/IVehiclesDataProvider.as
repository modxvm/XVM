package net.wg.gui.battle.battleloading.interfaces
{
    import scaleform.clik.interfaces.IDataProvider;
    import flash.events.IEventDispatcher;
    import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;

    public interface IVehiclesDataProvider extends IDataProvider, IEventDispatcher
    {

        function setSource(param1:Array) : void;

        function setUserTags(param1:Vector.<DAAPIVehicleUserTagsVO>) : Boolean;

        function setVehicleStatus(param1:Number, param2:Number) : Boolean;

        function setPlayerStatus(param1:Number, param2:Number) : Boolean;

        function addVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>) : Boolean;

        function updateVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>) : Boolean;

        function setSorting(param1:Vector.<Number>) : Boolean;
    }
}
