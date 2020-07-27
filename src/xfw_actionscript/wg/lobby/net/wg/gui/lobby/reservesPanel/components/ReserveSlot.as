package net.wg.gui.lobby.reservesPanel.components
{
    import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;
    import flash.display.MovieClip;
    import net.wg.gui.components.advanced.ReserveTypesUIWithFill;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;

    public class ReserveSlot extends DeviceSlot
    {

        private static const COUNT_FRAMES_WITHOUT_LEVEL:int = 3;

        public var levelMC:MovieClip = null;

        public var icon:ReserveTypesUIWithFill = null;

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
            this.icon.dispose();
            this.icon = null;
            this.levelMC = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA) && slotData)
            {
                _loc1_ = slotData.slotType + (slotData.level > ReserveTypesUIWithFill.LEVELS_WITHOUT_GLOW?ReserveTypesUIWithFill.GLOW_ENDING:Values.EMPTY_STR);
                this.icon.setModuleTypeIcon(_loc1_);
                this.levelMC.gotoAndStop(slotData.level);
                this.levelMC.visible = this.icon.currentFrame > COUNT_FRAMES_WITHOUT_LEVEL;
            }
        }
    }
}
