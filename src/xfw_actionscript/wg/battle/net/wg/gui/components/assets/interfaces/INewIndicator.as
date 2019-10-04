package net.wg.gui.components.assets.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IMovieClip;
    import flash.display.Sprite;

    public interface INewIndicator extends IDisposable, IMovieClip
    {

        function hide() : void;

        function pause() : void;

        function shine() : void;

        function get hitMC() : Sprite;
    }
}
