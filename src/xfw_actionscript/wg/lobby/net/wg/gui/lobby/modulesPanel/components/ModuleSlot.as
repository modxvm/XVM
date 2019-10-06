package net.wg.gui.lobby.modulesPanel.components
{
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;

    public class ModuleSlot extends DeviceSlot
    {

        public var levelMC:MovieClip = null;

        public var disabledBg:MovieClip = null;

        public var icon:MovieClip = null;

        public function ModuleSlot()
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
            this.disabledBg = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(slotData && isInvalid(InvalidationType.DATA))
            {
                this.levelMC.gotoAndStop(slotData.level);
                this.icon.gotoAndStop(slotData.slotType);
                invalidateState();
            }
            if(this.disabledBg && isInvalid(InvalidationType.STATE))
            {
                this.disabledBg.visible = slotData && slotData.isDisabledBgVisible;
            }
        }
    }
}
