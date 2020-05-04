package net.wg.gui.battle.pveEvent.views.radialMenu
{
    import net.wg.gui.battle.views.radialMenu.RadialButton;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.gui.battle.pveEvent.views.radialMenu.components.EventContent;
    import net.wg.gui.battle.pveEvent.views.radialMenu.components.IconRotationContainer;
    import net.wg.gui.battle.pveEvent.views.radialMenu.components.EventSectorHoveredWrapper;
    import net.wg.data.constants.InteractiveStates;
    import net.wg.data.constants.generated.BATTLEATLAS;

    public class EventRadialButton extends RadialButton
    {

        public var bg:BattleAtlasSprite = null;

        public var eventContent:EventContent = null;

        public var iconsUp:IconRotationContainer = null;

        public var iconsHover:IconRotationContainer = null;

        private var _disabledButton:Boolean;

        public function EventRadialButton()
        {
            super();
            this.bg.imageName = BATTLEATLAS.RADIAL_SINGLE_BG;
        }

        public function setRadialState(param1:String) : void
        {
            this.eventContent.setRadialState(param1);
            var _loc2_:EventSectorHoveredWrapper = sectorWrapperHovered as EventSectorHoveredWrapper;
            _loc2_.setRadialState(param1);
            invalidate(RadialButton.TITLE_VALIDATION);
        }

        public function setDisabledButton(param1:Boolean) : void
        {
            this._disabledButton = param1;
            if(param1)
            {
                state = InteractiveStates.DISABLED;
                selected = false;
            }
        }

        public function setChatState(param1:Boolean) : void
        {
            this.eventContent.setChatState(param1);
            invalidate(RadialButton.TITLE_VALIDATION);
        }

        override protected function initComponents() : void
        {
            keyTF = this.eventContent.commandContainer.keyTF;
        }

        override protected function showIcon(param1:String) : void
        {
            if(param1 != null)
            {
                this.iconsUp.showIcon(param1);
                this.iconsHover.showIcon(param1);
            }
            else
            {
                this.iconsUp.hideAll();
                this.iconsHover.hideAll();
            }
        }

        override protected function drawAngle() : void
        {
            if(isInvalid(RadialButton.ANGLE_VALIDATION))
            {
                this.rotation = angle;
                this.eventContent.setRotation(-angle);
                this.iconsUp.setRotation(-angle);
                this.iconsHover.setRotation(-angle);
            }
        }

        override protected function drawText() : void
        {
            if(isInvalid(RadialButton.TITLE_VALIDATION))
            {
                this.eventContent.setTitle(titleStr);
            }
            if(isInvalid(RadialButton.KEY_VALIDATION))
            {
                this.eventContent.setKey(keyStr);
            }
        }

        override protected function onDispose() : void
        {
            this.bg = null;
            this.eventContent.dispose();
            this.eventContent = null;
            this.iconsUp.dispose();
            this.iconsUp = null;
            this.iconsHover.dispose();
            this.iconsHover = null;
            super.onDispose();
        }

        public function get disabledButton() : Boolean
        {
            return this._disabledButton;
        }
    }
}
