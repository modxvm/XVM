package net.wg.gui.lobby.fortifications.cmp.build
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import flash.display.MovieClip;
    
    public interface IBuildingTexture extends IUIComponentEx
    {
        
        function getBuildingShape() : MovieClip;
        
        function setState(param1:String) : void;
    }
}
