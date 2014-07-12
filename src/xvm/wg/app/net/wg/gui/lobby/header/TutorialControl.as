package net.wg.gui.lobby.header
{
   import net.wg.infrastructure.base.meta.impl.TutorialControlMeta;
   import net.wg.infrastructure.base.meta.ITutorialControlMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import flash.text.TextField;
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import flash.events.MouseEvent;
   import net.wg.gui.tutorial.constants.PlayerXPLevel;
   import net.wg.gui.events.HeaderEvent;
   import net.wg.gui.utils.ComplexTooltipHelper;
   
   public class TutorialControl extends TutorialControlMeta implements ITutorialControlMeta, IDAAPIModule
   {
      
      public function TutorialControl() {
         this._level = PlayerXPLevel.NEWBIE;
         super();
      }
      
      private static const PREFIX_NORMAL:String = "normal_";
      
      private static const PREFIX_NEWBIE:String = "newbie_";
      
      private static const PREFIX_RUN:String = "run_";
      
      private static const PREFIX_PAUSE:String = "pause_";
      
      private static const LEFT_PADDING:int = 40;
      
      private var _title:String = "";
      
      private var _description:String = "";
      
      private var _level:Number;
      
      private var _isRunning:Boolean = false;
      
      private var _visibleTD:Boolean;
      
      private var _visibleIfRun:Boolean = false;
      
      private var _restartStatus:String = "";
      
      private var _refuseStatus:String = "";
      
      public var titleField:TextField;
      
      public var stateField:TextField;
      
      private var _disposed:Boolean = false;
      
      public function get disposed() : Boolean {
         return this._disposed;
      }
      
      public function as_setup(param1:Object) : void {
         this._visibleIfRun = param1.visibleIfRun;
         this._restartStatus = param1.restartStatus;
         this._refuseStatus = param1.refuseStatus;
      }
      
      public function as_setPlayerXPLevel(param1:int) : void {
         this._level = param1;
         invalidate();
      }
      
      public function as_setChapterInfo(param1:String, param2:String) : void {
         this._visibleTD = this._isRunning?this._visibleIfRun:true;
         this._title = param1;
         this._description = param2;
         invalidate();
      }
      
      public function as_clearChapterInfo() : void {
         this._visibleTD = false;
         this._title = "";
         this._description = "";
         invalidate();
      }
      
      public function as_setRunMode() : void {
         this._isRunning = true;
         this._visibleTD = this._visibleIfRun;
         setState(state);
      }
      
      public function as_setRestartMode() : void {
         this._isRunning = false;
         this._visibleTD = true;
         setState(state);
      }
      
      public function as_setDisabled(param1:Boolean) : void {
         App.globalVarsMgr.setTutorialDisabledS(param1);
         enabled = !param1;
         this.hideToolTip();
         setState(state);
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
      
      override protected function configUI() : void {
         super.configUI();
         preventAutosizing = true;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onPress);
         setState("out");
      }
      
      override protected function draw() : void {
         super.draw();
         visible = this._visibleTD;
         if((this.titleField) && (this._title))
         {
            this.titleField.text = this._title;
         }
         if(this.stateField)
         {
            this.stateField.text = this._isRunning?this._refuseStatus:this._restartStatus;
            hitMc.width = Math.round(LEFT_PADDING + this.stateField.textWidth);
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String> {
         if(!enabled)
         {
            return Vector.<String>([this.getLevelPrefix()]);
         }
         var _loc1_:String = this._isRunning?PREFIX_RUN:PREFIX_PAUSE + this.getLevelPrefix();
         return Vector.<String>([_loc1_]);
      }
      
      private function getLevelPrefix() : String {
         return this._level == PlayerXPLevel.NORMAL?PREFIX_NORMAL:PREFIX_NEWBIE;
      }
      
      override protected function onDispose() : void {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onPress);
         this.titleField = null;
         this.stateField = null;
         super.onDispose();
      }
      
      private function onRollOver(param1:MouseEvent) : void {
         this.showToolTip();
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         this.hideToolTip();
      }
      
      private function onPress(param1:MouseEvent) : void {
         this.hideToolTip();
         if(App.utils.commons.isLeftButton(param1))
         {
            this.hideToolTip();
            if(this._isRunning)
            {
               dispatchEvent(new HeaderEvent(HeaderEvent.SHOW_MESSAGE_DIALOG,"refuseTraining"));
            }
            else if(enabled)
            {
               restartS();
            }
            
         }
      }
      
      private function showToolTip() : void {
         var _loc1_:String = new ComplexTooltipHelper().addHeader(this._title).addBody(this._description).addNote(!this._isRunning?TUTORIAL.TOOLTIP_NOTES_RESTART:null,true).make();
         if(_loc1_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc1_);
         }
      }
      
      private function hideToolTip() : void {
         App.toolTipMgr.hide();
      }
   }
}
