package net.wg.gui.lobby.hangar.tcarousel
{
    import net.wg.infrastructure.base.meta.ITankCarouselMeta;
    import net.wg.utils.helpLayout.IHelpLayoutComponent;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.infrastructure.interfaces.IGraphicsOptimizationComponent;

    public interface ITankCarousel extends ITankCarouselMeta, IHelpLayoutComponent, IUIComponentEx, IGraphicsOptimizationComponent
    {

        function get rowCount() : int;

        function get smallDoubleCarouselEnable() : Boolean;
    }
}
