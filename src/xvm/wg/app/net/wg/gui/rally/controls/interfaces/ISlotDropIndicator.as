package net.wg.gui.rally.controls.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDropItem;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.InteractiveObject;
    
    public interface ISlotDropIndicator extends IDropItem, IUpdatable, IDisposable
    {
        
        function get index() : Number;
        
        function set index(param1:Number) : void;
        
        function set isCurrentUserCommander(param1:Boolean) : void;
        
        function set playerStatus(param1:int) : void;
        
        function setHighlightState(param1:Boolean) : void;
        
        function setAdditionalToolTipTarget(param1:InteractiveObject) : void;
        
        function removeAdditionalTooltipTarget() : void;
    }
}
