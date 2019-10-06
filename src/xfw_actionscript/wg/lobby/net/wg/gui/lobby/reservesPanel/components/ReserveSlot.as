package net.wg.gui.lobby.reservesPanel.components
{
    import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;

    public class ReserveSlot extends DeviceSlot
    {

        private static const COUNT_FRAMES_WITHOUT_LEVEL:int = 3;

        private static const LEVELS_WITHOUT_GLOW:int = 10;

        private static const GLOW_STRING:String = "Glow";

        public var levelMC:MovieClip = null;

        public var icon:MovieClip = null;

        public function ReserveSlot()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.icon.mouseEnabled = this.icon.mouseChildren = false;
            this.levelMC.mouseEnabled = this.levelMC.mouseChildren = false;
        }

        override protected function onDispose() : void
        {
            this.icon = null;
            this.levelMC = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA) && slotData)
            {
                this.icon.gotoAndStop(slotData.slotType + (slotData.level > LEVELS_WITHOUT_GLOW?GLOW_STRING:Values.EMPTY_STR));
                this.levelMC.gotoAndStop(slotData.level);
                this.levelMC.visible = this.icon.currentFrame > COUNT_FRAMES_WITHOUT_LEVEL;
            }
        }
    }
}
