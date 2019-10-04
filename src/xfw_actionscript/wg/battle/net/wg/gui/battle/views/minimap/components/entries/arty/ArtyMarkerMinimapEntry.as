package net.wg.gui.battle.views.minimap.components.entries.arty
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.MovieClip;
    import net.wg.gui.battle.views.minimap.MinimapEntryController;

    public class ArtyMarkerMinimapEntry extends BattleUIComponent
    {

        private static const LOOP_ANIMATION_START:int = 32;

        private static const LOOP_ANIMATION_END:int = 91;

        public var animMc:MovieClip = null;

        public function ArtyMarkerMinimapEntry()
        {
            super();
            this.animMc.addFrameScript(LOOP_ANIMATION_END,this.loopAnimation);
            this.animMc.stop();
            MinimapEntryController.instance.registerScalableEntry(this);
        }

        override protected function onDispose() : void
        {
            this.animMc.addFrameScript(LOOP_ANIMATION_END,null);
            this.animMc.stop();
            this.animMc = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            this.animMc.visible = true;
            this.animMc.gotoAndPlay(1);
        }

        private function loopAnimation() : void
        {
            this.animMc.gotoAndPlay(LOOP_ANIMATION_START);
        }
    }
}
