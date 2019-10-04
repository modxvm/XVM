package net.wg.gui.lobby.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.components.data.StatisticsLabelLinkageDataVO;

    public interface IStatisticsBodyContainerData extends IDisposable
    {

        function get dataListVO() : Vector.<StatisticsLabelLinkageDataVO>;
    }
}
