package net.wg.gui.battle.battleRoyale
{
    import net.wg.infrastructure.base.meta.impl.RadarButtonMeta;
    import net.wg.infrastructure.base.meta.IRadarButtonMeta;
    import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
    import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleConsumableButton;
    import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;

    public class RadarButton extends RadarButtonMeta implements IRadarButtonMeta, IClickButtonHandler
    {

        public var radarButton:BattleRoyaleConsumableButton = null;

        public function RadarButton()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.radarButton.addClickCallBack(this);
        }

        override protected function onDispose() : void
        {
            this.radarButton.dispose();
            this.radarButton = null;
            super.onDispose();
        }

        public function as_init(param1:Number, param2:Number, param3:String, param4:String, param5:Boolean) : void
        {
            var _loc6_:ConsumablesVO = this.radarButton.consumablesVO;
            _loc6_.keyCode = param1;
            this.radarButton.isReplay = param5;
            this.radarButton.icon = param3;
            this.radarButton.tooltipStr = param4;
            this.radarButton.key = param2;
        }

        public function as_setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int) : void
        {
            this.radarButton.setCoolDownTime(param1,param2,param3,param4);
        }

        public function as_updateEnable(param1:Boolean) : void
        {
            this.radarButton.enabled = param1;
        }

        public function onButtonClick(param1:Object) : void
        {
            onClickS();
        }
    }
}
