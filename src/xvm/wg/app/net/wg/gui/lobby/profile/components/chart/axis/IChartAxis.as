package net.wg.gui.lobby.profile.components.chart.axis
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.gui.lobby.profile.components.chart.IChartItem;
    import net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;
    
    public interface IChartAxis extends IDisposable
    {
        
        function setData(param1:IDataProvider, param2:Vector.<IChartItem>, param3:IChartLayout) : void;
        
        function getData() : Object;
    }
}
