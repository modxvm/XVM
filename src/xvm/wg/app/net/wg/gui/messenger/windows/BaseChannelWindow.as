package net.wg.gui.messenger.windows
{
   import net.wg.gui.messenger.meta.impl.BaseChannelWindowMeta;
   import net.wg.gui.messenger.meta.IBaseChannelWindowMeta;
   import net.wg.gui.messenger.ChannelComponent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import net.wg.data.Aliases;
   import scaleform.clik.utils.Padding;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.events.MessengerBarEvent;


   public class BaseChannelWindow extends BaseChannelWindowMeta implements IBaseChannelWindowMeta
   {
          
      public function BaseChannelWindow() {
         super();
         showWindowBg = false;
         canMinimize = true;
         canResize = true;
         canDrag = true;
         isCentered = false;
      }

      public var channelComponent:ChannelComponent;

      override public function handleInput(param1:InputEvent) : void {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.F1 && _loc2_.value == InputValue.KEY_UP)
         {
            param1.handled = true;
            showFAQWindowS();
         }
         if(canCloseFromInputDetails(_loc2_))
         {
            param1.handled = true;
            onWindowMinimizeS();
         }
         super.handleInput(param1);
      }

      override public function setFocus() : void {
         super.setFocus();
         if(this.channelComponent)
         {
            this.channelComponent.setFocusToInput();
         }
      }

      public function as_setTitle(param1:String) : void {
         window.title = param1;
      }

      public function as_setCloseEnabled(param1:Boolean) : void {
         enabledCloseBtn = param1;
      }

      override protected function configUI() : void {
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("messageArea",this.channelComponent.messageArea,Constraints.ALL);
         constraints.addElement("messageInput",this.channelComponent.messageInput,Constraints.LEFT | Constraints.RIGHT | Constraints.BOTTOM);
         constraints.addElement("sendButton",this.channelComponent.sendButton,Constraints.RIGHT | Constraints.BOTTOM);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         registerComponent(this.channelComponent,Aliases.CHANNEL_COMPONENT);
         window.contentPadding = new Padding(40,11,15,11);
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
      }

      override protected function draw() : void {
         super.draw();
      }
   }

}