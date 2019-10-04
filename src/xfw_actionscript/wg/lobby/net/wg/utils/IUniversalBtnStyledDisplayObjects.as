package net.wg.utils
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.IUniversalBtnToggleIndicator;

    public interface IUniversalBtnStyledDisplayObjects extends IDisposable
    {

        function get states() : MovieClip;

        function get toggleGlow() : Sprite;

        function get toggleIndicator() : IUniversalBtnToggleIndicator;
    }
}
