package net.wg.gui.lobby.training 
{
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.data.components.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.prebattle.squad.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.utils.*;
    
    public class TrainingPlayerItemRenderer extends scaleform.clik.controls.ListItemRenderer implements net.wg.infrastructure.interfaces.entity.IDropItem
    {
        public function TrainingPlayerItemRenderer()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (!constraintsDisabled) 
                constraints.addElement(this.vehicleField.name, this.vehicleField, scaleform.clik.utils.Constraints.RIGHT);
            this.defColorTrans = this.iconLoader.transform.colorTransform;
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            selectable = false;
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, hideToolTip, false, 0, true);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, hideToolTip, false, 0, true);
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showToolTip, false, 0, true);
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, hideToolTip, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, hideToolTip, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showToolTip, false);
            if (this.nameField) 
            {
                this.nameField.dispose();
                this.nameField = null;
            }
            this.vehicleField = null;
            this.vehicleLevelField = null;
            this.stateField = null;
            this.defColorTrans = null;
            if (this.iconLoader) 
            {
                this.iconLoader.dispose();
                this.iconLoader = null;
            }
            if (this.voiceWave) 
            {
                this.voiceWave.dispose();
                this.voiceWave = null;
            }
            if (_data && _data is net.wg.infrastructure.interfaces.entity.IDisposable) 
                net.wg.infrastructure.interfaces.entity.IDisposable(_data).dispose();
            _data = null;
            super.dispose();
            return;
        }

        internal function showToolTip(arg1:flash.events.MouseEvent):void
        {
            if (data) 
                App.toolTipMgr.show(net.wg.data.VO.TrainingRoomRendererVO(data).fullName);
            return;
        }

        public function speak(arg1:Boolean, arg2:Boolean):void
        {
            if (arg1) 
                arg2 = false;
            if (this.voiceWave) 
                this.voiceWave.setSpeaking(arg1, arg2);
            return;
        }

        public override function set selected(arg1:Boolean):void
        {
            if (_selectable) 
                super.selected = arg1;
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            if (App.utils.commons.isRightButton(arg1) && data) 
            {
                App.toolTipMgr.hide();
                App.contextMenuMgr.showUserContextMenu(this, data, new net.wg.data.components.BattleResultsCIGenerator(false));
            }
            super.handleMouseRelease(arg1);
            return;
        }

        public override function setData(arg1:Object):void
        {
            var loc1:*=null;
            this.data = arg1;
            if (arg1) 
            {
                loc1 = net.wg.data.VO.TrainingRoomRendererVO(arg1);
                this.iconLoader.visible = !(loc1.icon == "");
                if (!(this.iconLoader.source == loc1.icon) && loc1.icon) 
                    this.iconLoader.source = loc1.icon;
            }
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=null;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                if (data) 
                {
                    loc1 = net.wg.data.VO.TrainingRoomRendererVO(data);
                    this.vehicleField.text = loc1.vShortName;
                    this.stateField.text = loc1.stateString;
                    this.vehicleLevelField.text = String(loc1.vLevel);
                    enabled = true;
                    if (loc1.himself) 
                    {
                        this.nameField.textColor = GOLD_COLOR;
                        this.vehicleField.textColor = GOLD_COLOR;
                        loc2 = new flash.geom.ColorTransform();
                        loc2.redOffset = 21;
                        loc2.greenOffset = 9;
                        loc2.blueMultiplier = 0.51;
                        loc2.greenMultiplier = 0.87;
                        this.iconLoader.transform.colorTransform = loc2;
                    }
                    else 
                    {
                        this.nameField.textColor = NAME_COLOR;
                        this.vehicleField.textColor = VEHICLE_COLOR;
                        this.iconLoader.transform.colorTransform = this.defColorTrans;
                    }
                    this.speak(loc1.isPlayerSpeaking, true);
                    if (this.voiceWave) 
                        this.voiceWave.setMuted(net.wg.gui.prebattle.squad.MessengerUtils.isMuted(data));
                    this.nameField.label = loc1.fullName;
                }
                else 
                {
                    if (this.nameField) 
                        this.nameField.label = "";
                    if (this.vehicleField) 
                        this.vehicleField.text = "";
                    if (this.vehicleLevelField) 
                        this.vehicleLevelField.text = "";
                    if (this.stateField) 
                        this.stateField.text = "";
                    if (this.iconLoader) 
                        this.iconLoader.visible = false;
                    enabled = false;
                    this.speak(false, true);
                    if (this.voiceWave) 
                        this.voiceWave.setMuted(false);
                }
            return;
        }

        public override function setListData(arg1:scaleform.clik.data.ListData):void
        {
            index = arg1.index;
            this.selected = arg1.selected;
            return;
        }

        internal static function hideToolTip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal static const GOLD_COLOR:Number=16761699;

        internal static const NAME_COLOR:Number=13224374;

        internal static const VEHICLE_COLOR:Number=8092009;

        public var nameField:net.wg.gui.components.controls.TextFieldShort;

        public var vehicleField:flash.text.TextField;

        public var vehicleLevelField:flash.text.TextField;

        public var stateField:flash.text.TextField;

        internal var defColorTrans:flash.geom.ColorTransform;

        public var iconLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var voiceWave:net.wg.gui.components.controls.VoiceWave;
    }
}
