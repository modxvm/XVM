package net.wg.gui.lobby.training
{
    import scaleform.clik.controls.ListItemRenderer;
    import net.wg.infrastructure.interfaces.entity.IDropItem;
    import net.wg.gui.components.controls.UserNameField;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.VoiceWave;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.data.ListData;
    import flash.events.MouseEvent;
    import net.wg.data.VO.TrainingRoomRendererVO;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.UserTags;
    import flash.geom.Point;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.Cursors;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;

    public class TrainingPlayerItemRendererBase extends ListItemRenderer implements IDropItem
    {

        private static const GOLD_COLOR:Number = 16761699;

        private static const NAME_COLOR:Number = 13224374;

        private static const VEHICLE_COLOR:Number = 8092009;

        private static const BADGE_OFFSET:int = -3;

        public var nameField:UserNameField;

        public var vehicleField:TextField;

        public var vehicleLevelField:TextField;

        public var iconLoader:UILoaderAlt;

        public var voiceWave:VoiceWave;

        public var dragHit:Sprite = null;

        private var _defColorTrans:ColorTransform;

        private var _isMouseOver:Boolean = false;

        private var _tooltipMgr:ITooltipMgr;

        private var _namePosY:int = -1;

        private var _namePosWithBadgeY:int = -1;

        public function TrainingPlayerItemRendererBase()
        {
            super();
            this._tooltipMgr = App.toolTipMgr;
            this._namePosY = this.nameField.y;
            this._namePosWithBadgeY = this._namePosY + BADGE_OFFSET;
            constraintsDisabled = true;
            preventAutosizing = true;
        }

        override public function setListData(param1:ListData) : void
        {
            index = param1.index;
            this.selected = param1.selected;
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseChildren = true;
            this._defColorTrans = this.iconLoader.transform.colorTransform;
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            selectable = false;
            hitArea = this.dragHit;
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
        }

        override protected function onDispose() : void
        {
            hitArea = null;
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler,false);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false);
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false);
            this._tooltipMgr = null;
            this.vehicleField = null;
            this.vehicleLevelField = null;
            this._defColorTrans = null;
            this.dragHit = null;
            if(this.nameField)
            {
                this.nameField.dispose();
                this.nameField = null;
            }
            if(this.iconLoader)
            {
                this.iconLoader.dispose();
                this.iconLoader = null;
            }
            if(this.voiceWave)
            {
                this.voiceWave.dispose();
                this.voiceWave = null;
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:TrainingRoomRendererVO = null;
            super.draw();
            if(_baseDisposed)
            {
                return;
            }
            if(isInvalid(InvalidationType.DATA))
            {
                if(data)
                {
                    _loc1_ = TrainingRoomRendererVO(data);
                    this.doUpdateData(_loc1_);
                }
                else
                {
                    this.resetData();
                }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                if(!preventAutosizing)
                {
                    alignForAutoSize();
                    setActualSize(_width,_height);
                }
                if(!constraintsDisabled)
                {
                    if(constraints)
                    {
                        constraints.update(_width,_height);
                    }
                }
            }
        }

        public function speak(param1:Boolean, param2:Boolean) : void
        {
            if(param1)
            {
                var param2:* = false;
            }
            if(this.voiceWave)
            {
                this.voiceWave.setSpeaking(param1,param2);
            }
        }

        protected function doUpdateData(param1:TrainingRoomRendererVO) : void
        {
            var _loc2_:String = param1.icon;
            var _loc3_:Boolean = StringUtils.isNotEmpty(_loc2_);
            this.iconLoader.visible = _loc3_;
            if(this.iconLoader.source != _loc2_ && _loc3_)
            {
                this.iconLoader.source = _loc2_;
            }
            var _loc4_:Array = param1.tags;
            App.utils.commons.truncateTextFieldText(this.vehicleField,param1.vShortName,true,true);
            this.vehicleLevelField.text = String(param1.vLevel);
            this.enabled = true;
            if(UserTags.isCurrentPlayer(_loc4_))
            {
                this.nameField.textColor = GOLD_COLOR;
                this.vehicleField.textColor = GOLD_COLOR;
                this.iconLoader.transform.colorTransform = App.colorSchemeMgr.getTransform(TrainingConstants.VEHICLE_YELLOW_COLOR_SCHEME_ALIAS);
            }
            else
            {
                this.nameField.textColor = NAME_COLOR;
                this.vehicleField.textColor = VEHICLE_COLOR;
                this.iconLoader.transform.colorTransform = this._defColorTrans;
            }
            this.speak(param1.isPlayerSpeaking,true);
            if(this.voiceWave)
            {
                this.voiceWave.setMuted(UserTags.isMuted(_loc4_));
            }
            this.nameField.userVO = param1;
            var _loc5_:Boolean = StringUtils.isNotEmpty(param1.badgeImgStr);
            this.nameField.y = _loc5_?this._namePosWithBadgeY:this._namePosY;
            this.updateHoverState();
        }

        protected function updateHoverState() : Boolean
        {
            var _loc1_:Point = new Point(mouseX,mouseY);
            _loc1_ = localToGlobal(_loc1_);
            if(hitTestPoint(_loc1_.x,_loc1_.y,true) && this._isMouseOver)
            {
                this._tooltipMgr.show(TrainingRoomRendererVO(data).fullName);
                return true;
            }
            return false;
        }

        protected function resetData() : void
        {
            if(this.nameField)
            {
                this.nameField.userVO = null;
            }
            if(this.vehicleField)
            {
                this.vehicleField.text = Values.EMPTY_STR;
            }
            if(this.vehicleLevelField)
            {
                this.vehicleLevelField.text = Values.EMPTY_STR;
            }
            if(this.iconLoader)
            {
                this.iconLoader.visible = false;
            }
            this.enabled = false;
            this.speak(false,true);
            if(this.voiceWave)
            {
                this.voiceWave.setMuted(false);
            }
        }

        private function hideTooltip() : void
        {
            this._tooltipMgr.hide();
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseChildren = true;
        }

        override public function set selected(param1:Boolean) : void
        {
            if(_selectable)
            {
                super.selected = param1;
            }
        }

        public function get getCursorType() : String
        {
            return Cursors.DRAG_OPEN;
        }

        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
            if(App.utils.commons.isRightButton(param1) && data)
            {
                this.hideTooltip();
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.PREBATTLE_USER,this,data);
            }
            super.handleMouseRelease(param1);
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            this._isMouseOver = true;
            if(data)
            {
                this._tooltipMgr.show(TrainingRoomRendererVO(data).fullName);
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this.hideTooltip();
        }

        private function onMouseDownHandler(param1:MouseEvent) : void
        {
            this._isMouseOver = false;
            this.hideTooltip();
        }
    }
}
