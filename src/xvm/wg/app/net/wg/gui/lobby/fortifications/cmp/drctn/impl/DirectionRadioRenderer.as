package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.RadioButton;
    import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    
    public class DirectionRadioRenderer extends UIComponent
    {
        
        public function DirectionRadioRenderer()
        {
            super();
        }
        
        private static var INVALID_SELECTED:String = "invalidSelected";
        
        private static var DIRECTION_ENABLED_ALPHA:Number = 1;
        
        private static var DIRECTION_DISABLED_ALPHA:Number = 0.37;
        
        public var directionsCmp:ConnectedDirctns;
        
        public var radioButton:RadioButton;
        
        private var _selected:Boolean = false;
        
        private var _model:ConnectedDirectionsVO;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.directionsCmp.leftDirection.addEventListener(MouseEvent.CLICK,this.clickHandler);
            this.radioButton.addEventListener(MouseEvent.CLICK,this.clickHandler);
            this.radioButton.addEventListener(MouseEvent.ROLL_OVER,this.overHandler);
            this.radioButton.addEventListener(MouseEvent.ROLL_OUT,this.outHandler);
            this.directionsCmp.leftDirection.useDirectionBuildingTooltips = false;
            this.directionsCmp.leftDirection.disableLowLevelBuildings = true;
            this.directionsCmp.leftDirection.solidMode = true;
            this.directionsCmp.leftDirection.labelVisible = true;
            this.directionsCmp.rightDirection.useDirectionBuildingTooltips = false;
            this.directionsCmp.rightDirection.disableLowLevelBuildings = true;
            this.directionsCmp.rightDirection.alwaysShowLevels = true;
            this.directionsCmp.rightDirection.solidMode = true;
            this.directionsCmp.rightDirection.mouseArea.buttonMode = false;
            this.directionsCmp.rightDirection.labelVisible = false;
            this.directionsCmp.showHideConnectedDirection(this._selected);
        }
        
        override protected function onDispose() : void
        {
            this.directionsCmp.leftDirection.removeEventListener(MouseEvent.CLICK,this.clickHandler);
            this.radioButton.removeEventListener(MouseEvent.CLICK,this.clickHandler);
            this.radioButton.removeEventListener(MouseEvent.ROLL_OVER,this.overHandler);
            this.radioButton.removeEventListener(MouseEvent.ROLL_OUT,this.outHandler);
            this.directionsCmp.dispose();
            this.directionsCmp = null;
            this.radioButton.dispose();
            this.radioButton = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._model)
                {
                    this.directionsCmp.setData(this._model);
                    this.directionsCmp.visible = true;
                    if(this._model.leftDirection.canAttackFrom)
                    {
                        this.radioButton.visible = true;
                        this.directionsCmp.leftDirection.hoverAnimation = DirectionCmp.ANIMATION_HIGHLIGHT;
                        this.directionsCmp.leftDirection.mouseArea.buttonMode = true;
                    }
                    else
                    {
                        this.radioButton.visible = false;
                        this.directionsCmp.leftDirection.mouseArea.buttonMode = false;
                        this.directionsCmp.leftDirection.hoverAnimation = null;
                    }
                    if(this._model.leftDirection.isBusy)
                    {
                        this.directionsCmp.alpha = DIRECTION_DISABLED_ALPHA;
                        App.utils.commons.setSaturation(this.directionsCmp,0);
                    }
                    else
                    {
                        this.directionsCmp.alpha = DIRECTION_ENABLED_ALPHA;
                        this.directionsCmp.filters = [];
                    }
                }
                else
                {
                    this.directionsCmp.visible = false;
                    this.radioButton.visible = false;
                }
            }
            if(isInvalid(InvalidationType.DATA,INVALID_SELECTED))
            {
                this.directionsCmp.showHideConnectedDirection(this._selected);
                this.directionsCmp.showHideConnectionAnimation(this._selected);
                this.updateLevelsShowing();
            }
        }
        
        public function setData(param1:ConnectedDirectionsVO) : void
        {
            this._model = param1;
            invalidateData();
        }
        
        public function get model() : ConnectedDirectionsVO
        {
            return this._model;
        }
        
        public function get selected() : Boolean
        {
            return this._selected;
        }
        
        public function set selected(param1:Boolean) : void
        {
            if(this._selected == param1)
            {
                return;
            }
            this._selected = param1;
            this.radioButton.selected = param1;
            invalidate(INVALID_SELECTED);
        }
        
        private function updateLevelsShowing() : void
        {
            if((this._model) && (this._model.leftDirection.canAttackFrom))
            {
                this.directionsCmp.leftDirection.alwaysShowLevels = this._selected;
                this.directionsCmp.leftDirection.showLevelsOnHover = !this._selected;
            }
            else
            {
                this.directionsCmp.leftDirection.alwaysShowLevels = false;
                this.directionsCmp.leftDirection.showLevelsOnHover = (this._model) && !this._model.leftDirection.isBusy;
            }
        }
        
        private function outHandler(param1:MouseEvent) : void
        {
            this.directionsCmp.leftDirection.showHideHowerState(false,true);
        }
        
        private function overHandler(param1:MouseEvent) : void
        {
            this.directionsCmp.leftDirection.showHideHowerState(true,true);
        }
        
        private function clickHandler(param1:MouseEvent) : void
        {
            if(param1 is MouseEvent && !App.utils.commons.isLeftButton(param1 as MouseEvent))
            {
                return;
            }
            if((this._model) && (this._model.leftDirection.canAttackFrom))
            {
                dispatchEvent(new Event(Event.SELECT));
            }
        }
    }
}
