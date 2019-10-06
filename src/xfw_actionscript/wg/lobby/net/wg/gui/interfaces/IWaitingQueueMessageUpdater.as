package net.wg.gui.interfaces
{
    import flash.events.IEventDispatcher;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.data.WaitingQueueCounterMessageVO;

    public interface IWaitingQueueMessageUpdater extends IEventDispatcher, IDisposable
    {

        function updateData(param1:WaitingQueueCounterMessageVO) : void;
    }
}
