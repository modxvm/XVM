package net.wg.gui.rally.interfaces
{
    import net.wg.infrastructure.interfaces.ISprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    
    public interface IRallyNoSortieScreen extends ISprite, IDisposable, IUpdatable
    {
        
        function showText(param1:Boolean) : void;
    }
}
