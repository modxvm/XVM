package net.wg.gui.lobby.eventBattleResult.components
{
    import flash.text.TextField;
    import flash.display.MovieClip;
    import scaleform.gfx.TextFieldEx;

    public class ResultObjectives extends ResultStatItem
    {

        private static const DIVIDER:String = "/";

        public var textTotal:TextField = null;

        public var textDivider:TextField = null;

        public var topFx:MovieClip = null;

        public var bottomFx:MovieClip = null;

        public function ResultObjectives()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            TextFieldEx.setNoTranslate(this.textTotal,true);
            TextFieldEx.setNoTranslate(this.textDivider,true);
            this.textDivider.text = DIVIDER;
            mouseEnabled = false;
            this.topFx.mouseEnabled = this.topFx.mouseChildren = this.bottomFx.mouseEnabled = this.bottomFx.mouseChildren = false;
        }

        public function setTotal(param1:int) : void
        {
            this.textTotal.text = param1.toString();
        }

        override public function setIcon(param1:int) : void
        {
        }

        override protected function onDispose() : void
        {
            this.textTotal = null;
            this.textDivider = null;
            this.topFx = null;
            this.bottomFx = null;
            super.onDispose();
        }
    }
}
