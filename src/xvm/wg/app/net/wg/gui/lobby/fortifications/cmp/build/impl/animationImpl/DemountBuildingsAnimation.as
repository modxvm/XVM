package net.wg.gui.lobby.fortifications.cmp.build.impl.animationImpl
{
    import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;
    
    public class DemountBuildingsAnimation extends FortBuildingAnimationBase
    {
        
        public function DemountBuildingsAnimation()
        {
            super();
        }
        
        public var animationBuilding:IBuildingTexture;
        
        override public function dispose() : void
        {
            if(this.animationBuilding)
            {
                this.animationBuilding.dispose();
                this.animationBuilding = null;
            }
            super.dispose();
        }
        
        public function getBuildingTexture() : IBuildingTexture
        {
            return this.animationBuilding;
        }
    }
}
