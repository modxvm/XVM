package net.wg.gui.components.common.video.advanced
{
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import scaleform.clik.constants.NavigationCode;
    import net.wg.gui.components.common.video.SimpleVideoPlayer;
    
    public class KeyboardController extends AbstractPlayerController
    {
        
        public function KeyboardController(param1:SimpleVideoPlayer) {
            super(param1);
            videoPlayer.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
        }
        
        private static var VOLUME_STEP:Number = 0.01;
        
        private function handleInput(param1:InputEvent) : void {
            var _loc2_:* = false;
            var _loc3_:InputDetails = param1.details;
            switch(_loc3_.navEquivalent)
            {
                case NavigationCode.ENTER:
                    if(_loc3_.value == InputValue.KEY_UP)
                    {
                        videoPlayer.togglePlayback();
                    }
                    break;
                case NavigationCode.UP:
                case NavigationCode.RIGHT:
                    if(_loc3_.value == InputValue.KEY_HOLD || _loc3_.value == InputValue.KEY_DOWN)
                    {
                        videoPlayer.volume = videoPlayer.volume + VOLUME_STEP;
                        _loc2_ = true;
                    }
                    break;
                case NavigationCode.DOWN:
                case NavigationCode.LEFT:
                    if(_loc3_.value == InputValue.KEY_HOLD || _loc3_.value == InputValue.KEY_DOWN)
                    {
                        videoPlayer.volume = videoPlayer.volume - VOLUME_STEP;
                        _loc2_ = true;
                    }
                    break;
            }
            if(!_loc2_)
            {
                param1.handled = true;
            }
        }
        
        override protected function onDispose() : void {
            videoPlayer.removeEventListener(InputEvent.INPUT,this.handleInput);
            super.onDispose();
        }
    }
}
