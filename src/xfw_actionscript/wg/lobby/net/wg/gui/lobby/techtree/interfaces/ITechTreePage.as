package net.wg.gui.lobby.techtree.interfaces
{
    import net.wg.infrastructure.base.meta.ITechTreeMeta;
    import net.wg.infrastructure.base.meta.IResearchViewMeta;
    import net.wg.gui.components.controls.ScrollBar;

    public interface ITechTreePage extends ITechTreeMeta, IResearchViewMeta
    {

        function getScrollBar() : ScrollBar;
    }
}
