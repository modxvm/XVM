package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;
    
    public class BuildingBlinkingBtn extends MovieClip implements IDisposable
    {
        
        public function BuildingBlinkingBtn()
        {
            super();
        }
        
        public var buildingTexture:IBuildingTexture;
        
        public function dispose() : void
        {
            this.buildingTexture = null;
        }
        
        public function setState(param1:String) : void
        {
            this.buildingTexture.setState(param1);
        }
    }
}
