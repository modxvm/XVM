import net.wargaming.ingame.Minimap;

class wot.Minimap.MinimapProxy
{
    private static var baseRef:Minimap;
    private static var wrapperRef:Minimap;
    
    public static function setReferences(base:Minimap, wrapper:Minimap):Void
    {
        baseRef = base;
        wrapperRef = wrapper;
    }
    
    public static function get base():Minimap
    {
        return baseRef;
    }
    
    public static function get wrapper():Minimap
    {
        return wrapperRef;
    }
}
