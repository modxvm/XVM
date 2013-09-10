package net.wg.gui.tutorial.windows 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.tutorial.constants.*;
    import net.wg.gui.tutorial.controls.*;
    import net.wg.gui.tutorial.meta.*;
    import net.wg.gui.tutorial.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class TutorialBattleStatisticWindow extends net.wg.gui.tutorial.meta.impl.TutorialBattleStatisticMeta implements net.wg.gui.tutorial.meta.ITutorialBattleStatisticMeta
    {
        public function TutorialBattleStatisticWindow()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.column1Header.text = App.utils.locale.makeString(BATTLE_TUTORIAL.WINDOWS_RESULT_TABLE_COLUMN_1);
            this.column2Header.text = App.utils.locale.makeString(BATTLE_TUTORIAL.WINDOWS_RESULT_TABLE_COLUMN_2);
            this.restartButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onRestartButtonClick);
            this.battleHintList.addEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.onHintItemClick);
            return;
        }

        internal function onRestartButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            restartS();
            return;
        }

        internal function onHintItemClick(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=arg1.itemData;
            if (loc1.type == net.wg.gui.tutorial.constants.HintItemType.VIDEO_LINK) 
            {
                showVideoDialogS();
            }
            return;
        }

        public function as_setData(arg1:Object):void
        {
            this.data = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this.data) 
            {
                this.imageLoader.source = this.data.imageUrl;
                this.showBonuses(this.data.chapters);
                this.totalResultField.htmlText = this.data.totalResult;
                this.finishReasonField.htmlText = this.data.finishReason;
                this.battleHintList.dataProvider = this.data.battleHints;
                this.chaptersList.dataProvider = new scaleform.clik.data.DataProvider(this.data.chapters);
                this.progressBar.populateUI(this.data.lastChapter, this.data.totalChapters);
                this.progressBar.setPhases(this.data.progressMask);
                this.restartHintField.htmlText = this.data.restartHint;
                this.restartHintField.visible = !this.data.finished;
                this.restartButton.visible = !this.data.finished;
            }
            return;
        }

        internal function showBonuses(arg1:Array):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=arg1.length;
            var loc6:*=0;
            while (loc6 < loc3) 
            {
                if ((loc4 = arg1[loc6]).received) 
                {
                    if ((loc5 = loc4.bonus).credits) 
                    {
                        loc1 = loc1 + Number(loc5.credits);
                    }
                    if (loc5.freeXP) 
                    {
                        loc2 = loc2 + Number(loc5.freeXP);
                    }
                }
                ++loc6;
            }
            if (!(this.creditsCounter == null) && loc1 >= 0) 
            {
                loc7 = App.utils.locale.integer(loc1);
                loc8 = App.utils.locale.parseFormattedInteger(loc7);
                this.creditsCounter.formattedNumber = loc7;
                this.creditsCounter.localizationSymbol = loc8.delimiter;
                this.creditsCounter.playAnim = true;
                this.creditsCounter.number = loc1;
                var loc11:*;
                this.creditsCounter.x = loc11 = Math.round(this.bonusReceivedField.width + this.creditsCounter.expectedWidth >> 1) - ICON_OFFSET;
                this.creditsIcon.x = loc11;
            }
            else 
            {
                this.creditsCounter.visible = false;
                this.creditsIcon.visible = false;
            }
            if (!(this.creditsCounter == null) && loc2 >= 0) 
            {
                loc9 = App.utils.locale.integer(loc2);
                loc10 = App.utils.locale.parseFormattedInteger(loc9);
                this.xpCounter.formattedNumber = loc9;
                this.xpCounter.localizationSymbol = loc10.delimiter;
                this.xpCounter.playAnim = true;
                this.xpCounter.number = loc2;
                this.xpCounter.x = loc11 = Math.round(this.bonusReceivedField.width + this.xpCounter.expectedWidth >> 1) - ICON_OFFSET;
                this.xpIcon.x = loc11;
            }
            else 
            {
                this.xpCounter.visible = false;
                this.xpIcon.visible = false;
            }
            if (this.data.areAllBonusesReceived && loc1 <= 0 && loc2 <= 0) 
            {
                this.xpIcon.visible = loc11 = false;
                this.xpCounter.visible = loc11;
                this.creditsIcon.visible = loc11 = false;
                this.creditsCounter.visible = loc11;
                this.bonusReceivedField.text = App.utils.locale.makeString(BATTLE_TUTORIAL.LABELS_BONUSES_ALREADY_RECEIVED);
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.useBottomBtns = false;
            window.title = BATTLE_TUTORIAL.WINDOWS_RESULT_TITLE;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.data = null;
            this.restartButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onRestartButtonClick);
            this.battleHintList.removeEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.onHintItemClick);
            return;
        }

        internal static const ICON_OFFSET:Number=17;

        public var totalResultField:flash.text.TextField;

        public var finishReasonField:flash.text.TextField;

        public var bonusReceivedField:flash.text.TextField;

        public var creditsCounter:net.wg.gui.components.advanced.CounterEx;

        public var creditsIcon:flash.display.Sprite;

        public var xpCounter:net.wg.gui.components.advanced.CounterEx;

        public var xpIcon:flash.display.Sprite;

        public var imageLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var column1Header:flash.text.TextField;

        public var column2Header:flash.text.TextField;

        public var battleHintList:net.wg.gui.tutorial.controls.HintList;

        public var chaptersList:net.wg.gui.components.controls.ScrollingListEx;

        public var progressBar:net.wg.gui.tutorial.controls.FinalStatisticProgress;

        public var restartHintField:flash.text.TextField;

        public var restartButton:net.wg.gui.components.controls.SoundButtonEx;

        protected var data:Object;
    }
}
