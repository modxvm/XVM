package net.wg.gui.prebattle.squad
{
    import net.wg.data.constants.generated.PREBATTLE_ALIASES;
    
    public class SquadWindowNY extends SquadWindow
    {
        
        public function SquadWindowNY()
        {
            super();
            squadView = this.squadViewNY;
            currentView = squadView;
        }
        
        public var squadViewNY:SquadViewNY = null;
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function getViewAlias() : String
        {
            return PREBATTLE_ALIASES.SQUAD_VIEW_NY_PY;
        }
    }
}
