package net.wg.infrastructure.interfaces
{
    public interface ISoundButtonEx extends ISoundButton, IHelpLayoutComponent
    {
        
        function get fillPadding() : Number;
        
        function set fillPadding(param1:Number) : void;
        
        function get helpConnectorLength() : Number;
        
        function set helpConnectorLength(param1:Number) : void;
        
        function get helpDirection() : String;
        
        function set helpDirection(param1:String) : void;
        
        function get helpText() : String;
        
        function set helpText(param1:String) : void;
        
        function get paddingHorizontal() : Number;
        
        function set paddingHorizontal(param1:Number) : void;
        
        function get tooltip() : String;
        
        function set tooltip(param1:String) : void;
    }
}
