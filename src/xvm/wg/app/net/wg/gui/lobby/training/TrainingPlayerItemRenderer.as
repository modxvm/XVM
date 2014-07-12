package net.wg.gui.lobby.training
{
    import scaleform.clik.controls.ListItemRenderer;
    import net.wg.infrastructure.interfaces.entity.IDropItem;
    import net.wg.gui.components.controls.UserNameField;
    import flash.text.TextField;
    import flash.geom.ColorTransform;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.VoiceWave;
    import scaleform.clik.utils.Constraints;
    import flash.events.MouseEvent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.VO.TrainingRoomRendererVO;
    import net.wg.data.components.BattleResultsCIGenerator;
    import scaleform.clik.constants.InvalidationType;
    import flash.geom.Point;
    import net.wg.gui.prebattle.squad.MessengerUtils;
    import scaleform.clik.data.ListData;
    
    public class TrainingPlayerItemRenderer extends ListItemRenderer implements IDropItem
    {
        
        public function TrainingPlayerItemRenderer() {
            super();
        }
        
        private static var GOLD_COLOR:Number = 16761699;
        
        private static var NAME_COLOR:Number = 13224374;
        
        private static var VEHICLE_COLOR:Number = 8092009;
        
        public var nameField:UserNameField;
        
        public var vehicleField:TextField;
        
        public var vehicleLevelField:TextField;
        
        public var stateField:TextField;
        
        private var defColorTrans:ColorTransform;
        
        public var iconLoader:UILoaderAlt;
        
        public var voiceWave:VoiceWave;
        
        private var _isMouseOver:Boolean = false;
        
        override protected function configUI() : void {
            super.configUI();
            if(!constraintsDisabled)
            {
                constraints.addElement(this.vehicleField.name,this.vehicleField,Constraints.RIGHT);
            }
            this.defColorTrans = this.iconLoader.transform.colorTransform;
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            selectable = false;
            addEventListener(MouseEvent.MOUSE_DOWN,this.hideToolTip,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.hideToolTip,false,0,true);
            addEventListener(MouseEvent.ROLL_OVER,this.showToolTip,false,0,true);
        }
        
        override protected function onDispose() : void {
            removeEventListener(MouseEvent.MOUSE_DOWN,this.hideToolTip,false);
            removeEventListener(MouseEvent.ROLL_OUT,this.hideToolTip,false);
            removeEventListener(MouseEvent.ROLL_OVER,this.showToolTip,false);
            if(this.nameField)
            {
                this.nameField.dispose();
                this.nameField = null;
            }
            this.vehicleField = null;
            this.vehicleLevelField = null;
            this.stateField = null;
            this.defColorTrans = null;
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
            if((_data) && _data is IDisposable)
            {
                IDisposable(_data).dispose();
            }
            _data = null;
            super.onDispose();
        }
        
        private function showToolTip(param1:MouseEvent) : void {
            this._isMouseOver = true;
            if(data)
            {
                App.toolTipMgr.show(TrainingRoomRendererVO(data).fullName);
            }
        }
        
        private function hideToolTip(param1:MouseEvent) : void {
            if(param1.type == MouseEvent.ROLL_OUT)
            {
                this._isMouseOver = false;
            }
            App.toolTipMgr.hide();
        }
        
        public function speak(param1:Boolean, param2:Boolean) : void {
            if(param1)
            {
                param2 = false;
            }
            if(this.voiceWave)
            {
                this.voiceWave.setSpeaking(param1,param2);
            }
        }
        
        override public function set selected(param1:Boolean) : void {
            if(_selectable)
            {
                super.selected = param1;
            }
        }
        
        override protected function handleMouseRelease(param1:MouseEvent) : void {
            if((App.utils.commons.isRightButton(param1)) && (data))
            {
                App.toolTipMgr.hide();
                App.contextMenuMgr.showUserContextMenu(this,data,new BattleResultsCIGenerator(false));
            }
            super.handleMouseRelease(param1);
        }
        
        override public function setData(param1:Object) : void {
            var _loc2_:TrainingRoomRendererVO = null;
            this.data = param1;
            if(param1)
            {
                _loc2_ = TrainingRoomRendererVO(param1);
                this.iconLoader.visible = !(_loc2_.icon == "");
                if(!(this.iconLoader.source == _loc2_.icon) && (_loc2_.icon))
                {
                    this.iconLoader.source = _loc2_.icon;
                }
            }
            invalidate(InvalidationType.DATA);
        }
        
        override protected function draw() : void {
            var _loc1_:TrainingRoomRendererVO = null;
            var _loc2_:Point = null;
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
                    this.vehicleField.text = _loc1_.vShortName;
                    this.stateField.text = _loc1_.stateString;
                    this.vehicleLevelField.text = String(_loc1_.vLevel);
                    enabled = true;
                    if(_loc1_.himself)
                    {
                        this.nameField.textColor = GOLD_COLOR;
                        this.vehicleField.textColor = GOLD_COLOR;
                        this.iconLoader.transform.colorTransform = App.colorSchemeMgr.getTransform(TrainingConstants.VEHICLE_YELLOW_COLOR_SCHEME_ALIAS);
                    }
                    else
                    {
                        this.nameField.textColor = NAME_COLOR;
                        this.vehicleField.textColor = VEHICLE_COLOR;
                        this.iconLoader.transform.colorTransform = this.defColorTrans;
                    }
                    this.speak(_loc1_.isPlayerSpeaking,true);
                    if(this.voiceWave)
                    {
                        this.voiceWave.setMuted(MessengerUtils.isMuted(data));
                    }
                    this.nameField.userVO = _loc1_;
                    _loc2_ = new Point(mouseX,mouseY);
                    _loc2_ = this.localToGlobal(_loc2_);
                    if((this.hitTestPoint(_loc2_.x,_loc2_.y,true)) && (this._isMouseOver))
                    {
                        App.toolTipMgr.show(TrainingRoomRendererVO(data).fullName);
                    }
                }
                else
                {
                    if(this.nameField)
                    {
                        this.nameField.userVO = null;
                    }
                    if(this.vehicleField)
                    {
                        this.vehicleField.text = "";
                    }
                    if(this.vehicleLevelField)
                    {
                        this.vehicleLevelField.text = "";
                    }
                    if(this.stateField)
                    {
                        this.stateField.text = "";
                    }
                    if(this.iconLoader)
                    {
                        this.iconLoader.visible = false;
                    }
                    enabled = false;
                    this.speak(false,true);
                    if(this.voiceWave)
                    {
                        this.voiceWave.setMuted(false);
                    }
                }
            }
        }
        
        override public function setListData(param1:ListData) : void {
            index = param1.index;
            this.selected = param1.selected;
        }
    }
}
