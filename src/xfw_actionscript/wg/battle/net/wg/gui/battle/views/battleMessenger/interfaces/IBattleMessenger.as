package net.wg.gui.battle.views.battleMessenger.interfaces
{
    import net.wg.infrastructure.base.meta.IBattleMessengerMeta;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;

    public interface IBattleMessenger extends IBattleMessengerMeta, IFocusContainer, IClickButtonHandler
    {
    }
}
