package net.wg.gui.lobby.training 
{
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class ArenaVoipSettings extends scaleform.clik.core.UIComponent
    {
        public function ArenaVoipSettings()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.voiceChatDD.dataProvider = new scaleform.clik.data.DataProvider([MENU.TRAINING_INFO_USECOMMONVOICECHAT, MENU.TRAINING_INFO_USESEPARATEVOIPCHAT]);
            this.voiceChatDD.selectedIndex = 0;
            this.voiceChatDD.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleChange, false, 0, true);
            return;
        }

        public override function dispose():void
        {
            App.utils.scheduler.cancelTask(this.stopCoolDownUseCommonVoiceChat);
            this.voiceChatDD.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleChange, false);
            this.voiceChatDD.dispose();
            this.voiceChatDD = null;
            this.textField.dispose();
            this.textField = null;
            super.dispose();
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (arg1 == super.enabled) 
                return;
            super.enabled = arg1;
            this.voiceChatDD.enabled = arg1;
            this.textField.enabled = arg1;
            return;
        }

        public function setCanChangeArenaVOIP(arg1:Boolean):void
        {
            if (this.canChangeArenaVOIP == arg1) 
                return;
            this.canChangeArenaVOIP = arg1;
            invalidate(ArenaVoipSettings.CHANGE_ARENA_VOIP);
            return;
        }

        public function setUseArenaVoip(arg1:Number):void
        {
            this.useArenaVoip = arg1;
            invalidate(ArenaVoipSettings.USE_ARENA_VOIP);
            return;
        }

        internal function handleChange(arg1:scaleform.clik.events.ListEvent):void
        {
            if (this.canChangeArenaVOIP) 
                dispatchEvent(new net.wg.gui.events.ArenaVoipSettingsEvent(net.wg.gui.events.ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT, this.voiceChatDD.selectedIndex));
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(ArenaVoipSettings.CHANGE_ARENA_VOIP)) 
            {
                this.voiceChatDD.visible = this.canChangeArenaVOIP;
                this.textField.visible = !this.canChangeArenaVOIP;
            }
            if (isInvalid(ArenaVoipSettings.USE_ARENA_VOIP)) 
                if (this.canChangeArenaVOIP) 
                    this.voiceChatDD.selectedIndex = this.useArenaVoip;
                else 
                {
                    if (this.useArenaVoip != -1) 
                        if (this.useArenaVoip != 0) 
                            this.textField.label = MENU.TRAINING_INFO_USESEPARATEVOIPCHAT;
                        else 
                            this.textField.label = MENU.TRAINING_INFO_USECOMMONVOICECHAT;
                    else 
                        this.textField.label = MENU.TRAINING_INFO_NOTUSECHAT;
                    this.textField.validateNow();
                }
            return;
        }

        public function startCoolDownUseCommonVoiceChat(arg1:Number):void
        {
            this.voiceChatDD.enabled = false;
            var loc1:*=App.utils.scheduler;
            loc1.cancelTask(this.stopCoolDownUseCommonVoiceChat);
            loc1.scheduleTask(this.stopCoolDownUseCommonVoiceChat, arg1 * 1000);
            return;
        }

        internal function stopCoolDownUseCommonVoiceChat():void
        {
            this.voiceChatDD.enabled = true;
            return;
        }

        public function changeUseArenaVoipFailed(arg1:Number):void
        {
            App.utils.scheduler.cancelTask(this.stopCoolDownUseCommonVoiceChat);
            if (this.canChangeArenaVOIP) 
            {
                this.voiceChatDD.enabled = true;
                this.voiceChatDD.selectedIndex = arg1;
            }
            return;
        }

        internal static const CHANGE_ARENA_VOIP:String="changeArenaVOIP";

        internal static const USE_ARENA_VOIP:String="useArenaVOIP";

        internal var canChangeArenaVOIP:Boolean=false;

        internal var useArenaVoip:Number=0;

        public var voiceChatDD:net.wg.gui.components.controls.DropdownMenu;

        public var textField:net.wg.gui.components.controls.TextFieldShort;
    }
}
