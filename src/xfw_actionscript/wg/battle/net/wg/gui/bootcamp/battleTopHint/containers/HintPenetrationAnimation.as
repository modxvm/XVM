package net.wg.gui.bootcamp.battleTopHint.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.infrastructure.events.ColorSchemeEvent;
    import net.wg.data.constants.ColorSchemeNames;
    import net.wg.infrastructure.interfaces.IColorScheme;

    public class HintPenetrationAnimation extends MovieClip implements IDisposable
    {

        public var txtPenetrationHigh:AnimatedTextContainer = null;

        public var txtPenetrationLow:AnimatedTextContainer = null;

        public var penetrationBlind:HintBlindContainer = null;

        public function HintPenetrationAnimation()
        {
            super();
            this.txtPenetrationHigh.text = BOOTCAMP.LOADING_TIP_SNIPER_DESCRIPTION_1;
            this.txtPenetrationLow.text = BOOTCAMP.LOADING_TIP_SNIPER_DESCRIPTION_2;
            App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
            this.updatePenetration();
        }

        public final function dispose() : void
        {
            App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
            this.penetrationBlind.dispose();
            this.penetrationBlind = null;
            this.txtPenetrationHigh.dispose();
            this.txtPenetrationLow.dispose();
            this.txtPenetrationHigh = null;
            this.txtPenetrationLow = null;
        }

        protected function updatePenetration() : void
        {
            var _loc1_:IColorScheme = App.colorSchemeMgr.getScheme(ColorSchemeNames.RED_PURPLE_SCHEMA);
            this.txtPenetrationLow.textColor = _loc1_.rgb;
        }

        private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
        {
            this.updatePenetration();
        }
    }
}
