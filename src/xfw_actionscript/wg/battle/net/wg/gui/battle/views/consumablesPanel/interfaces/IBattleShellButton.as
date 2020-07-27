package net.wg.gui.battle.views.consumablesPanel.interfaces
{
    import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;

    public interface IBattleShellButton extends IConsumablesButton, ICoolDownCompleteHandler
    {

        function setNext(param1:Boolean, param2:Boolean = false) : void;

        function get reloading() : Boolean;

        function get coolDownCurrentFrame() : int;

        function setCurrent(param1:Boolean, param2:Boolean = false) : void;

        function setQuantity(param1:int, param2:Boolean = false) : void;

        function set empty(param1:Boolean) : void;

        function get empty() : Boolean;
    }
}
