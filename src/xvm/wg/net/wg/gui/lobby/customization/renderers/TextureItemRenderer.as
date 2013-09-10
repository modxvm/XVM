package net.wg.gui.lobby.customization.renderers 
{
    import __AS3__.vec.*;
    import net.wg.data.constants.*;
    
    public class TextureItemRenderer extends net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer
    {
        public function TextureItemRenderer()
        {
            super();
            soundId = net.wg.data.constants.SoundTypes.TEXTURE_RENDERER;
            return;
        }

        protected override function setState(arg1:String):void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            if (demoMode == net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer.DEMO_NEW) 
                arg1 = "up";
            super.setState(arg1);
            var loc1:*=getStatePrefixes();
            var loc2:*=_stateMap[arg1];
            if (loc2 == null || loc2.length == 0) 
                return;
            do 
            {
                loc3 = loc1.pop().toString();
                loc4 = (loc2.length - 1);
                while (loc4 >= 0) 
                {
                    border.state = loc3 + loc2[loc4];
                    --loc4;
                }
            }
            while (loc1.length > 0);
            return;
        }
    }
}
