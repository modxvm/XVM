package net.wg.gui.notification
{
   import net.wg.infrastructure.base.meta.impl.NotificationPopUpViewerMeta;
   import net.wg.infrastructure.base.meta.INotificationPopUpViewerMeta;
   import net.wg.gui.notification.vo.LayoutInfoVO;
   import flash.geom.Point;
   import __AS3__.vec.Vector;
   import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
   import net.wg.gui.utils.ExcludeTweenManager;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import net.wg.gui.notification.events.ServiceMessageEvent;
   import net.wg.data.constants.Values;
   import fl.transitions.easing.Strong;
   import scaleform.clik.motion.Tween;
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
         this.pendingForDisplay = new Vector.<PopUpNotificationInfoVO>();
         this.displayingNowPopUps = new Vector.<ServiceMessagePopUp>();
         this.animationManager = new ExcludeTweenManager();
         super();
         this.popupClass = param1;
      }

      private var layoutInfo:LayoutInfoVO;

      private var stageDimensions:Point;

      private var pendingForDisplay:Vector.<PopUpNotificationInfoVO>;

      private var displayingNowPopUps:Vector.<ServiceMessagePopUp>;

      private var popupPadding:uint = 0;

      private var isMessagesCountInvalid:Boolean;

      private var arrangeLayout:Boolean;

      private var maxAvailaleMessagesCount:uint = 5;

      public var popupClass:Class;

      private var animationManager:ExcludeTweenManager;

      private const TWEEN_DURATION:uint = 500;

      override protected function configUI() : void {
         super.configUI();
         var _loc1_:DisplayObjectContainer = App.instance.systemMessages;
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler,false,0,true);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler,false,0,true);
      }

      private function mouseOverHandler(param1:MouseEvent) : void {
         this.applyHiding(true);
      }

      private function mouseOutHandler(param1:MouseEvent) : void {
         this.applyHiding(false);
      }

      private function applyHiding(param1:Boolean) : void {
         var _loc4_:ServiceMessagePopUp = null;
         var _loc2_:uint = this.displayingNowPopUps.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.displayingNowPopUps[_loc3_];
            _loc4_.allowHiding = param1;
            _loc3_++;
         }
      }

      override protected function draw() : void {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:PopUpNotificationInfoVO = null;
         var _loc4_:ServiceMessagePopUp = null;
         var _loc5_:* = NaN;
         var _loc6_:ServiceMessagePopUp = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:* = 0;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         super.draw();
         if(this.isMessagesCountInvalid)
         {
            this.isMessagesCountInvalid = false;
            _loc1_ = Math.min(this.maxAvailaleMessagesCount,this.pendingForDisplay.length);
            _loc2_ = 0;
            while(this.pendingForDisplay.length > 0)
            {
               _loc3_ = this.pendingForDisplay.shift();
               if(this.pendingForDisplay.length < _loc1_)
               {
                  _loc4_ = new this.popupClass();
                  App.instance.systemMessages.addChild(_loc4_);
                  _loc4_.addEventListener(ServiceMessageEvent.MESSAGE_AREA_CLICKED,this.messageClickHandler,false,0,true);
                  _loc4_.addEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this.mouseButtonClickHandler,false,0,true);
                  _loc4_.addEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this.messageLinkClickHandler,false,0,true);
                  _loc4_.addEventListener(ServiceMessagePopUp.HIDED,this.removePopupHandler,false,0,true);
                  _loc4_.data = _loc3_;
                  _loc5_ = _loc3_.messageVO.timestamp;
                  if(_loc5_ != Values.DEFAULT_INT)
                  {
                     _loc3_.messageVO.timestampStr = getMessageActualTimeS(_loc5_);
                  }
                  _loc4_.validateNow();
                  this.arrangeLayout = true;
                  this.displayingNowPopUps.unshift(_loc4_);
                  _loc2_++;
               }
            }
            while(this.displayingNowPopUps.length > this.maxAvailaleMessagesCount)
            {
               this.removePopupAt(this.displayingNowPopUps.length-1,true);
            }
         }
         if((this.arrangeLayout) && (this.stageDimensions))
         {
            this.arrangeLayout = false;
            _loc7_ = 0;
            _loc8_ = this.displayingNowPopUps.length;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc6_ = this.displayingNowPopUps[_loc9_];
               _loc10_ = _loc6_.height;
               _loc11_ = Math.round(this.stageDimensions.y - _loc7_ - this.popupPadding * _loc9_ - this.layoutInfo.paddingBottom - _loc10_);
               if(!_loc6_.isLayoutInitialized)
               {
                  _loc6_.isLayoutInitialized = true;
                  _loc6_.y = _loc11_;
                  _loc6_.x = this.stageDimensions.x;
                  _loc6_.alpha = 0;
               }
               this.animationManager.registerAndLaunch(this.TWEEN_DURATION,_loc6_,
                  {
                     "y":_loc11_,
                     "alpha":1,
                     "x":Math.round(this.stageDimensions.x - _loc6_.width - this.layoutInfo.paddingRight)
                  }
               ,this.getDefaultTweenSet());
               _loc7_ = _loc7_ + _loc10_;
               _loc9_++;
            }
         }
      }

      private function getDefaultTweenSet() : Object {
         var _loc1_:Object = {};
         _loc1_.ease = Strong.easeOut;
         _loc1_.onComplete = this.onTweenComplete;
         return _loc1_;
      }

      private function onTweenComplete(param1:Tween) : void {
         this.animationManager.unregister(param1);
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

      private function mouseButtonClickHandler(param1:ServiceMessageEvent) : void {
         param1.stopImmediatePropagation();
         onClickActionS(param1.typeID,param1.entityID,param1.action);
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
         this.applyHiding(false);
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
            onMessageHidedS(param2,PopUpNotificationInfoVO(_loc4_.data).notify);
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
         var _loc2_:PopUpNotificationInfoVO = new PopUpNotificationInfoVO(param1);
         this.pendingForDisplay.push(_loc2_);
         this.isMessagesCountInvalid = true;
         invalidate();
      }

      public function as_getPopUpIndex(param1:uint, param2:Number) : int {
         var _loc3_:PopUpNotificationInfoVO = null;
         var _loc4_:int = this.displayingNowPopUps.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this.displayingNowPopUps[_loc5_].data as PopUpNotificationInfoVO;
            if((_loc3_) && (_loc3_.typeID == param1) && _loc3_.entityID == param2)
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return -1;
      }

      public function as_updateMessage(param1:Object) : void {
         var _loc4_:ServiceMessagePopUp = null;
         var _loc2_:PopUpNotificationInfoVO = new PopUpNotificationInfoVO(param1);
         var _loc3_:int = this.as_getPopUpIndex(_loc2_.typeID,_loc2_.entityID);
         if(_loc3_ > -1 && this.displayingNowPopUps.length > _loc3_)
         {
            _loc4_ = this.displayingNowPopUps[_loc3_];
            _loc4_.data = _loc2_;
            _loc4_.validateNow();
            if(!_baseDisposed)
            {
               invalidate();
            }
         }
      }

      public function as_removeMessage(param1:uint, param2:Number) : void {
         var _loc3_:int = this.as_getPopUpIndex(param1,param2);
         if(_loc3_ > -1 && this.displayingNowPopUps.length > _loc3_)
         {
            this.removePopupAt(_loc3_,false,false);
         }
      }

      public function as_initInfo(param1:Number, param2:Number) : void {
         this.maxAvailaleMessagesCount = param1;
         this.popupPadding = param2;
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
         var _loc1_:DisplayObjectContainer = App.instance.systemMessages;
         _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOverHandler);
         _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOutHandler);
         this.animationManager.dispose();
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