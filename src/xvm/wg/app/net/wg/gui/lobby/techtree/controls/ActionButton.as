package net.wg.gui.lobby.techtree.controls
{
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.lobby.techtree.data.state.AnimationProperties;
   import scaleform.clik.motion.Tween;
   import net.wg.gui.utils.ImageSubstitution;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.BitmapFill;
   import scaleform.clik.core.UIComponent;
   import fl.transitions.easing.Strong;
   import flash.display.DisplayObject;
   import scaleform.gfx.Extensions;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.ActionName;
   
   public class ActionButton extends SoundButton
   {
      
      public function ActionButton() {
         super();
      }
      
      private var animProps:AnimationProperties = null;
      
      private var animID:Number = -1;
      
      private var animTween:Tween = null;
      
      private var _action:String = "unlock";
      
      private var _imgSubstitution:ImageSubstitution;
      
      public var icon:MovieClip;
      
      public var disableIndicator:BitmapFill;
      
      public function set imgSubstitution(param1:Object) : void {
         this._imgSubstitution = new ImageSubstitution(param1.subString,param1.source,param1.baseLineY,param1.width,param1.height,true);
      }
      
      public function get action() : String {
         return this._action;
      }
      
      public function set action(param1:String) : void {
         if(this._action == param1)
         {
            return;
         }
         this._action = param1;
         this.makeStatesPrefixes();
         setState(this.state);
      }
      
      public function setOwner(param1:UIComponent, param2:Boolean = false) : void {
         if(_owner != param1)
         {
            _owner = param1;
            this.focusTarget = _owner;
         }
         if(param2)
         {
            validateNow();
         }
      }
      
      public function setAnimation(param1:Number, param2:AnimationProperties) : Boolean {
         if(this.animID == param1)
         {
            return false;
         }
         this.animID = param1;
         if(this.animProps != null)
         {
            this.animProps.setTo(this);
         }
         this.animProps = param2;
         if(param2 != null)
         {
            this.animProps.setFrom(this);
            if(alpha == 0)
            {
               enabled = false;
            }
         }
         return true;
      }
      
      public function startAnimation() : void {
         if(this.animProps != null)
         {
            this.resetTween();
            this.animTween = new Tween(this.animProps.duration,this,this.animProps.to,
               {
                  "ease":Strong.easeOut,
                  "onComplete":this.onTweenComplete,
                  "paused":false
               });
         }
      }
      
      public function endAnimation(param1:Boolean) : void {
         var _loc2_:DisplayObject = null;
         var _loc3_:* = false;
         if(this.animProps != null)
         {
            _loc2_ = Extensions.getMouseTopMostEntity(true);
            _loc3_ = false;
            if(!(_loc2_ == null) && !(owner == null))
            {
               _loc3_ = _loc2_ == owner || (owner.contains(_loc2_));
            }
            if(!param1 && (owner.hitTestPoint(stage.mouseX,stage.mouseY,true)) && (_loc3_))
            {
               return;
            }
            if((this.hitTestPoint(stage.mouseX,stage.mouseY,true)) && (_loc3_))
            {
               if(this.animTween != null)
               {
                  this.animTween.reset();
               }
               this.animProps.setTo(this);
            }
            else
            {
               this.resetTween();
               this.animTween = new Tween(this.animProps.duration,this,this.animProps.from,
                  {
                     "ease":Strong.easeOut,
                     "onComplete":this.onTweenComplete,
                     "paused":false
                  });
            }
         }
      }
      
      override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean {
         return hitArea != null?hitArea.hitTestPoint(param1,param2,param3):super.hitTestPoint(param1,param2,param3);
      }
      
      public function onTweenComplete() : void {
         if(alpha == 0)
         {
            mouseEnabled = false;
         }
         else
         {
            mouseEnabled = enabled;
         }
      }
      
      override protected function onDispose() : void {
         owner = null;
         super.onDispose();
      }
      
      override protected function preInitialize() : void {
         super.preInitialize();
         _state = "up";
      }
      
      override protected function initialize() : void {
         this.makeStatesPrefixes();
         super.initialize();
      }
      
      override protected function draw() : void {
         super.draw();
         if(_baseDisposed)
         {
            return;
         }
         if((isInvalid(InvalidationType.STATE)) && !(this.disableIndicator == null))
         {
            this.disableIndicator.visible = state == "disabled";
         }
      }
      
      override protected function updateText() : void {
         if(!(_label == null) && !(textField == null))
         {
            if(!(this._imgSubstitution == null) && (this._imgSubstitution.valid))
            {
               TextFieldEx.setImageSubstitutions(textField,this._imgSubstitution);
               textField.text = label + this._imgSubstitution.subString;
            }
            else
            {
               textField.text = label;
            }
         }
      }
      
      override protected function handleClick(param1:uint = 0) : void {
         super.handleClick(param1);
         this.doAction();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         this.endAnimation(false);
      }
      
      override protected function handleReleaseOutside(param1:MouseEvent) : void {
         super.handleReleaseOutside(param1);
         this.endAnimation(false);
      }
      
      private function resetTween() : void {
         if(this.animTween)
         {
            this.animTween.paused = true;
            this.animTween = null;
         }
      }
      
      private function doAction() : void {
         var _loc2_:IRenderer = null;
         var _loc1_:String = null;
         switch(this._action)
         {
            case ActionName.UNLOCK:
               _loc1_ = TechTreeEvent.CLICK_2_UNLOCK;
               break;
            case ActionName.BUY:
               _loc1_ = TechTreeEvent.CLICK_2_BUY;
               break;
         }
         if(!(_loc1_ == null) && !(owner == null))
         {
            _loc2_ = owner as IRenderer;
            if(_loc2_ != null)
            {
               dispatchEvent(new TechTreeEvent(_loc1_,0,_loc2_.index,_loc2_.getEntityType()));
            }
         }
      }
      
      private function makeStatesPrefixes() : void {
         var _loc1_:* = this._action + "_";
         statesSelected = Vector.<String>(["selected_",_loc1_]);
         statesDefault = Vector.<String>([_loc1_]);
      }
   }
}
