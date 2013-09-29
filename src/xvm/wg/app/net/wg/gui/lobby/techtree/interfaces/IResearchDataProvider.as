package net.wg.gui.lobby.techtree.interfaces 
{
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.math.*;
    
    public interface IResearchDataProvider extends net.wg.gui.lobby.techtree.interfaces.INodesDataProvider
    {
        function get topLength():Number;

        function populate(arg1:net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder):void;

        function getGlobalStats():net.wg.gui.lobby.techtree.data.vo.VehGlobalStats;

        function getDepthOfPath(arg1:Number):Number;

        function getMaxDepthOfPath():Number;

        function getTopLevelAt(arg1:Number):net.wg.gui.lobby.techtree.data.vo.NodeData;

        function getTopLevelIndexByID(arg1:Number):Number;

        function setTopLevelState(arg1:Number, arg2:Number, arg3:Number):Boolean;

        function setTopLevelXP(arg1:Number, arg2:Number):Boolean;

        function setTopLevelUnlockProps(arg1:Number, arg2:net.wg.gui.lobby.techtree.data.vo.UnlockProps):Boolean;

        function setTopLevelDump(arg1:Number, arg2:String):Boolean;

        function setTopLevelField(arg1:String, arg2:Number, arg3:Object):Boolean;

        function resolveEntityType(arg1:net.wg.gui.lobby.techtree.data.vo.NodeData, arg2:Boolean=false):uint;
    }
}
