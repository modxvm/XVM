package net.wg.gui.battle.tutorial.views.tutorial.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.battle.tutorial.views.tutorial.utils.tween.ITutorialTweenerHandler;

    public interface IBattleTutorialTasksPanel extends IDisposable, ITutorialTweenerHandler
    {

        function finishedAnimTaskDone() : void;
    }
}
