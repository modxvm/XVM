package net.wg.gui.battle.views.consumablesPanel.interfaces
{
    import net.wg.gui.battle.components.buttons.interfaces.IBattleToolTipButton;
    import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
    import flash.geom.ColorTransform;

    public interface IConsumablesButton extends IBattleToolTipButton
    {

        function get consumablesVO() : ConsumablesVO;

        function set icon(param1:String) : void;

        function set key(param1:Number) : void;

        function set quantity(param1:int) : void;

        function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:Boolean) : void;

        function setCoolDownPosAsPercent(param1:Number) : void;

        function setColorTransform(param1:ColorTransform) : void;

        function clearColorTransform() : void;

        function setActivated() : void;

        function clearCoolDownTime() : void;

        function showGlow(param1:int) : void;

        function hideGlow() : void;

        function setTimerSnapshot(param1:int, param2:Boolean) : void;

        function get showConsumableBorder() : Boolean;

        function set showConsumableBorder(param1:Boolean) : void;

        function setStage(param1:int) : void;
    }
}
