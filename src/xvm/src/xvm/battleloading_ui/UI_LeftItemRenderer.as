/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading_ui
{
    import com.xfw.*;
    import net.wg.gui.lobby.battleloading.vo.*;
    import xvm.battleloading_ui.components.*;

    public dynamic class UI_LeftItemRenderer extends LeftItemRendererUI
    {
        private var worker:BattleLoadingItemRenderer;

        public function UI_LeftItemRenderer()
        {
            try
            {
                super();
                worker = new BattleLoadingItemRenderer(this);
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
