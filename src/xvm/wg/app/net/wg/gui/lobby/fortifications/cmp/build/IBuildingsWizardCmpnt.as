package net.wg.gui.lobby.fortifications.cmp.build
{
    public interface IBuildingsWizardCmpnt
    {
        
        function enterIntoTransportingTutorialMode() : void;
        
        function leaveFromTransportingTutorialMode() : void;
        
        function enterIntoBuildDirectionTutorialMode() : void;
        
        function leaveFromBuildDirectionTutorialMode() : void;
        
        function enterIntoBuildingTutorialMode() : void;
    }
}
