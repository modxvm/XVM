package net.wg.utils 
{
    public interface INations
    {
        function getNationName(arg1:uint):String;

        function getNationIcon(arg1:int):String;

        function getNationID(arg1:String):uint;

        function getNations():Array;

        function getNationsData():Array;
    }
}
