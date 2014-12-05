package net.wg.infrastructure.interfaces
{
    import flash.geom.Point;
    
    public interface IContextMenu
    {
        
        function build(param1:Vector.<IContextItem>, param2:Point) : void;
        
        function setMemberItemData(param1:Object) : void;
        
        function get clickPoint() : Point;
    }
}
