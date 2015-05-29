/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.quests_ui.components
{
    import com.xfw.*;
    import flash.text.*;

    public class QuestsHelper
    {
        public static function updateProgressIndicatorTextField(textField:TextField):void
        {
            var tf:TextFormat = textField.defaultTextFormat;
            tf.color = XfwConst.UICOLOR_VALUE;
            tf.size = 12;
            textField.defaultTextFormat = tf;
        }
    }
}
