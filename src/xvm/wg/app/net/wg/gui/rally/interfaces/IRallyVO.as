package net.wg.gui.rally.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.VO.ExtendedUserVO;
    
    public interface IRallyVO extends IDisposable
    {
        
        function isAvailable() : Boolean;
        
        function get slotsArray() : Array;
        
        function get commanderVal() : ExtendedUserVO;
        
        function get description() : String;
        
        function set description(param1:String) : void;
        
        function get isCommander() : Boolean;
        
        function get statusLbl() : String;
        
        function set statusLbl(param1:String) : void;
        
        function get statusValue() : Boolean;
        
        function set statusValue(param1:Boolean) : void;
        
        function clearSlots() : void;
        
        function addSlot(param1:IRallySlotVO) : void;
    }
}
