package net.wg.gui.lobby.hangar.interfaces
{
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.hangar.data.HeaderQuestsVO;
    import flash.geom.Point;

    public interface IQuestInformerButton extends ISoundButtonEx
    {

        function setData(param1:HeaderQuestsVO) : void;

        function setCollapsePoint(param1:int, param2:int) : void;

        function setExpandPoint(param1:int, param2:int) : void;

        function showContent(param1:Boolean, param2:int) : void;

        function hideContent(param1:Boolean, param2:int) : void;

        function get questType() : String;

        function get questID() : String;

        function get collapsePoint() : Point;

        function get expandPoint() : Point;

        function get isEnable() : Boolean;
    }
}
