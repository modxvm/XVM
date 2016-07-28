/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.teamBasesPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.utils.*;
    import net.wg.data.constants.*;

    public dynamic class UI_teamBasesPanel extends teamBasesPanelUI
    {
        private var DEFAULT_RENDERER_LENGTH:Number = xfw_RENDERER_HEIGHT;
        private var DEFAULT_CAPTURE_BAR_LINKAGE:String = Linkages.CAPTURE_BAR_LINKAGE;
        private var XVM_CAPTURE_BAR_LINKAGE:String = getQualifiedClassName(UI_TeamCaptureBar);
        private var DEFAULT_Y:Number;

        public function UI_teamBasesPanel()
        {
            //Logger.add("UI_teamBasesPanel()");
            super();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xfw.addCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, setup);
        }

        override protected function configUI():void
        {
            super.configUI();
            DEFAULT_Y = y;
            setup();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xfw.removeCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, setup);
            super.onDispose();
        }

        // PRIVATE

        private function setup():void
        {
            //Xvm.swfProfilerBegin("UI_teamBasesPanel.update()");
            try
            {
                if (Macros.FormatBooleanGlobal(Config.config.captureBar.enabled, true))
                {
                    Linkages.CAPTURE_BAR_LINKAGE = XVM_CAPTURE_BAR_LINKAGE;
                    y = Macros.FormatNumberGlobal(Config.config.captureBar.y, DEFAULT_Y);
                    xfw_RENDERER_HEIGHT = Macros.FormatNumberGlobal(Config.config.captureBar.distanceOffset, 0) + DEFAULT_RENDERER_LENGTH;
                }
                else
                {
                    Linkages.CAPTURE_BAR_LINKAGE = DEFAULT_CAPTURE_BAR_LINKAGE;
                    y = DEFAULT_Y;
                    xfw_RENDERER_HEIGHT = DEFAULT_RENDERER_LENGTH;
                }
                xfw_updatePositions();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("UI_teamBasesPanel.update()");
        }
    }
}
