package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.IconTextButton;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.data.DirectionVO;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Tooltips;
    import flash.events.Event;
    import net.wg.gui.lobby.fortifications.events.FortIntelClanDescriptionEvent;
    
    public class DirectionButtonRenderer extends UIComponent
    {
        
        public function DirectionButtonRenderer()
        {
            super();
        }
        
        private static var INVALID_COMMANDER_MODE:String = "invalidCommanderMode";
        
        private static var ATTACK_BTN_ICON_PNG:String = "smallAttackIcon.png";
        
        public var button:IconTextButton;
        
        public var direction:DirectionCmp;
        
        public var attackDeclaredIcon:AnimatedIcon;
        
        public var clanTF:TextField;
        
        private var _model:DirectionVO;
        
        private var _canAttackMode:Boolean = false;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.direction.showLevelsOnHover = true;
            this.direction.disableLowLevelBuildings = true;
            this.direction.labelVisible = true;
            this.direction.solidMode = true;
            this.direction.layout = DirectionCmp.LAYOUT_RIGHT_LEFT;
            this.button.label = FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_ATTACK;
            this.button.icon = ATTACK_BTN_ICON_PNG;
            this.attackDeclaredIcon.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_OFFENCE;
            this.attackDeclaredIcon.visible = false;
            this.direction.addEventListener(MouseEvent.CLICK,this.clickHandler);
            this.direction.addEventListener(MouseEvent.ROLL_OVER,this.directionOverHandler);
            this.button.addEventListener(ButtonEvent.CLICK,this.clickHandler);
            this.button.addEventListener(MouseEvent.ROLL_OVER,this.onButtonOver);
            this.button.addEventListener(MouseEvent.ROLL_OUT,this.onButtonOut);
            this.clanTF.addEventListener(MouseEvent.ROLL_OVER,this.clanOverHandler);
            this.clanTF.addEventListener(MouseEvent.ROLL_OUT,this.clanOutHandler);
        }
        
        override protected function onDispose() : void
        {
            this.direction.removeEventListener(MouseEvent.CLICK,this.clickHandler);
            this.button.removeEventListener(ButtonEvent.CLICK,this.clickHandler);
            this.button.removeEventListener(MouseEvent.ROLL_OVER,this.onButtonOver);
            this.button.removeEventListener(MouseEvent.ROLL_OUT,this.onButtonOut);
            this.clanTF.removeEventListener(MouseEvent.ROLL_OVER,this.clanOverHandler);
            this.clanTF.removeEventListener(MouseEvent.ROLL_OUT,this.clanOutHandler);
            this.button.dispose();
            this.button = null;
            this.direction.dispose();
            this.direction = null;
            this.attackDeclaredIcon.dispose();
            this.attackDeclaredIcon = null;
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.direction.setData(this._model);
            }
            if(isInvalid(InvalidationType.DATA,INVALID_COMMANDER_MODE))
            {
                this.attackDeclaredIcon.visible = false;
                this.clanTF.visible = false;
                this.button.visible = false;
                if((this._model) && (this._model.canBeAttacked) && (this._canAttackMode))
                {
                    this.button.visible = true;
                    this.direction.hoverAnimation = DirectionCmp.ANIMATION_ATTACK;
                    this.direction.mouseArea.buttonMode = true;
                }
                else
                {
                    this.direction.hoverAnimation = null;
                    this.direction.mouseArea.buttonMode = false;
                    if((this._model) && (this._model.isAttackDeclared()))
                    {
                        this.clanTF.htmlText = this._model.attackerClanName;
                        this.clanTF.visible = true;
                        if(this._model.isAttackDeclaredByMyClan)
                        {
                            this.attackDeclaredIcon.visible = true;
                            this.attackDeclaredIcon.playFadeIn();
                        }
                    }
                }
            }
        }
        
        public function get model() : DirectionVO
        {
            return this._model;
        }
        
        public function set model(param1:DirectionVO) : void
        {
            this._model = param1;
            invalidateData();
        }
        
        public function get canAttackMode() : Boolean
        {
            return this._canAttackMode;
        }
        
        public function set canAttackMode(param1:Boolean) : void
        {
            this._canAttackMode = param1;
            invalidate(INVALID_COMMANDER_MODE);
        }
        
        private function clanOverHandler(param1:MouseEvent) : void
        {
            if((this._model) && (this._model.isAttackDeclared()))
            {
                App.toolTipMgr.showSpecial(Tooltips.CLAN_INFO,null,this._model.attackerClanID);
            }
        }
        
        private function clanOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onButtonOut(param1:MouseEvent) : void
        {
            this.direction.showHideHowerState(false,true);
        }
        
        private function onButtonOver(param1:MouseEvent) : void
        {
            this.direction.showHideHowerState(true,true);
            this.dispatchHoverEventIfNeeded();
        }
        
        private function clickHandler(param1:Event) : void
        {
            var _loc2_:FortIntelClanDescriptionEvent = null;
            if(param1 is MouseEvent && !App.utils.commons.isLeftButton(param1 as MouseEvent))
            {
                return;
            }
            if((this._model) && (this._model.canBeAttacked) && (this._canAttackMode))
            {
                _loc2_ = new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.ATTACK_DIRECTION,this._model.uid);
                dispatchEvent(_loc2_);
            }
        }
        
        private function directionOverHandler(param1:MouseEvent) : void
        {
            this.dispatchHoverEventIfNeeded();
        }
        
        private function dispatchHoverEventIfNeeded() : void
        {
            if((this._model) && (this._model.canBeAttacked) && (this._canAttackMode))
            {
                dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.HOVER_DIRECTION,this._model.uid));
            }
        }
    }
}
