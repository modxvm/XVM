package net.wg.gui.prebattle.squads.interfaces
{
    import net.wg.gui.rally.interfaces.IBaseTeamSection;
    import net.wg.gui.rally.interfaces.IBaseChatSection;

    public interface ISquadAbstractFactory
    {

        function getTeamSection() : IBaseTeamSection;

        function getChatSection() : IBaseChatSection;
    }
}
