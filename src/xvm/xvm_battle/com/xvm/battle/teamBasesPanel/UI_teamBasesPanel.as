/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.teamBasesPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.events.*;

    public dynamic class UI_teamBasesPanel extends teamBasesPanelUI
    {
        private var DEFAULT_RENDERER_LENGTH:Number = xfw_RENDERER_HEIGHT;

        public function UI_teamBasesPanel()
        {
            Logger.add("UI_teamBasesPanel()");
            super();

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
        }

        override protected function configUI():void
        {
            super.configUI();

            onConfigLoaded(null);
        }

        override public function as_updateCaptureData(param1:Number, param2:Number, param3:Number, param4:String, param5:String):void
        {
            //Logger.addObject(arguments);
            super.as_updateCaptureData(param1, param2, param3, param4, param5);
        }

        // PRIVATE

        private function onConfigLoaded(e:Event):Object
        {
            Logger.add("UI_teamBasesPanel.onConfigLoaded()");
            try
            {
                xfw_RENDERER_HEIGHT = Macros.FormatGlobalNumberValue(Config.config.captureBar.distanceOffset, 0) + DEFAULT_RENDERER_LENGTH;
                Logger.add(String(xfw_RENDERER_HEIGHT));
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
