package net.wg.gui.notification
{
   import net.wg.infrastructure.base.meta.impl.NotificationsListMeta;
   import net.wg.infrastructure.base.meta.INotificationsListMeta;
   import flash.geom.Point;
   import flash.events.MouseEvent;
   import scaleform.clik.events.InputEvent;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import flash.display.DisplayObject;
   import scaleform.clik.data.DataProvider;


   public class NotificationListView extends NotificationsListMeta implements INotificationsListMeta
   {
          
      public function NotificationListView() {
         this.layoutInfo = new LayoutInfoVO(
            {
               "paddingRight":0,
               "paddingBottom":0
            }
         );
         this.stageDimensions = new Point();
         super();
      }

      private static const LAYOUT_INV:String = "layoutInv";

      private var layoutInfo:LayoutInfoVO;

      private var stageDimensions:Point;

      public var list:NotificationsList;

      public var rendererTemplate:ServiceMessageItemRenderer;

      override protected function configUI() : void {
         super.configUI();
         stage.addEventListener(MouseEvent.CLICK,this.stageClickHandler,false,0,true);
         this.stageDimensions.x = stage.stageWidth;
         this.stageDimensions.y = stage.stageHeight;
         this.list.addEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this.messageButtonClickHandler,false,0,true);
         this.list.addEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this.messageLinkClickHandler,false,0,true);
         if(this.rendererTemplate)
         {
            if(this.rendererTemplate.parent)
            {
               this.rendererTemplate.parent.removeChild(this.rendererTemplate);
               this.rendererTemplate = null;
            }
         }
      }

      private function messageButtonClickHandler(param1:ServiceMessageEvent) : void {
         param1.stopImmediatePropagation();
         onMessageShowMoreS(NotificationInfoVO(ServiceMessage(param1.target).data).messageVO.showMore);
      }

      private function messageLinkClickHandler(param1:ServiceMessageEvent) : void {
         param1.stopImmediatePropagation();
         switch(param1.linkType)
         {
            case "securityLink":
               onSecuritySettingsLinkClickS();
               break;
         }
      }

      override public function handleInput(param1:InputEvent) : void {
         super.handleInput(param1);
         if(param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            onWindowCloseS();
         }
      }

      private function stageClickHandler(param1:MouseEvent) : void {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(!_loc2_)
         {
            return;
         }
         while(_loc2_)
         {
            if(_loc2_ == this)
            {
               return;
            }
            _loc2_ = _loc2_.parent;
         }
         onWindowCloseS();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(LAYOUT_INV))
         {
            this.x = this.stageDimensions.x - this.width - this.layoutInfo.paddingRight;
            this.y = this.stageDimensions.y - this.height - this.layoutInfo.paddingBottom;
         }
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
         this.stageDimensions.x = param1;
         this.stageDimensions.y = param2;
         invalidate(LAYOUT_INV);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
      }

      public function as_setInitData(param1:Object) : void {
         var _loc2_:* = "scrollStepFactor";
         if(param1.hasOwnProperty(_loc2_))
         {
            this.list.scrollStepFactor = param1[_loc2_];
         }
      }

      public function as_setMessagesList(param1:Array) : void {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Array = [];
         var _loc3_:uint = param1.length;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(new NotificationInfoVO(param1[_loc4_]));
            _loc4_++;
         }
         this.list.dataProvider = new DataProvider(_loc2_);
      }

      public function as_appendMessage(param1:Object) : void {
         this.list.appendData(new NotificationInfoVO(param1));
      }

      public function as_layoutInfo(param1:Object) : void {
         this.layoutInfo = new LayoutInfoVO(param1);
         invalidate(LAYOUT_INV);
      }

      override protected function onDispose() : void {
         if(stage)
         {
            stage.removeEventListener(MouseEvent.CLICK,this.stageClickHandler);
         }
         this.list.removeEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this.messageButtonClickHandler);
         this.list.removeEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this.messageLinkClickHandler);
         super.onDispose();
      }
   }

}