/**
 * XVM - comments control
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.comments
{
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.*;
    import com.xvm.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.InputEvent;
    import scaleform.gfx.*;

    public class CommentsControl extends LabelControl
    {
        public function CommentsControl()
        {
        }

        override protected function configUI():void
        {
            super.configUI();

            width = 200;
            height = 200;
            x = 300;
            y = 0;

            textField.border = true;
            textField.borderColor = 0xFFFF00;

            invalidate();
        }
    }
}
