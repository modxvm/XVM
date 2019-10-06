package net.wg.gui.lobby.epicBattles.components
{
    import net.wg.infrastructure.base.meta.impl.EpicBattlesWidgetMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesWidgetMeta;
    import net.wg.gui.lobby.hangar.alertMessage.AlertMessageBlock;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;

    public class EpicBattlesWidget extends EpicBattlesWidgetMeta implements IEpicBattlesWidgetMeta
    {

        private static const BUTTON_NORMAL_Y_OFFSET:int = -15;

        private static const BG_NORMAL_Y_OFFSET:int = 0;

        private static const ALERT_BUTTON_NORMAL_Y_OFFSET:int = 25;

        private static const ALERT_BG_Y_OFFSET:int = 40;

        public var calendarStatus:AlertMessageBlock = null;

        public var button:EpicBattlesWidgetButton = null;

        public var bg:MovieClip = null;

        private var _data:EpicBattlesWidgetVO = null;

        public function EpicBattlesWidget()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.button.addEventListener(ButtonEvent.CLICK,this.onClickHandler);
            this.calendarStatus.x = -this.calendarStatus.width >> 1;
            this.mouseEnabled = false;
            this.bg.mouseEnabled = this.bg.mouseChildren = false;
        }

        override protected function onDispose() : void
        {
            this.button.removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
            this.calendarStatus.dispose();
            this.calendarStatus = null;
            this.bg = null;
            this.button.dispose();
            this.button = null;
            if(this._data)
            {
                this._data.dispose();
                this._data = null;
            }
            super.onDispose();
        }

        override protected function setData(param1:EpicBattlesWidgetVO) : void
        {
            this._data = param1;
            this.button.setEpicData(param1);
            invalidateData();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA) && this._data != null)
            {
                this.calendarStatus.visible = this._data.showAlert;
                this.calendarStatus.setLocalData(this._data.calendarStatus);
                this.calendarStatus.btnClickHandler = onChangeServerClickS;
                if(this._data.showAlert)
                {
                    this.button.y = ALERT_BUTTON_NORMAL_Y_OFFSET;
                    this.bg.y = ALERT_BG_Y_OFFSET;
                }
                else
                {
                    this.button.y = BUTTON_NORMAL_Y_OFFSET;
                    this.bg.y = BG_NORMAL_Y_OFFSET;
                }
            }
        }

        private function onClickHandler(param1:ButtonEvent) : void
        {
            onWidgetClickS();
        }
    }
}
