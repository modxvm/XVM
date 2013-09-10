import gfx.controls.ButtonBar;
import net.wargaming.Carousel;
import net.wargaming.ingame.Minimap;

class com.xvm.Components.WGComponents
{
    public static function get carousel():Carousel
    {
        return _root.contentHolder.main.carousel;
    }

    public static function get headerButtons():gfx.controls.ButtonBar
    {
        return ButtonBar(_root.header.buttonsBlock.bar);
    }

    public static function get minimap():Minimap
    {
        return Minimap(_root.minimap);
    }
}
