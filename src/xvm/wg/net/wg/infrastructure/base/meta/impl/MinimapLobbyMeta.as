package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.training.*;
    
    public class MinimapLobbyMeta extends net.wg.gui.lobby.training.MinimapEntity
    {
        public function MinimapLobbyMeta()
        {
            super();
            return;
        }

        public function setMapS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.setMap, "setMap" + net.wg.data.constants.Errors.CANT_NULL);
            this.setMap(arg1);
            return;
        }

        public var setMap:Function=null;
    }
}
