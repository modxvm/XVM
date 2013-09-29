package net.wg.infrastructure.interfaces 
{
    public interface IWindowGeometry
    {
        function canOverwrite():Boolean;

        function setSize(arg1:net.wg.infrastructure.interfaces.IWindow):Boolean;

        function setPosition(arg1:net.wg.infrastructure.interfaces.IWindow):Boolean;
    }
}
