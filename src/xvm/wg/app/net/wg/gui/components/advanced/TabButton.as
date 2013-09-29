package net.wg.gui.components.advanced 
{
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    
    public class TabButton extends net.wg.gui.components.controls.SoundButtonEx
    {
        public function TabButton()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.TAB;
            return;
        }

        public override function toString():String
        {
            return "[WG TabButton " + name + "]";
        }
    }
}
