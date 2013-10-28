package net.wg.gui.prebattle.invites
{
   import net.wg.gui.prebattle.meta.impl.NotificationInvitesWindowMeta;
   import net.wg.gui.prebattle.meta.INotificationInvitesWindowMeta;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import scaleform.clik.utils.Padding;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.events.MessengerBarEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import flash.events.TextEvent;


   public class NotificationInvitesWindow extends NotificationInvitesWindowMeta implements INotificationInvitesWindowMeta
   {
          
      public function NotificationInvitesWindow() {
         super();
      }

      private static const MAX_MIN_WINDOW_SIZE:Object;

      public var messageArea:TextAreaSimple;

      private var _defaultPosition:Object = null;

      public function get defaultPosition() : Object {
         return this._defaultPosition;
      }

      public function set defaultPosition(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         this._defaultPosition =
            {
               "paddingRight":param1.paddingRight,
               "paddingBottom":param1.paddingBottom
            }
         ;
      }

      override protected function preInitialize() : void {
         super.preInitialize();
      }

      public function as_setInvites(param1:Object) : void {
         this.messageArea.htmlText = param1.toString();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         canResize = true;
         canClose = true;
         canDrag = true;
         showWindowBg = false;
         isCentered = false;
         window.title = INVITES.GUI_TITLES_RECEIVEDINVITES;
         var _loc1_:Padding = window.contentPadding as Padding;
         _loc1_.right = 15;
         _loc1_.left = 16;
         _loc1_.top = 40;
         _loc1_.bottom = 20;
         window.contentPadding = _loc1_;
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_RECEIVED_INVITES_WINDOW);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.SIZE)) && (constraints))
         {
            this.updateSizes();
         }
      }

      override protected function configUI() : void {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         super.configUI();
         if(constraints)
         {
            constraints.addElement("messageArea",this.messageArea,Constraints.ALL);
         }
         this.messageArea.textField.addEventListener(TextEvent.LINK,this.onLinkClickHandler);
         this.updateSizes();
         requestInvitesS();
         window.setMaxWidth(MAX_MIN_WINDOW_SIZE.maxWidth);
         window.setMaxHeight(MAX_MIN_WINDOW_SIZE.maxHeight);
      }

      private function updateSizes() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(constraints)
         {
            _loc1_ = window.width - window.contentPadding.left - window.contentPadding.right;
            _loc2_ = window.height - window.contentPadding.top - window.contentPadding.bottom;
            constraints.update(_loc1_,_loc2_);
         }
      }

      private function onLinkClickHandler(param1:TextEvent) : void {
         selectedInviteS(param1.text);
      }
   }

}