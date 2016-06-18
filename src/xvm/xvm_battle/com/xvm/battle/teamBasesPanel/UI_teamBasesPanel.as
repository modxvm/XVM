/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.teamBasesPanel
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class UI_teamBasesPanel extends teamBasesPanelUI
    {
        public function UI_teamBasesPanel()
        {
            Logger.add("UI_teamBasesPanel()");
            super();
        }

        override public function as_updateCaptureData(param1:Number, param2:Number, param3:Number, param4:String, param5:String):void
        {
            Logger.addObject(arguments);
            super.as_updateCaptureData(param1, param2, param3, param4, param5);
        }

        // PRIVATE

    }
}
