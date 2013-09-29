package net.wg.gui.lobby.customization.renderers 
{
    import __AS3__.vec.*;
    import net.wg.data.constants.*;
    
    public class CamouflageItemRenderer extends net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer
    {
        public function CamouflageItemRenderer()
        {
            super();
            soundId = net.wg.data.constants.SoundTypes.CAMOUFLAGE_RENDERER;
            return;
        }

        protected override function setState(arg1:String):void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            super.setState(arg1);
            var loc1:*=getStatePrefixes();
            var loc2:*=_stateMap[arg1];
            if (loc2 == null || loc2.length == 0) 
            {
                return;
            }
            do 
            {
                loc5 = loc1.pop().toString();
                loc3 = (loc2.length - 1);
                while (loc3 >= 0) 
                {
                    if ((loc4 = loc5 + loc2[loc3]) != border.state) 
                    {
                        border.state = loc4;
                    }
                    --loc3;
                }
            }
            while (loc1.length > 0);
            return;
        }
    }
}
