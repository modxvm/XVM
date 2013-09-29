package net.wg.gui.messenger.controls 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.messenger.controls.ChannelItemRenderer, net.wg.gui.messenger.controls.MemberItemRenderer]));
            return;
        }
    }
}
