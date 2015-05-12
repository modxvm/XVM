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
            var tf:TextFormat = this.progressIndicator.textField.defaultTextFormat;
            tf.color = XfwConst.UICOLOR_VALUE;
            tf.size = 12;
            this.progressIndicator.textField.defaultTextFormat = tf;
        }
    }
}
