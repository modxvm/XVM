/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar_ui.battleLoading
{
    import net.wg.gui.lobby.battleloading.vo.*;
    import xvm.hangar_ui.battleLoading.components.*;

    public dynamic class UI_RightItemRenderer extends RightItemRendererUI
    {
        private var worker:BattleLoadingItemRenderer;

        public function UI_RightItemRenderer()
        {
            super();
            worker = new BattleLoadingItemRenderer(this);
        }

        override public function setData(data:Object):void
        {
            super.setData(data);
            worker.setData(data as VehicleInfoVO);
        }

        override protected function draw():void
        {
            super.draw();
            worker.draw();
        }
    }
}
