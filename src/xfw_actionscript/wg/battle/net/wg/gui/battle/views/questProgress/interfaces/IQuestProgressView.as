package net.wg.gui.battle.views.questProgress.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IDisplayObject;

    public interface IQuestProgressView extends IQuestProgressViewUpdatable, IDisposable, IDisplayObject
    {

        function hideView(param1:Function, param2:int) : void;

        function showView(param1:Function, param2:int) : void;

        function playSnd(param1:String) : void;

        function get isQPVisibleBySettings() : Boolean;
    }
}
