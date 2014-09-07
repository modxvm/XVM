package net.wg.infrastructure.base.interfaces
{
    public interface IWindowGeometry
    {
        
        function canOverwrite() : Boolean;
        
        function setSize(param1:IWindow) : Boolean;
        
        function setPosition(param1:IWindow) : Boolean;
    }
}
