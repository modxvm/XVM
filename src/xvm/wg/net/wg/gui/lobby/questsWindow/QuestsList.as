package net.wg.gui.lobby.questsWindow 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.interfaces.*;
    
    public class QuestsList extends net.wg.gui.components.controls.ScrollingListEx
    {
        public function QuestsList()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.allQuestsDoneTF.text = QUESTS.QUESTS_LIST_COMPLETE;
            this.clickCheckboxTF.text = QUESTS.QUESTS_LIST_CLICKCHECKBOX;
            return;
        }

        protected override function drawLayout():void
        {
            var loc8:*=null;
            var loc1:*=_renderers.length;
            var loc2:*=rowHeight;
            var loc3:*=availableWidth - padding.horizontal;
            var loc4:*=margin + padding.left;
            var loc5:*=margin + padding.top;
            var loc6:*=isInvalid(scaleform.clik.constants.InvalidationType.DATA);
            var loc7:*=0;
            while (loc7 < loc1) 
            {
                (loc8 = getRendererAt(loc7)).x = Math.round(loc4);
                loc8.y = Math.round(loc5 + loc7 * loc2);
                if (!loc6) 
                    loc8.validateNow();
                ++loc7;
            }
            drawScrollBar();
            return;
        }

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            super.dataProvider = arg1;
            if (dataProvider && dataProvider.length > 0) 
            {
                this.allQuestsDoneTF.visible = false;
                this.clickCheckboxTF.visible = false;
            }
            else 
            {
                this.allQuestsDoneTF.visible = true;
                this.clickCheckboxTF.visible = true;
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        protected override function updateSelectedIndex():void
        {
            super.updateSelectedIndex();
            App.utils.focusHandler.setFocus(this);
            return;
        }

        public var allQuestsDoneTF:flash.text.TextField;

        public var clickCheckboxTF:flash.text.TextField;
    }
}
