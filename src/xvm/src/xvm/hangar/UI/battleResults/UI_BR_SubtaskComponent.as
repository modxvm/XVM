package xvm.hangar.UI.battleResults
{
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.lobby.questsWindow.*;
    import scaleform.clik.constants.*;

    /**
     * @author Pavel Máca
     */
    public dynamic class UI_BR_SubtaskComponent extends BR_SubtaskComponent_UI
    {
        public function UI_BR_SubtaskComponent()
        {
            super();
            //return;

            var index:int = getChildIndex(awards);
            removeChild(awards);
            awards = App.utils.classFactory.getComponent(getQualifiedClassName(UI_BattleResultsAwards), QuestAwardsBlock);
            addChildAt(awards, index);
        }

        override protected function configUI():void
        {
            super.configUI();
            //return;

            progressList.linkage = getQualifiedClassName(UI_ProgressElement);
        }

        override protected function draw():void
        {
            super.draw();
            //return;

            if (isInvalid(InvalidationType.DATA))
            {
                if (this.data)
                {
                    var offsetTop:Number = 10;
                    var offsetMiddle:Number = 20;
                    var offsetBottom:Number = 20;

                    // move elements up
                    this.taskTF.y -= offsetTop;
                    this.linkBtn.y -= offsetTop;
                    this.statusMC.y -= offsetTop;
                    this.counter.y -= offsetTop;
                    this.alert.y -= offsetTop;
                    this.progressList.y -= offsetMiddle;
                    this.awards.y -= offsetMiddle;

                    // set bottom line
                    if (this.awards.height > 0)
                    {
                        this.lineMC.y = this.awards.y + this.awards.height;
                    }
                    else
                    {
                        this.lineMC.y -= offsetBottom;
                    }

                    // resize
                    setSize(this.width, Math.round(this.lineMC.y));
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }
    }
}
