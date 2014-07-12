package net.wg.gui.components.common.waiting
{
   import scaleform.clik.core.UIComponent;
   import flash.display.Sprite;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   
   public class WaitingComponent extends UIComponent
   {
      
      public function WaitingComponent() {
         super();
      }
      
      private static const TEXT_INVALID:String = "textInv";
      
      private static const ANIMATION_STATUS_INVALID:String = "animStatusInv";
      
      public var waitingMc:WaitingMc;
      
      public var backgroundMc:Sprite;
      
      private var text:String = "";
      
      private var _isStopped:Boolean;
      
      public function setAnimationStatus(param1:Boolean) : void {
         if(this._isStopped != param1)
         {
            this._isStopped = param1;
            invalidate(ANIMATION_STATUS_INVALID);
         }
      }
      
      override protected function preInitialize() : void {
         super.preInitialize();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }
      
      override protected function configUI() : void {
         super.configUI();
         constraints.addElement(this.waitingMc.name,this.waitingMc,Constraints.CENTER_H | Constraints.CENTER_V);
         constraints.addElement(this.backgroundMc.name,this.backgroundMc,Constraints.ALL);
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
            this.backgroundMc.x = this.backgroundMc.x ^ 0;
            this.backgroundMc.y = this.backgroundMc.y ^ 0;
            this.waitingMc.x = this.waitingMc.x ^ 0;
            this.waitingMc.y = this.waitingMc.y ^ 0;
         }
         if(isInvalid(TEXT_INVALID))
         {
            this.waitingMc.setMessage(this.text);
         }
         if(isInvalid(ANIMATION_STATUS_INVALID))
         {
            if(this._isStopped)
            {
               this.waitingMc.stop();
            }
            else
            {
               this.waitingMc.play();
            }
         }
      }
      
      public function setMessage(param1:String) : void {
         this.text = param1;
         invalidate(TEXT_INVALID);
      }
   }
}
