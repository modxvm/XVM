package xvm.hangar.UI.battleResults
{
    import com.xvm.*;
    import flash.events.*;
    import scaleform.clik.constants.*;

    public dynamic class UI_BattleResultsAwards extends BattleResultsAwards_UI
    {
        public function UI_BattleResultsAwards() {
            super();
            //Logger.add("UI_BattleResultsAwards");
        }

        private static const TEXT_TOP:int = 5;
        private static const MARGIN:int = 0;
        override protected function draw():void
        {
            super.draw();

            if (isInvalid(InvalidationType.DATA))
            {
                if (_height > 0)
                {
                    this.awardTF.y = TEXT_TOP + MARGIN;
                    this.awardDescrTF.y = TEXT_TOP + MARGIN + 1;
                    this.maskMC.height = this.awardDescrTF.y + Math.min(this.awardDescrTF.textHeight, this.awardDescrTF.height) + MARGIN + TEXT_TOP * 2;
                    _height = this.maskMC.height;
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }
    }
}
