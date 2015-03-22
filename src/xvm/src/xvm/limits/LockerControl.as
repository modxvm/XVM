/**
 * XVM
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.limits
{
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.UILoaderAlt; // '*' conflicts with UI classes
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    import scaleform.gfx.*;

    public class LockerControl extends LabelControl
    {
        [Embed(source = 'resources/locked.png')]
        private var imgLockedClass:Class;
        private var imgLocked:Bitmap = new imgLockedClass();

        [Embed(source = 'resources/unlocked.png')]
        private var imgUnlockedClass:Class;
        private var imgUnlocked:Bitmap = new imgUnlockedClass();

        public function LockerControl()
        {
        }

        override protected function configUI():void
        {
            super.configUI();

            this.visible = true;
            this.focusable = false;
            this.mouseChildren = false;
            this.mouseEnabled = true;

            addChild(imgLocked);
            addChild(imgUnlocked);
            imgLocked.visible = false;
            imgUnlocked.visible = true;

            alpha = 75;
        }

        override protected function draw():void
        {
            super.draw();
        }
    }
}
