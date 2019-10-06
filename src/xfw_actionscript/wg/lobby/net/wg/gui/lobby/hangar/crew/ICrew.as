package net.wg.gui.lobby.hangar.crew
{
    import net.wg.utils.helpLayout.IHelpLayoutComponent;
    import net.wg.infrastructure.base.meta.ICrewMeta;
    import net.wg.infrastructure.interfaces.IDAAPIModule;

    public interface ICrew extends IHelpLayoutComponent, ICrewMeta, IDAAPIModule
    {

        function updateSize(param1:Number) : void;
    }
}
