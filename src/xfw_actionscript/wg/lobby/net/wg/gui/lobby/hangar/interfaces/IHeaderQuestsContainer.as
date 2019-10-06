package net.wg.gui.lobby.hangar.interfaces
{
    import net.wg.infrastructure.interfaces.ISprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.hangar.data.HeaderQuestGroupVO;

    public interface IHeaderQuestsContainer extends IQuestsButtonsContainer, ISprite, IDisposable
    {

        function setData(param1:HeaderQuestGroupVO) : void;

        function hasInformersEqualNewData(param1:HeaderQuestGroupVO) : Boolean;

        function animExpand() : void;

        function animCollapse() : void;

        function get groupID() : String;

        function get cmptWidth() : int;
    }
}
