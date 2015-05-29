/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar_ui.battleResults
{
    import com.xfw.*;
    import flash.events.*;
    import scaleform.clik.constants.*;

    public dynamic class UI_BattleResultsAwards extends BattleResultsAwards_UI
    {
        public function UI_BattleResultsAwards()
        {
            //Logger.add("UI_BattleResultsAwards");
            super();
        }

        override protected function draw():void
        {
            super.draw();
            //return;

            if (isInvalid(InvalidationType.DATA) && this.height > 0)
            {
                var offsetTop:Number = 10;
                var offsetBottom:Number = 20;

                this.awardTF.y -= offsetTop;
                this.container.y -= offsetTop;

                if (this.flagBottom)
                {
                    this.flagBottom.y -= offsetTop;
                }

                this.maskMC.height -= offsetBottom;

                _height = this.maskMC.height;
                setSize(this.width, _height);
                dispatchEvent(new Event(Event.RESIZE));
            }
        }
    }
}
