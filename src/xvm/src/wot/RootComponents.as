import net.wargaming.Carousel;
import net.wargaming.ingame.Minimap;

class wot.RootComponents
{
    public static function get carousel():Carousel
    {
        return _root.contentHolder.main.carousel;
    }

    public static function get minimap():Minimap
    {
        return Minimap(_root.minimap);
    }    
}
