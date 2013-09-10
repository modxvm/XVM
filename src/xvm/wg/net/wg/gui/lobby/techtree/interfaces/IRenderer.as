package net.wg.gui.lobby.techtree.interfaces 
{
    import flash.geom.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.math.*;
    import scaleform.clik.interfaces.*;
    
    public interface IRenderer extends scaleform.clik.interfaces.IUIComponent
    {
        function setup(arg1:uint, arg2:net.wg.gui.lobby.techtree.data.vo.NodeData, arg3:uint=0, arg4:net.wg.gui.lobby.techtree.math.MatrixPosition=null):void;

        function validateNowEx():void;

        function cleanUp():void;

        function get index():uint;

        function get matrixPosition():net.wg.gui.lobby.techtree.math.MatrixPosition;

        function get container():net.wg.gui.lobby.techtree.interfaces.INodesContainer;

        function set container(arg1:net.wg.gui.lobby.techtree.interfaces.INodesContainer):void;

        function getEntityType():uint;

        function getID():Number;

        function getItemName():String;

        function getItemType():String;

        function getLevel():int;

        function getIconPath():String;

        function isFake():Boolean;

        function getEarnedXP():Number;

        function getNamedLabel(arg1:String):String;

        function getDisplayInfo():Object;

        function getInX():Number;

        function getOutX():Number;

        function getY():Number;

        function getRatioY():Number;

        function setPosition(arg1:flash.geom.Point):void;

        function getActualWidth():Number;

        function getColorIdx(arg1:Number=-1):Number;

        function getColorIdxEx(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):Number;

        function isNext2Unlock():Boolean;

        function isUnlocked():Boolean;

        function isElite():Boolean;

        function isPremium():Boolean;

        function inInventory():Boolean;

        function isAvailable4Unlock():Boolean;

        function isAvailable4Buy():Boolean;

        function isAvailable4Sell():Boolean;

        function isActionEnabled():Boolean;

        function isButtonVisible():Boolean;

        function isSelected():Boolean;

        function invalidateNodeState(arg1:Number):void;
    }
}
