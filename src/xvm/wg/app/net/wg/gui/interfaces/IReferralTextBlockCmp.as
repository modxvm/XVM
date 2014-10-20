package net.wg.gui.interfaces
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    
    public interface IReferralTextBlockCmp extends IUIComponentEx, IUpdatable
    {
        
        function get paddingY() : int;
        
        function set paddingY(param1:int) : void;
        
        function get paddingX() : int;
        
        function set paddingX(param1:int) : void;
    }
}
