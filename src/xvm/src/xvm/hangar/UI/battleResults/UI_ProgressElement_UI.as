package xvm.hangar.UI.battleResults
{
    import com.xvm.*;
    import flash.text.*;

    /**
     * @author Pavel Máca
     */
    public class UI_ProgressElement_UI extends ProgressElement_UI
    {
        public function UI_ProgressElement_UI()
        {
            super();
            progressIndicator.textField.textColor = Defines.UICOLOR_VALUE;
            var tf:TextFormat = progressIndicator.textField.defaultTextFormat;
            tf.size = 10;
            this.progressIndicator.textField.defaultTextFormat = tf;
        }
    }

}
