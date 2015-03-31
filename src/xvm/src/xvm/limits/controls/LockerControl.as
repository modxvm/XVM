/**
 * XVM
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.limits.controls
{
    import com.xvm.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;

    public class LockerControl extends LabelControl implements ISoundable
    {
        // Embedded images

        [Embed(source = 'resources/locked.png')]
        private var imgLockedClass:Class;
        private var imgLocked:Bitmap = new imgLockedClass();

        [Embed(source = 'resources/unlocked.png')]
        private var imgUnlockedClass:Class;
        private var imgUnlocked:Bitmap = new imgUnlockedClass();

        // Protected vars

        protected var _selected:Boolean = false;

        // Initialization

        public function LockerControl()
        {
        }

        // ISoundable

        public function canPlaySound(param1:String) : Boolean
        {
            return this.enabled;
        }

        public final function getSoundType() : String
        {
            return "checkBox";
        }

        public final function getSoundId() : String
        {
            return "";
        }

        public final function getStateOverSnd() : String
        {
            return SoundManagerStates.SND_OVER;
        }

        public final function getStateOutSnd() : String
        {
            return SoundManagerStates.SND_OUT;
        }

        public final function getStatePressSnd() : String
        {
            return SoundManagerStates.SND_PRESS;
        }

        // Overrides

        override protected function configUI():void
        {
            super.configUI();

            alpha = 75;

            this.addChild(imgLocked);
            this.addChild(imgUnlocked);
            imgUnlocked.x = 1;

            buttonMode = true;
            mouseEnabled = true;
            addEventListener(MouseEvent.ROLL_OVER, this.handleMouseRollOver);
            addEventListener(MouseEvent.ROLL_OUT, this.handleMouseRollOut);
            addEventListener(MouseEvent.MOUSE_DOWN, this.handleMousePress);
            addEventListener(MouseEvent.CLICK, this.handleMouseRelease);

            selected = false;

            if(App.soundMgr != null)
                App.soundMgr.addSoundsHdlrs(this);
        }

        override protected function onDispose():void
        {
            super.onDispose();

            if(App.soundMgr)
                App.soundMgr.removeSoundHdlrs(this);
        }

        override protected function draw():void
        {
            super.draw();
            if (isInvalid(InvalidationType.STATE))
            {
                imgLocked.visible = selected;
                imgUnlocked.visible = !selected;
            }
        }

        // Event handlers

        protected function handleMouseRollOver(e:MouseEvent):void
        {
            this.showTooltip();
        }

        protected function handleMouseRollOut(e:MouseEvent):void
        {
            this.hideTooltip();
        }

        protected function handleMousePress(e:MouseEvent):void
        {
            this.hideTooltip();
        }

        protected function handleMouseRelease(e:MouseEvent):void
        {
            selected = !selected;
        }

        // Public methods and properties

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(value:Boolean):void
        {
            if (this._selected == value)
                return;

            this._selected = value;
            invalidateState();
            dispatchEvent(new Event(Event.SELECT));
        }

        // Protected methods and properties

        protected function showTooltip():void
        {
            if (this.toolTip)
                App.toolTipMgr.show(this.toolTip);
        }

        protected function hideTooltip():void
        {
            App.toolTipMgr.hide();
        }
    }
}
