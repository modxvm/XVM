package net.wg.gui.interfaces
{
    import scaleform.clik.utils.Padding;
    
    public interface ISoundButtonEx extends ISoundButton, IHelpLayoutComponent
    {
        
        function set inspectableDisabledFillPadding(param1:Object) : void;
        
        function get disabledFillPadding() : Padding;
        
        function set disabledFillPadding(param1:Padding) : void;
        
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
