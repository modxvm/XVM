package net.wg.gui.tutorial.windows 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.tutorial.controls.*;
    
    public class TutorialGreetingDialog extends net.wg.gui.tutorial.windows.TutorialDialog
    {
        public function TutorialGreetingDialog()
        {
            super();
            canClose = false;
            canDrag = false;
            isModal = true;
            return;
        }

        protected override function drawData():void
        {
            super.drawData();
            this.imageLoader.source = _data.imageUrl;
            messageField.htmlText = _data.message;
            this.timeField.htmlText = _data.timeNoteValue;
            this.updateBonuses();
            return;
        }

        internal function updateBonuses():void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*=_data ? _data.bonuses : null;
            if (this.bonusItem && loc1) 
            {
                loc2 = 0;
                loc3 = 0;
                loc4 = 0;
                while (loc4 < loc1.length) 
                {
                    loc5 = loc1[loc4];
                    if (!Boolean(loc5.received)) 
                    {
                        if ((loc6 = loc5.values).credits) 
                        {
                            loc2 = loc2 + Number(loc6.credits);
                        }
                        if (loc6.freeXP) 
                        {
                            loc3 = loc3 + Number(loc6.freeXP);
                        }
                    }
                    ++loc4;
                }
                this.bonusItem.setBonuses(loc2, loc3);
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.restartHintField.text = App.utils.locale.makeString(BATTLE_TUTORIAL.DIALOGS_GREETING_RESTART_HINT_TEXT);
            App.utils.focusHandler.setFocus(submitBtn);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.useBottomBtns = true;
            window.title = BATTLE_TUTORIAL.DIALOGS_GREETING_TITLE;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.imageLoader.dispose();
            return;
        }

        public var imageLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var bonusItem:net.wg.gui.tutorial.controls.BattleBonusItem;

        public var timeField:flash.text.TextField;

        public var restartHintField:flash.text.TextField;
    }
}
