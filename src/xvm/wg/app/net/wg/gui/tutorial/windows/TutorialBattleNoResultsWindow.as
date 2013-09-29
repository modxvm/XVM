package net.wg.gui.tutorial.windows 
{
    import flash.text.*;
    import net.wg.gui.tutorial.meta.*;
    import net.wg.gui.tutorial.meta.impl.*;
    import scaleform.clik.constants.*;
    
    public class TutorialBattleNoResultsWindow extends net.wg.gui.tutorial.meta.impl.TutorialBattleNoResultsMeta implements net.wg.gui.tutorial.meta.ITutorialBattleNoResultsMeta
    {
        public function TutorialBattleNoResultsWindow()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this.data) 
            {
                this.textField.text = this.data.text;
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.data = null;
            return;
        }

        public function as_setData(arg1:Object):void
        {
            this.data = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.useBottomBtns = false;
            window.title = BATTLE_TUTORIAL.WINDOWS_RESULT_TITLE;
            return;
        }

        public var textField:flash.text.TextField;

        protected var data:Object;
    }
}
