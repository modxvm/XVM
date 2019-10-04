package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.components.BattleDisplayable;
    import net.wg.data.constants.Errors;

    public class EpicRespawnViewMeta extends BattleDisplayable
    {

        public var onLaneSelected:Function;

        public var onRespawnBtnClick:Function;

        public var onDeploymentReady:Function;

        public function EpicRespawnViewMeta()
        {
            super();
        }

        public function onLaneSelectedS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.onLaneSelected,"onLaneSelected" + Errors.CANT_NULL);
            this.onLaneSelected(param1);
        }

        public function onRespawnBtnClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onRespawnBtnClick,"onRespawnBtnClick" + Errors.CANT_NULL);
            this.onRespawnBtnClick();
        }

        public function onDeploymentReadyS() : void
        {
            App.utils.asserter.assertNotNull(this.onDeploymentReady,"onDeploymentReady" + Errors.CANT_NULL);
            this.onDeploymentReady();
        }
    }
}
