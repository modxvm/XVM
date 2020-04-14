package net.wg.gui.bootcamp
{
    import net.wg.infrastructure.base.meta.impl.BCBattlePageMeta;
    import net.wg.infrastructure.base.meta.IBCBattlePageMeta;
    import net.wg.gui.bootcamp.battleTopHint.BCBattleTopHint;
    import net.wg.gui.bootcamp.controls.BCAppearMinimapHint;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import net.wg.gui.bootcamp.events.AppearEvent;
    import flash.display.Stage;
    import net.wg.gui.battle.views.minimap.events.MinimapEvent;

    public class BCBattlePage extends BCBattlePageMeta implements IBCBattlePageMeta
    {

        private static const SEC_HINT_OFFSET_Y:int = 30;

        private static const RIBBONS_CENTER_SCREEN_OFFSET_Y:int = 185;

        public var secondaryHint:BCSecondaryHint;

        public var battleTopHint:BCBattleTopHint;

        private var _appearMinimapHint:BCAppearMinimapHint = null;

        public function BCBattlePage()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            this.battleTopHint.updateStage(param1,param2);
            this.secondaryHint.y = ribbonsPanel.y - SEC_HINT_OFFSET_Y;
            this.secondaryHint.x = ribbonsPanel.x;
        }

        override protected function getRibbonsCenterOffset() : int
        {
            return RIBBONS_CENTER_SCREEN_OFFSET_Y;
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponentS(this.secondaryHint,BATTLE_VIEW_ALIASES.BOOTCAMP_SECONDARY_HINT);
            registerFlashComponentS(this.battleTopHint,BATTLE_VIEW_ALIASES.BOOTCAMP_BATTLE_TOP_HINT);
        }

        override protected function configUI() : void
        {
            super.configUI();
            stage.addEventListener(AppearEvent.PREPARE,this.onStageAppearHintCreatedHandler);
        }

        override protected function onDispose() : void
        {
            this.secondaryHint = null;
            this.battleTopHint = null;
            var _loc1_:Stage = App.stage;
            _loc1_.removeEventListener(AppearEvent.PREPARE,this.onStageAppearHintCreatedHandler);
            super.onDispose();
        }

        override protected function get isQuestProgress() : Boolean
        {
            return false;
        }

        private function setMinimapHintsVisible() : void
        {
            if(this._appearMinimapHint)
            {
                this._appearMinimapHint.visible = minimap.visible;
            }
        }

        private function onStageAppearHintCreatedHandler(param1:AppearEvent) : void
        {
            this._appearMinimapHint = BCAppearMinimapHint(param1.target);
            this.setMinimapHintsVisible();
        }

        override protected function onMiniMapChangeHandler(param1:MinimapEvent) : void
        {
            super.onMiniMapChangeHandler(param1);
            this.setMinimapHintsVisible();
        }
    }
}
