package net.wg.gui.bootcamp.battleResult.interfaces
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.bootcamp.battleResult.data.BattleItemRendererVO;

    public interface IBattleResultRenderer extends IUIComponentEx
    {

        function setData(param1:BattleItemRendererVO) : void;
    }
}
