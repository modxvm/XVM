package net.wg.gui.lobby.components.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IDisplayObject;
    import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;

    public interface IStoppableAnimationLoader extends IStoppableAnimation, IDisposable, IDisplayObject
    {

        function setData(param1:StoppableAnimationLoaderVO) : void;
    }
}
