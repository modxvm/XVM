package net.wg.gui.rally.controls
{
    import net.wg.infrastructure.interfaces.ISoundButtonEx;
    
    public interface IGrayTransparentButton extends ISoundButtonEx
    {
        
        function get icon() : String;
        
        function set icon(param1:String) : void;
    }
}
