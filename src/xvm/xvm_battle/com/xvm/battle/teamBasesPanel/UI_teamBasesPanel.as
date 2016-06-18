/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.teamBasesPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.Linkages;

    public dynamic class UI_teamBasesPanel extends teamBasesPanelUI
    {
        private var DEFAULT_RENDERER_LENGTH:Number = xfw_RENDERER_HEIGHT;
        private var DEFAULT_CAPTURE_BAR_LINKAGE:String = Linkages.CAPTURE_BAR_LINKAGE;
        private var XVM_CAPTURE_BAR_LINKAGE:String = getQualifiedClassName(UI_TeamCaptureBar);

        public function UI_teamBasesPanel()
        {
            //Logger.add("UI_teamBasesPanel()");
            super();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
        }

        override protected function configUI():void
        {
            super.configUI();
            onConfigLoaded(null);
        }

        override public function as_add(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:String, param7:String):void
        {
            try
            {
                super.as_add(param1, param2, param3, param4, param5, param6, param7);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function onConfigLoaded(e:Event):Object
        {
            try
            {
                if (Config.config.captureBar.enabled)
                {
                    Linkages.CAPTURE_BAR_LINKAGE = XVM_CAPTURE_BAR_LINKAGE;
                    xfw_RENDERER_HEIGHT = Macros.FormatGlobalNumberValue(Config.config.captureBar.distanceOffset, 0) + DEFAULT_RENDERER_LENGTH;
                }
                else
                {
                    Linkages.CAPTURE_BAR_LINKAGE = DEFAULT_CAPTURE_BAR_LINKAGE;
                    xfw_RENDERER_HEIGHT = DEFAULT_RENDERER_LENGTH;
                }
                xfw_updatePositions();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }
    }
}
