package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBobPlayersPanelMeta extends IEventDispatcher
    {

        function as_setLeftTeamSkill(param1:String, param2:String, param3:String) : void;

        function as_setRightTeamSkill(param1:String, param2:String, param3:String) : void;

        function as_setBattleStarted(param1:Boolean) : void;
    }
}
