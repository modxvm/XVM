package net.wg.gui.components.common.video.advanced 
{
    import net.wg.gui.components.common.video.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    
    public class KeyboardController extends net.wg.gui.components.common.video.advanced.AbstractPlayerController
    {
        public function KeyboardController(arg1:net.wg.gui.components.common.video.SimpleVideoPlayer)
        {
            super(arg1);
            videoPlayer.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            return;
        }

        internal function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=false;
            var loc2:*=arg1.details;
            var loc3:*=loc2.navEquivalent;
            switch (loc3) 
            {
                case scaleform.clik.constants.NavigationCode.ENTER:
                    if (loc2.value == scaleform.clik.constants.InputValue.KEY_UP) 
                        videoPlayer.togglePlayback();
                    break;
                case scaleform.clik.constants.NavigationCode.UP:
                case scaleform.clik.constants.NavigationCode.RIGHT:
                    if (loc2.value == scaleform.clik.constants.InputValue.KEY_HOLD || loc2.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
                    {
                        videoPlayer.volume = videoPlayer.volume + VOLUME_STEP;
                        loc1 = true;
                    }
                    break;
                case scaleform.clik.constants.NavigationCode.DOWN:
                case scaleform.clik.constants.NavigationCode.LEFT:
                    if (loc2.value == scaleform.clik.constants.InputValue.KEY_HOLD || loc2.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
                    {
                        videoPlayer.volume = videoPlayer.volume - VOLUME_STEP;
                        loc1 = true;
                    }
                    break;
            }
            if (!loc1) 
                arg1.handled = true;
            return;
        }

        public override function dispose():void
        {
            videoPlayer.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            super.dispose();
            return;
        }

        internal static const VOLUME_STEP:Number=0.01;
    }
}
