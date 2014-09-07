package net.wg.gui.prebattle.battleSession
{
    import net.wg.gui.lobby.battleResults.CustomAchievement;
    
    public class BSFlagRenderer extends CustomAchievement
    {
        
        public function BSFlagRenderer()
        {
            super();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            buttonMode = false;
        }
    }
}
