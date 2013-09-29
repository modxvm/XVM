package net.wg.infrastructure.managers.impl 
{
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.infrastructure.managers.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class SoundManager extends net.wg.infrastructure.base.meta.impl.SoundManagerMeta implements net.wg.infrastructure.managers.ISoundManager
    {
        public function SoundManager()
        {
            super();
            return;
        }

        public function playControlsSnd(arg1:String, arg2:String, arg3:String):void
        {
            soundEventHandlerS("controls", arg1, arg2, arg3);
            return;
        }

        public function addSoundsHdlrs(arg1:net.wg.infrastructure.interfaces.entity.ISoundable):void
        {
            assertNotNull(arg1, "container");
            this.subscribeObject(arg1);
            return;
        }

        public function removeSoundHdlrs(arg1:net.wg.infrastructure.interfaces.entity.ISoundable):void
        {
            assertNotNull(arg1, "container");
            this.unsubscribeObject(arg1);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            this._mouseToSoundEvents = {};
            this._mouseToSoundEvents[flash.events.MouseEvent.MOUSE_OVER] = net.wg.data.constants.SoundManagerStates.SND_OVER;
            this._mouseToSoundEvents[flash.events.MouseEvent.MOUSE_OUT] = net.wg.data.constants.SoundManagerStates.SND_OUT;
            this._mouseToSoundEvents[scaleform.clik.events.ButtonEvent.PRESS] = net.wg.data.constants.SoundManagerStates.SND_PRESS;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this._mouseToSoundEvents = null;
            return;
        }

        internal function canPlaySound(arg1:net.wg.infrastructure.interfaces.entity.ISoundable):Boolean
        {
            if (arg1 is scaleform.clik.interfaces.IUIComponent) 
            {
                return scaleform.clik.interfaces.IUIComponent(arg1).enabled;
            }
            return true;
        }

        internal function subscribeObject(arg1:net.wg.infrastructure.interfaces.entity.ISoundable):void
        {
            arg1.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseHandler);
            arg1.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseHandler);
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onMouseHandler);
            return;
        }

        internal function unsubscribeObject(arg1:net.wg.infrastructure.interfaces.entity.ISoundable):void
        {
            arg1.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseHandler);
            arg1.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseHandler);
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onMouseHandler);
            return;
        }

        internal function onMouseHandler(arg1:flash.events.Event):void
        {
            var loc1:*=net.wg.infrastructure.interfaces.entity.ISoundable(arg1.currentTarget);
            if (this.canPlaySound(loc1)) 
            {
                this.playControlsSnd(this._mouseToSoundEvents[arg1.type], loc1.getSoundType(), loc1.getSoundId());
            }
            return;
        }

        internal var _mouseToSoundEvents:Object;
    }
}
