package net.wg.gui.lobby.battleResults
{
    import flash.display.MovieClip;
    
    public class BattleResultsMedalsList extends MedalsList
    {
        
        public function BattleResultsMedalsList()
        {
            super();
        }
        
        public var bgShape:MovieClip = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.bgShape.width = width;
            this.bgShape.height = height;
        }
        
        override protected function onDispose() : void
        {
            this.bgShape = null;
            super.onDispose();
        }
    }
}
