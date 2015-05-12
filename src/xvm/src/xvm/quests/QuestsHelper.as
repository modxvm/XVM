/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.quests
{
    import com.xfw.*;
    import flash.text.*;

    public class QuestsHelper
    {
        public static function updateProgressIndicatorTextFielf(textField:TextField):void
        {
            var tf:TextFormat = textField.defaultTextFormat;
            tf.color = XfwConst.UICOLOR_VALUE;
            tf.size = 12;
            textField.defaultTextFormat = tf;
        }
    }
}
