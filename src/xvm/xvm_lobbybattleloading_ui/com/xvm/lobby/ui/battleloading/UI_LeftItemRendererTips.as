/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.battleloading
{
    import com.xfw.*;
    import com.xvm.lobby.ui.battleloading.components.*;
    import net.wg.gui.lobby.battleloading.vo.*;

    public dynamic class UI_LeftItemRendererTips extends LeftItemRendererTipsUI
    {
        private var worker:BattleLoadingItemRenderer;

        public function UI_LeftItemRendererTips()
        {
            try
            {
                super();
                worker = new BattleLoadingItemRenderer(this, BattleLoadingItemRenderer.PROXY_TYPE_TIPS);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function configUI():void
        {
            try
            {
                super.configUI();
                worker.configUI();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function onDispose():void
        {
            try
            {
                worker.onDispose();
                super.onDispose();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function setData(data:Object):void
        {
            try
            {
                super.setData(worker.fixData(data as VehicleInfoVO));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function draw():void
        {
            try
            {
                super.draw();
                worker.draw();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
