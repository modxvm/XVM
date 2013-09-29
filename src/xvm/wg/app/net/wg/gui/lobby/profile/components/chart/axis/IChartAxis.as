package net.wg.gui.lobby.profile.components.chart.axis 
{
    import __AS3__.vec.*;
    import net.wg.gui.lobby.profile.components.chart.layout.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.interfaces.*;
    
    public interface IChartAxis extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function setData(arg1:scaleform.clik.interfaces.IDataProvider, arg2:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.components.chart.IChartItem>, arg3:net.wg.gui.lobby.profile.components.chart.layout.IChartLayout):void;
    }
}
