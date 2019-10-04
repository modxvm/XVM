package net.wg.gui.battle.views.questProgress.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;

    public interface IQuestProgressDataHub extends IDisposable
    {

        function getData() : Vector.<IQuestProgressItemData>;
    }
}
