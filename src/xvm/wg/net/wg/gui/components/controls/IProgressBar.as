package net.wg.gui.components.controls 
{
    public interface IProgressBar
    {
        function set minimum(arg1:Number):void;

        function get minimum():Number;

        function set maximum(arg1:Number):void;

        function get maximum():Number;

        function set value(arg1:Number):void;

        function get value():Number;
    }
}
