package net.wg.gui.lobby.profile.components.chart.layout 
{
    public interface IChartLayout
    {
        function set gap(arg1:Number):void;

        function get gap():Number;

        function set paddingRight(arg1:Number):void;

        function get paddingRight():Number;

        function set paddingLeft(arg1:Number):void;

        function get paddingLeft():Number;

        function set paddingTop(arg1:Number):void;

        function get paddingTop():Number;

        function set paddingBottom(arg1:Number):void;

        function get paddingBottom():Number;

        function layout(arg1:uint, arg2:Object):void;
    }
}
