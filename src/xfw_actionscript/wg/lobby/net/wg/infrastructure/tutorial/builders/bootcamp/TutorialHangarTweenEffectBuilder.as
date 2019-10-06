package net.wg.infrastructure.tutorial.builders.bootcamp
{
    import scaleform.clik.motion.Tween;
    import net.wg.gui.lobby.hangar.Hangar;

    public class TutorialHangarTweenEffectBuilder extends TutorialTweenEffectBuilder
    {

        public function TutorialHangarTweenEffectBuilder()
        {
            super();
        }

        override protected function createEffect(param1:Object) : void
        {
            super.createEffect(param1);
            tween.onChange = this.onTweenChange;
        }

        private function onTweenChange(param1:Tween) : void
        {
            Hangar(view).updateAmmunitionPanelPosition();
        }
    }
}
