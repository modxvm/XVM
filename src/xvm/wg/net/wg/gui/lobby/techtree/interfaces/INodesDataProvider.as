package net.wg.gui.lobby.techtree.interfaces 
{
    import flash.events.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    
    public interface INodesDataProvider extends flash.events.IEventDispatcher
    {
        function get nation():String;

        function get length():Number;

        function clearUp():void;

        function invalidate(arg1:String, arg2:Object):void;

        function parse(arg1:Object):void;

        function getRootItem():net.wg.gui.lobby.techtree.data.vo.NodeData;

        function getItemAt(arg1:Number):net.wg.gui.lobby.techtree.data.vo.NodeData;

        function getIndexByID(arg1:Number):Number;

        function getItemByID(arg1:Number):net.wg.gui.lobby.techtree.data.vo.NodeData;

        function setEarnedXP(arg1:Number, arg2:Number):Boolean;

        function setState(arg1:Number, arg2:Number, arg3:Number):Boolean;

        function setUnlockProps(arg1:Number, arg2:net.wg.gui.lobby.techtree.data.vo.UnlockProps):Boolean;

        function setDump(arg1:Number, arg2:String):Boolean;

        function setItemField(arg1:String, arg2:Number, arg3:Object):Boolean;
    }
}
