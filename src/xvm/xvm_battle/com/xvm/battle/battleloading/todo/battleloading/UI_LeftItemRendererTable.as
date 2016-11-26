/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.battleloading
{
    import com.xfw.*;
    import com.xvm.lobby.ui.battleloading.components.*;
    import net.wg.gui.lobby.battleloading.vo.*;

    public /*dynamic*/ class UI_LeftItemRendererTable extends LeftItemRendererTableUI
    {
        private var proxy:BattleLoadingItemRendererProxy;

        public function UI_LeftItemRendererTable()
        {
            try
            {
                super();
                proxy = new BattleLoadingItemRendererProxy(this, BattleLoadingItemRendererProxy.UI_TYPE_TABLE, true);
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
                proxy.configUI();
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
                proxy.onDispose();
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
                super.setData(proxy.fixData(data as VehicleInfoVO));
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
                proxy.draw();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
