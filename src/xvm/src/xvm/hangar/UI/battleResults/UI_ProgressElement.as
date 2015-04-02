package xvm.hangar.UI.battleResults
{
    import com.xfw.*;
    import flash.text.*;

    /**
     * @author Pavel Máca
     */
    public class UI_ProgressElement extends ProgressElement_UI
    {
        public function UI_ProgressElement()
        {
            super();
            progressIndicator.textField.textColor = Defines.UICOLOR_VALUE;
            var tf:TextFormat = progressIndicator.textField.defaultTextFormat;
            tf.size = 10;
            this.progressIndicator.textField.defaultTextFormat = tf;
        }
    }
}
