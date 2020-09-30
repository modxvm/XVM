/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.battleresults
{
    import com.xfw.*;
    import flash.events.*;
    import scaleform.clik.constants.*;

    public class UI_BattleResultsAwards extends BattleResultsAwards_UI
    {
        private var orig_awardTF_y:Number = NaN;
        private var orig_container_y:Number = NaN;
        private var orig_flagBottom_y:Number = NaN;
        private var orig_maskMC_height:Number = NaN;

        private const offsetTop:Number = 10;
        private const offsetBottom:Number = 20;

        public function UI_BattleResultsAwards()
        {
            Logger.add("UI_BattleResultsAwards -- begin");
            super();
            Logger.add("UI_BattleResultsAwards -- end");
        }

        override protected function draw():void
        {
            Logger.add("UI_BattleResultsAwards -- draw -- begin");
            super.draw();
            //return;

            if (isInvalid(InvalidationType.DATA))
            {
                if (this.height > 0)
                {
                    if (isNaN(orig_awardTF_y))
                    {
                        orig_awardTF_y = this.awardTF.y;
                        orig_container_y = this.container.y;
                        orig_maskMC_height= this.maskMC.height;
                    }

                    this.awardTF.y = orig_awardTF_y - offsetTop;
                    this.container.y = orig_container_y - offsetTop;

                    if (this.flagBottom)
                    {
                        if (isNaN(orig_flagBottom_y))
                        {
                            orig_flagBottom_y = this.flagBottom.y;
                        }
                        this.flagBottom.y = orig_flagBottom_y - offsetTop;
                    }

                    this.maskMC.height = orig_maskMC_height - offsetBottom;

                    _height = this.maskMC.height;
                    setSize(this.width, _height);
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }

            Logger.add("UI_BattleResultsAwards -- draw -- end");
        }
    }
}
