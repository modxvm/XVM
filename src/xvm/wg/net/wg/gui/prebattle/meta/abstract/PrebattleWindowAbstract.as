package net.wg.gui.prebattle.meta.abstract 
{
    import flash.ui.*;
    import net.wg.gui.prebattle.meta.*;
    import net.wg.gui.prebattle.meta.impl.*;
    import net.wg.infrastructure.exceptions.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class PrebattleWindowAbstract extends net.wg.gui.prebattle.meta.impl.PrebattleWindowMeta implements net.wg.gui.prebattle.meta.IPrebattleWindowMeta
    {
        public function PrebattleWindowAbstract()
        {
            super();
            return;
        }

        public function as_enableLeaveBtn(arg1:Boolean):void
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("This method should be overriden");
        }

        public function as_enableReadyBtn(arg1:Boolean):void
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("This method should be overriden");
        }

        public function as_toggleReadyBtn(arg1:Boolean):void
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("This method should be overriden");
        }

        public function as_setPlayerState(arg1:int, arg2:Boolean, arg3:Object):void
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("This method should be overriden");
        }

        public function as_setCoolDownForReadyButton(arg1:uint):void
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("This method should be overriden");
        }

        public function as_setRosterList(arg1:int, arg2:Boolean, arg3:Array):void
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("This method should be overriden");
        }

        public function as_refreshPermissions():void
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("This method should be overriden");
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            if (arg1.handled) 
                return;
            if (arg1.details.code == flash.ui.Keyboard.F1 && arg1.details.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                showFAQWindowS();
                arg1.handled = true;
            }
            return;
        }
    }
}
