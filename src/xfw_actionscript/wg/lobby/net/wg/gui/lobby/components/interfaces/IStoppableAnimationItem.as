package net.wg.gui.lobby.components.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IDisplayObject;

    public interface IStoppableAnimationItem extends IStoppableAnimation, IDisposable, IDisplayObject
    {

        function setImage(param1:String) : void;
    }
}
