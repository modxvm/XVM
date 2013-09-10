package net.wg.gui.messenger.windows 
{
    import flash.ui.*;
    import net.wg.data.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.messenger.*;
    import net.wg.gui.messenger.meta.*;
    import net.wg.gui.messenger.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    
    public class BaseChannelWindow extends net.wg.gui.messenger.meta.impl.BaseChannelWindowMeta implements net.wg.gui.messenger.meta.IBaseChannelWindowMeta
    {
        public function BaseChannelWindow()
        {
            super();
            showWindowBg = false;
            canMinimize = true;
            canResize = true;
            canDrag = true;
            isCentered = false;
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=arg1.details;
            if (loc1.code == flash.ui.Keyboard.F1 && loc1.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                arg1.handled = true;
                showFAQWindowS();
            }
            if (loc1.code == flash.ui.Keyboard.ESCAPE && loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
            {
                arg1.handled = true;
                onWindowMinimizeS();
            }
            super.handleInput(arg1);
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            if (this.channelComponent) 
            {
                this.channelComponent.setFocusToInput();
            }
            return;
        }

        public function as_setTitle(arg1:String):void
        {
            window.title = arg1;
            return;
        }

        public function as_setCloseEnabled(arg1:Boolean):void
        {
            enabledCloseBtn = arg1;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("messageArea", this.channelComponent.messageArea, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("messageInput", this.channelComponent.messageInput, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.BOTTOM);
            constraints.addElement("sendButton", this.channelComponent.sendButton, scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.BOTTOM);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerComponent(this.channelComponent, net.wg.data.Aliases.CHANNEL_COMPONENT);
            window.contentPadding = new scaleform.clik.utils.Padding(40, 11, 15, 11);
            geometry = new net.wg.gui.lobby.messengerBar.WindowGeometryInBar(net.wg.gui.events.MessengerBarEvent.PIN_CAROUSEL_WINDOW, getClientIDS());
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public var channelComponent:net.wg.gui.messenger.ChannelComponent;
    }
}
