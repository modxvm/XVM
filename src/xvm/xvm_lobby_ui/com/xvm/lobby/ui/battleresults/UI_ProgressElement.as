/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author Pavel Máca
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.battleresults
{
    import com.xfw.*;
    import flash.text.*;

    public class UI_ProgressElement extends ProgressElement_UI
    {
        public function UI_ProgressElement()
        {
            Logger.add("UI_ProgressElement -- begin");
            super();
            var tf:TextFormat = this.progressIndicator.textField.defaultTextFormat;
            tf.color = XfwConst.UICOLOR_VALUE;
            tf.size = 12;
            this.progressIndicator.textField.defaultTextFormat = tf;

            Logger.add("UI_ProgressElement -- end");
        }
    }
}
