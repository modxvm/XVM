package net.wg.gui.notification
{
   import net.wg.infrastructure.base.meta.impl.NotificationPopUpViewerMeta;
   import net.wg.infrastructure.base.meta.INotificationPopUpViewerMeta;
   import flash.geom.Point;
   import __AS3__.vec.Vector;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;


   public class NotificationPopUpViewer extends NotificationPopUpViewerMeta implements INotificationPopUpViewerMeta
   {
          
      public function NotificationPopUpViewer(param1:Class) {
         this.layoutInfo = new LayoutInfoVO(
            {
               "paddingRight":0,
               "paddingBottom":0
            }
         );
         this.stageDimensions = new Point(0,0);
         this.pendingForDisplay = new Vector.<NotificationInfoVO>();
         this.displayingNowPopUps = new Vector.<ServiceMessagePopUp>();
         super();
         this.popupClass = param1;
      }

      private var layoutInfo:LayoutInfoVO;

      private var stageDimensions:Point;

      private var pendingForDisplay:Vector.<NotificationInfoVO>;

      private var displayingNowPopUps:Vector.<ServiceMessagePopUp>;

      private var messageLivingTime:Number;

      private var popupPadding:uint = 0;

      private var isMessagesCountInvalid:Boolean;

      private var arrangeLayout:Boolean;

      private var maxAvailaleMessagesCount:uint = 5;

      private var popupClass:Class;

      private var animationSpeed:Number;

      override protected function draw() : void {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:NotificationInfoVO = null;
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:ServiceMessagePopUp = null;
         var _loc6_:ServiceMessagePopUp = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:* = 0;
         var _loc10_:* = NaN;
         super.draw();
         if(this.isMessagesCountInvalid)
         {
            this.isMessagesCountInvalid = false;
            _loc1_ = Math.min(this.maxAvailaleMessagesCount,this.pendingForDisplay.length);
            _loc2_ = 0;
            _loc4_ = App.systemMessages;
            while(this.pendingForDisplay.length > 0)
            {
               _loc3_ = this.pendingForDisplay.shift();
               if(this.pendingForDisplay.length < _loc1_)
               {
                  _loc5_ = new this.popupClass();
                  _loc5_.animationSpeed = this.animationSpeed;
                  _loc5_.livingTime = this.messageLivingTime;
                  App.instance.systemMessages.addChild(_loc5_);
                  _loc5_.addEventListener(ServiceMessageEvent.MESSAGE_AREA_CLICKED,this.messageClickHandler,false,0,true);
                  _loc5_.addEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this.mouseButtonClickHandler,false,0,true);
                  _loc5_.addEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this.messageLinkClickHandler,false,0,true);
                  _loc5_.addEventListener(ServiceMessagePopUp.HIDED,this.removePopupHandler,false,0,true);
                  _loc5_.data = _loc3_;
                  _loc5_.validateNow();
                  this.arrangeLayout = true;
                  this.displayingNowPopUps.unshift(_loc5_);
                  _loc2_++;
               }
            }
            while(this.displayingNowPopUps.length > this.maxAvailaleMessagesCount)
            {
               this.removePopupAt(this.displayingNowPopUps.length-1,true);
            }
         }
         if(this.arrangeLayout)
         {
            this.arrangeLayout = false;
            _loc7_ = 0;
            _loc8_ = this.displayingNowPopUps.length;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc6_ = this.displayingNowPopUps[_loc9_];
               _loc6_.x = Math.round(this.stageDimensions.x - _loc6_.width - this.layoutInfo.paddingRight);
               _loc10_ = _loc6_.height;
               _loc6_.y = Math.round(this.stageDimensions.y - _loc7_ - this.popupPadding * _loc9_ - this.layoutInfo.paddingBottom - _loc10_);
               _loc7_ = _loc7_ + _loc10_;
               _loc9_++;
            }
         }
      }

      private function messageClickHandler(param1:Event) : void {
         param1.stopImmediatePropagation();
         App.utils.scheduler.scheduleTask(this.postponedPopupRemoving,50,param1.target,false,true);
      }

      private function postponedPopupRemoving(param1:ServiceMessagePopUp, param2:Boolean, param3:Boolean=true) : void {
         var _loc4_:int = this.displayingNowPopUps.indexOf(param1);
         if(_loc4_ != -1)
         {
            this.removePopupAt(_loc4_,param2,param3);
         }
      }

      private function mouseButtonClickHandler(param1:Event) : void {
         param1.stopImmediatePropagation();
         var _loc2_:Object = NotificationInfoVO(ServiceMessagePopUp(param1.target).data).messageVO.showMore;
         onMessageShowMoreS(_loc2_);
         this.messageClickHandler(param1);
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

      private function removePopupHandler(param1:Event) : void {
         var _loc2_:ServiceMessagePopUp = ServiceMessagePopUp(param1.target);
         this.removePopupAt(this.displayingNowPopUps.indexOf(_loc2_),true);
      }

      public function as_removeAllMessages() : void {
         while(this.displayingNowPopUps.length > 0)
         {
            this.removePopupAt(0,false);
         }
      }

      private function removePopupAt(param1:int, param2:Boolean, param3:Boolean=true) : void {
         var _loc4_:ServiceMessagePopUp = this.displayingNowPopUps.splice(param1,1)[0];
         if(_loc4_.parent)
         {
            _loc4_.parent.removeChild(_loc4_);
         }
         _loc4_.dispose();
         _loc4_.removeEventListener(ServiceMessagePopUp.HIDED,this.removePopupHandler);
         _loc4_.removeEventListener(ServiceMessageEvent.MESSAGE_AREA_CLICKED,this.messageClickHandler);
         _loc4_.removeEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this.mouseButtonClickHandler);
         _loc4_.removeEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this.messageLinkClickHandler);
         if(param3)
         {
            onMessageHidedS(param2,NotificationInfoVO(_loc4_.data).notify);
         }
         if(this.displayingNowPopUps.length > 0)
         {
            this.arrangeLayout = true;
            if(!_baseDisposed)
            {
               invalidate();
            }
         }
         else
         {
            setListClearS();
            this.arrangeLayout = false;
         }
      }

      public function as_appendMessage(param1:Object) : void {
         var _loc2_:NotificationInfoVO = new NotificationInfoVO(param1);
         this.pendingForDisplay.push(_loc2_);
         this.isMessagesCountInvalid = true;
         invalidate();
      }

      public function as_initInfo(param1:Number, param2:Number, param3:Number, param4:Number) : void {
         this.maxAvailaleMessagesCount = param1;
         this.popupPadding = param3;
         this.messageLivingTime = param2;
         this.animationSpeed = param4;
         this.isMessagesCountInvalid = true;
         invalidate();
      }

      public function as_layoutInfo(param1:Object) : void {
         this.layoutInfo = new LayoutInfoVO(param1);
         this.arrangeLayout = true;
         invalidate();
      }

      public function updateStage(param1:Number, param2:Number) : void {
         this.stageDimensions = new Point(param1,param2);
         this.arrangeLayout = true;
         invalidate();
      }

      override protected function onDispose() : void {
         while(this.displayingNowPopUps.length > 0)
         {
            this.removePopupAt(0,false,false);
         }
         this.layoutInfo.dispose();
         this.layoutInfo = null;
         this.stageDimensions = null;
         this.pendingForDisplay.splice(0,this.pendingForDisplay.length);
         this.pendingForDisplay = null;
         this.displayingNowPopUps.splice(0,this.displayingNowPopUps.length);
         this.displayingNowPopUps = null;
         super.onDispose();
      }
   }

}