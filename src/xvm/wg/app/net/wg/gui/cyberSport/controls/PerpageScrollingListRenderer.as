package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.events.MouseEvent;
   import net.wg.gui.cyberSport.controls.events.NavigationEvent;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.cyberSport.vo.CSCommandVO;
   import scaleform.clik.constants.InvalidationType;


   public class PerpageScrollingListRenderer extends SoundListItemRenderer
   {
          
      public function PerpageScrollingListRenderer() {
         super();
         preventAutosizing = true;
      }

      public var navigationBlock:NavigationBlock;

      public var commander:TextField = null;

      public var commandSize:TextField = null;

      public var commandMaxSize:TextField = null;

      public var effency:TextField = null;

      public var serverTF:TextField;

      public var freezeIcon:MovieClip;

      public var restrictionIcon:MovieClip;

      public var inBattleMC:MovieClip;

      private var _dataChanged:Boolean = false;

      protected function checkTooltip() : void {
         if(!this._dataChanged)
         {
            return;
         }
         var _loc1_:Point = new Point(mouseX,mouseY);
         _loc1_ = localToGlobal(_loc1_);
         if(hitTestPoint(_loc1_.x,_loc1_.y))
         {
            if(data)
            {
               dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
            }
            else
            {
               App.toolTipMgr.hide();
            }
         }
      }

      override public function setData(param1:Object) : void {
         this._dataChanged = (this.data && param1) && !(param1.unitMgrID == this.data.unitMgrID) || (this.data) && !param1;
         if(((!this._dataChanged) && (this.data)) && (param1) && (this.data.isEquals(param1)))
         {
            return;
         }
         this.data = param1;
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         this.commander.mouseEnabled = false;
         this.commandSize.mouseEnabled = false;
         this.commandMaxSize.mouseEnabled = false;
         this.effency.mouseEnabled = false;
         this.inBattleMC.mouseEnabled = false;
         this.serverTF.mouseEnabled = false;
         this.freezeIcon.useHandCursor = this.freezeIcon.buttonMode = true;
         this.restrictionIcon.useHandCursor = this.restrictionIcon.buttonMode = true;
         this.freezeIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.freezeIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.restrictionIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.restrictionIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         if(owner != null)
         {
            owner.addEventListener(NavigationEvent.NAVIGATION_IN_COOL_DOWN,this.onNavigationInCoolDown);
         }
      }

      override public function dispose() : void {
         if(owner != null)
         {
            owner.removeEventListener(NavigationEvent.NAVIGATION_IN_COOL_DOWN,this.onNavigationInCoolDown);
         }
         this.freezeIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.freezeIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.navigationBlock.dispose();
         this.navigationBlock = null;
         this.commander = null;
         this.commandSize = null;
         this.commandMaxSize = null;
         this.effency = null;
         super.dispose();
      }

      private function onControlRollOver(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(param1.currentTarget == this.freezeIcon?TOOLTIPS.SETTINGSICON_FREEZED:TOOLTIPS.SETTINGSICON_CONDITIONS);
      }

      private function onControlRollOut(param1:MouseEvent=null) : void {
         App.toolTipMgr.hide();
         dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
      }

      private function onRequestButtonClickHandler(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         dispatchEvent(new CSComponentEvent(CSComponentEvent.NEW_PAGE_REQUEST,data));
      }

      private function onNavigationInCoolDown(param1:NavigationEvent) : void {
         var _loc3_:* = false;
         var _loc2_:CSCommandVO = CSCommandVO(data);
         if((_loc2_) && (_loc2_.isLoadMoreState) && (this.navigationBlock))
         {
            _loc3_ = param1.isInCoolDown;
            _loc2_.navigationConfig.previousEnabled = !_loc3_;
            _loc2_.navigationConfig.nextEnabled = !_loc3_;
            this.navigationBlock.setInCoolDown(param1.isInCoolDown);
         }
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         mouseEnabled = true;
         mouseChildren = true;
      }

      override protected function draw() : void {
         var _loc1_:CSCommandVO = null;
         mouseEnabled = true;
         mouseChildren = true;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = CSCommandVO(data);
            if(_loc1_)
            {
               this.visible = true;
               if(_loc1_.isLoadMoreState)
               {
                  gotoAndStop("last");
                  this.navigationBlock.setup(_loc1_.navigationConfig);
                  this.navigationBlock.visible = true;
                  this.setControlsVisible(false);
               }
               else
               {
                  this.setControlsVisible(true);
                  this.navigationBlock.visible = false;
                  this.commander.htmlText = App.utils.commons.formatPlayerName(this.commander,_loc1_.creator);
                  this.effency.text = App.utils.locale.integer(_loc1_.rating);
                  this.commandSize.text = String(_loc1_.playersCount);
                  this.commandMaxSize.text = "/" + String(_loc1_.commandSize);
                  this.inBattleMC.visible = false;
                  this.freezeIcon.visible = _loc1_.isFreezed;
                  this.restrictionIcon.visible = _loc1_.isRestricted;
                  if(_loc1_.server)
                  {
                     this.serverTF.text = _loc1_.server;
                     this.serverTF.visible = true;
                  }
                  else
                  {
                     this.serverTF.visible = false;
                  }
               }
            }
            else
            {
               this.visible = false;
            }
            this.checkTooltip();
         }
      }

      private function setControlsVisible(param1:Boolean) : void {
         this.commander.visible = param1;
         this.effency.visible = param1;
         this.commandSize.visible = param1;
         this.commandMaxSize.visible = param1;
         this.inBattleMC.visible = param1;
         this.freezeIcon.visible = param1;
         this.restrictionIcon.visible = param1;
         this.serverTF.visible = param1;
      }
   }

}