/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.limits.controls
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.wg.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;

    public class LockerControl extends LabelControl implements ISoundable
    {
        // Images

        private static const imgLockedPath:String = "xvm://res/locker/locked.png";
        private static const imgUnlockedPath:String = "xvm://res/locker/unlocked.png";
        private const imgLocked:ImageXVM = new ImageXVM();
        private const imgUnlocked:ImageXVM = new ImageXVM();

        // Constants

        private static const ALPHA_MOUSE_OUT:Number = 0.8;
        private static const ALPHA_MOUSE_OVER:Number = 1.0;

        // Private vars

        private var _selected:Boolean = false;

        // Initialization

        public function LockerControl()
        {
            scrollRect = new Rectangle(0, 0, 16, 16);
            setSize(16, 16);
            _selected = false;

            imgLocked.source = Utils.fixImgTagSrc(imgLockedPath);
            imgUnlocked.source = Utils.fixImgTagSrc(imgUnlockedPath);
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

            this.addChild(imgLocked);
            this.addChild(imgUnlocked);

            alpha = ALPHA_MOUSE_OUT;

            buttonMode = true;
            mouseEnabled = true;
            addEventListener(MouseEvent.ROLL_OVER, this.handleMouseRollOver);
            addEventListener(MouseEvent.ROLL_OUT, this.handleMouseRollOut);
            addEventListener(MouseEvent.MOUSE_DOWN, this.handleMousePress);
            addEventListener(MouseEvent.CLICK, this.handleMouseRelease);

            if (App.soundMgr)
                App.soundMgr.addSoundsHdlrs(this);
        }

        override protected function onDispose():void
        {
            super.onDispose();

            if (App.soundMgr)
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
            alpha = ALPHA_MOUSE_OVER;
            this.showTooltip();
        }

        protected function handleMouseRollOut(e:MouseEvent):void
        {
            alpha = ALPHA_MOUSE_OUT;
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
