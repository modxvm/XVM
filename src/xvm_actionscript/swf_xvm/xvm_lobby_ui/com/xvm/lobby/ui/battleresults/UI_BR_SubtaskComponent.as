/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author Pavel Máca
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.battleresults
{
    import com.xfw.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.VO.*;
    import net.wg.gui.lobby.questsWindow.*;
    import scaleform.clik.constants.*;

    public class UI_BR_SubtaskComponent extends BR_SubtaskComponent_UI
    {
        private var orig_taskTF_y:Number = NaN;
        private var orig_linkBtn_y:Number = NaN;
        private var orig_statusMC_y:Number = NaN;
        private var orig_counter_y:Number = NaN;
        private var orig_alert_y:Number = NaN;
        private var orig_progressList_y:Number = NaN;
        private var orig_awards_y:Number = NaN;

        private var _data:BattleResultsQuestVO = null;

        private const offsetTop:Number = 10;
        private const offsetMiddle:Number = 20;

        public function UI_BR_SubtaskComponent()
        {
            //Logger.add("UI_BR_SubtaskComponent");
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

        override protected function onDispose() : void
        {
            if (this._data)
            {
                this._data.dispose();
                this._data = null;
            }
        }

        override protected function draw():void
        {
            super.draw();
            //return;

            if (isInvalid(InvalidationType.DATA))
            {
                if (this._data != null)
                {
                    if (isNaN(orig_taskTF_y))
                    {
                        orig_taskTF_y = this.taskTF.y;
                        orig_linkBtn_y = this.linkBtn.y;
                        orig_statusMC_y = this.statusMC.y;
                        orig_counter_y = this.counter.y;
                        orig_alert_y = this.alert.y;
                        orig_progressList_y = this.progressList.y;
                        orig_awards_y = this.awards.y;
                    }

                    // move elements up
                    this.taskTF.y = orig_taskTF_y - offsetTop;
                    this.linkBtn.y = orig_linkBtn_y - offsetTop;
                    this.statusMC.y = orig_statusMC_y - offsetTop;
                    this.counter.y = orig_counter_y - offsetTop;
                    this.alert.y = orig_alert_y - offsetTop;
                    this.progressList.y = orig_progressList_y - offsetMiddle;
                    this.awards.y = orig_awards_y - offsetMiddle;

                    // set bottom line
                    if (_data.awards && _data.awards.length)
                    {
                        this.lineMC.y = this.awards.y + this.awards.height;
                    }
                    else
                    {
                        this.lineMC.y = this.progressList.y + this.progressList.height;
                    }

                    // resize
                    setSize(this.width, this.lineMC.y);
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }

        override public function setData(value:Object):void
        {
            if (value != null)
            {
                this._data = new BattleResultsQuestVO(value);
            }
            super.setData(value);
        }
    }
}
