package net.wg.gui.prebattle.meta.abstract
{
   import net.wg.gui.prebattle.meta.impl.PrebattleWindowMeta;
   import net.wg.gui.prebattle.meta.IPrebattleWindowMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.events.InputEvent;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;


   public class PrebattleWindowAbstract extends PrebattleWindowMeta implements IPrebattleWindowMeta
   {
          
      public function PrebattleWindowAbstract() {
         super();
         isSourceTracked = true;
      }

      public function as_enableLeaveBtn(param1:Boolean) : void {
         throw new AbstractException("This method should be overriden");
      }

      public function as_enableReadyBtn(param1:Boolean) : void {
         throw new AbstractException("This method should be overriden");
      }

      public function as_toggleReadyBtn(param1:Boolean) : void {
         throw new AbstractException("This method should be overriden");
      }

      public function as_setPlayerState(param1:int, param2:Boolean, param3:Object) : void {
         throw new AbstractException("This method should be overriden");
      }

      public function as_setCoolDownForReadyButton(param1:uint) : void {
         throw new AbstractException("This method should be overriden");
      }

      public function as_setRosterList(param1:int, param2:Boolean, param3:Array) : void {
         throw new AbstractException("This method should be overriden");
      }

      public function as_refreshPermissions() : void {
         throw new AbstractException("This method should be overriden");
      }

      override public function handleInput(param1:InputEvent) : void {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         if(param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP)
         {
            showFAQWindowS();
            param1.handled = true;
         }
      }
   }

}