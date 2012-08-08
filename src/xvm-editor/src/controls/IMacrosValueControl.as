package controls
{
    public interface IMacrosValueControl {
        //function get allowedMacros():Array;
        function set allowedMacros(v:Array):void;

        function get menuData():Array;
        function set menuData(v:Array):void;

        function getLabel(item:Object):String;
    }
}
