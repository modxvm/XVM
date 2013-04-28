import net.wargaming.Carousel;

class wot.RootComponents
{
    public static function get carousel():Carousel
    {
        return _root.contentHolder.main.carousel;
    }
    
}