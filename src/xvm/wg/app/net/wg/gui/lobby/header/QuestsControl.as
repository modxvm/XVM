package net.wg.gui.lobby.header
{
   import net.wg.infrastructure.base.meta.impl.QuestsControlMeta;
   import net.wg.infrastructure.base.meta.IQuestsControlMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   import net.wg.infrastructure.events.LifeCycleEvent;
   
   public class QuestsControl extends QuestsControlMeta implements IQuestsControlMeta, IDAAPIModule
   {
      
      public function QuestsControl() {
         super();
      }
      
      private static const ANIMATE:String = "animate";
      
      private static const PAUSE:String = "pause";
      
      private static const NEW:String = "New";
      
      public var anim:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      private var _hasNew:Boolean = false;
      
      public function get disposed() : Boolean {
         return this._disposed;
      }
      
      public function as_highlightControl() : void {
         this._hasNew = true;
         invalidate(NEW);
      }
      
      public function as_resetControl() : void {
         this._hasNew = false;
         invalidate(NEW);
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.label = QUESTS.QUESTSCONTROL_TITLE;
         addEventListener(MouseEvent.MOUSE_DOWN,this.onPress);
         addEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
      }
      
      override protected function onDispose() : void {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onPress);
         removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.anim = null;
         super.onDispose();
      }
      
      override protected function draw() : void {
         if(isInvalid(NEW))
         {
            if(this._hasNew)
            {
               this.anim.gotoAndPlay(ANIMATE);
            }
            else
            {
               this.anim.gotoAndStop(PAUSE);
            }
            setState("up");
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               _newFrame = null;
            }
            if((focusIndicator) && (_newFocusIndicatorFrame))
            {
               focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
               _newFocusIndicatorFrame = null;
            }
            updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            updateText();
         }
      }
      
      private function onPress(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
         if(App.utils.commons.isLeftButton(param1))
         {
            this.anim.gotoAndStop(PAUSE);
            showQuestsWindowS();
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String> {
         var _loc1_:* = "new_";
         return this._hasNew?Vector.<String>([_loc1_]):statesDefault;
      }
      
      public function as_populate() : void {
      }
      
      public function as_dispose() : void {
         try
         {
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
            dispose();
            this._disposed = true;
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
         }
         catch(error:WGGUIException)
         {
            DebugUtils.LOG_WARNING(error.getStackTrace());
         }
      }
      
      private function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
      
      private function showTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(TOOLTIPS.QUESTS_NOTIFIER);
      }
   }
}
