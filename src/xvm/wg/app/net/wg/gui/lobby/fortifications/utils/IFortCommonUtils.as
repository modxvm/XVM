package net.wg.gui.lobby.fortifications.utils
{
    import net.wg.gui.lobby.fortifications.data.FortModeVO;
    import flash.display.DisplayObject;
    import flash.text.TextField;
    
    public interface IFortCommonUtils
    {
        
        function getFunctionalState(param1:FortModeVO) : Number;
        
        function fadeSomeElementSimply(param1:Boolean, param2:Boolean, param3:DisplayObject) : void;
        
        function moveElementSimply(param1:Boolean, param2:Number, param3:DisplayObject) : void;
        
        function changeTextAlign(param1:TextField, param2:String) : void;
        
        function getNextHourText(param1:int) : String;
    }
}
