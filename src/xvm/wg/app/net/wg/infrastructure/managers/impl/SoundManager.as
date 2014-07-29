package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.base.meta.impl.SoundManagerMeta;
    import net.wg.infrastructure.managers.ISoundManager;
    import net.wg.infrastructure.interfaces.entity.ISoundable;
    import flash.events.MouseEvent;
    import net.wg.data.constants.SoundManagerStates;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.interfaces.IUIComponent;
    import flash.events.Event;
    
    public class SoundManager extends SoundManagerMeta implements ISoundManager
    {
        
        public function SoundManager()
        {
            super();
        }
        
        private var _mouseToSoundEvents:Object;
        
        public function playControlsSnd(param1:String, param2:String, param3:String) : void
        {
            soundEventHandlerS("controls",param1,param2,param3);
        }
        
        public function addSoundsHdlrs(param1:ISoundable) : void
        {
            assertNotNull(param1,"container");
            this.subscribeObject(param1);
        }
        
        public function removeSoundHdlrs(param1:ISoundable) : void
        {
            assertNotNull(param1,"container");
            this.unsubscribeObject(param1);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this._mouseToSoundEvents = {};
            this._mouseToSoundEvents[MouseEvent.MOUSE_OVER] = SoundManagerStates.SND_OVER;
            this._mouseToSoundEvents[MouseEvent.MOUSE_OUT] = SoundManagerStates.SND_OUT;
            this._mouseToSoundEvents[ButtonEvent.PRESS] = SoundManagerStates.SND_PRESS;
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this._mouseToSoundEvents = null;
        }
        
        private function canPlaySound(param1:ISoundable) : Boolean
        {
            if(param1 is IUIComponent)
            {
                return IUIComponent(param1).enabled;
            }
            return true;
        }
        
        private function subscribeObject(param1:ISoundable) : void
        {
            param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseHandler);
            param1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseHandler);
            param1.addEventListener(ButtonEvent.PRESS,this.onMouseHandler);
        }
        
        private function unsubscribeObject(param1:ISoundable) : void
        {
            param1.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseHandler);
            param1.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseHandler);
            param1.removeEventListener(ButtonEvent.PRESS,this.onMouseHandler);
        }
        
        private function onMouseHandler(param1:Event) : void
        {
            if(param1 is ButtonEvent)
            {
                if(ButtonEvent(param1).buttonIdx > 0)
                {
                    return;
                }
            }
            var _loc2_:ISoundable = ISoundable(param1.currentTarget);
            if(this.canPlaySound(_loc2_))
            {
                this.playControlsSnd(this._mouseToSoundEvents[param1.type],_loc2_.getSoundType(),_loc2_.getSoundId());
            }
        }
    }
}
