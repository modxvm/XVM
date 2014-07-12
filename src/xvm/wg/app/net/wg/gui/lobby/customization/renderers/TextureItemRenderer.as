package net.wg.gui.lobby.customization.renderers
{
    import net.wg.data.constants.SoundTypes;
    
    public class TextureItemRenderer extends CustomizationItemRenderer
    {
        
        public function TextureItemRenderer() {
            super();
            soundId = SoundTypes.TEXTURE_RENDERER;
        }
        
        override protected function setState(param1:String) : void {
            var _loc4_:String = null;
            var _loc5_:* = NaN;
            if(demoMode == CustomizationItemRenderer.DEMO_NEW)
            {
                param1 = "up";
            }
            super.setState(param1);
            var _loc2_:Vector.<String> = getStatePrefixes();
            var _loc3_:Array = _stateMap[param1];
            if(_loc3_ == null || _loc3_.length == 0)
            {
                return;
            }
            do
            {
                _loc4_ = _loc2_.pop().toString();
                _loc5_ = _loc3_.length - 1;
                while(_loc5_ >= 0)
                {
                    border.state = _loc4_ + _loc3_[_loc5_];
                    _loc5_--;
                }
            }
            while(_loc2_.length > 0);
            
        }
    }
}
