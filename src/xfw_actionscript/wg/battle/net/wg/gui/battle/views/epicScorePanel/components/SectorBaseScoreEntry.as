package net.wg.gui.battle.views.epicScorePanel.components
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import net.wg.gui.battle.components.EpicProgressCircle;
    import flash.display.MovieClip;

    public class SectorBaseScoreEntry extends BattleUIComponent
    {

        public var progressCapture:EpicProgressCircle = null;

        public var baseId:MovieClip = null;

        public var colourBG:MovieClip = null;

        public function SectorBaseScoreEntry()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.progressCapture.dispose();
            this.progressCapture = null;
            this.baseId.stop();
            this.baseId = null;
            this.colourBG = null;
            super.onDispose();
        }

        public function setBaseId(param1:int) : void
        {
            this.baseId.gotoAndStop(param1);
        }
    }
}
