package net.wg.gui.lobby.hangar.eventEntryPoint
{
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.infrastructure.interfaces.IDisplayObjectContainer;

    public interface IEventEntryPoint extends IDAAPIModule, IDisplayObjectContainer
    {

        function set isSmall(param1:Boolean) : void;
    }
}
