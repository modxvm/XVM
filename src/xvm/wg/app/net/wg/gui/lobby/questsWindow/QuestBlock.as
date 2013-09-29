package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import scaleform.clik.core.*;
    
    public class QuestBlock extends scaleform.clik.core.UIComponent
    {
        public function QuestBlock()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.header.addEventListener(flash.events.Event.RESIZE, this.layoutBlocks);
            this.infoBlock.addEventListener(flash.events.Event.RESIZE, this.layoutBlocks);
            this.awards.addEventListener(flash.events.Event.RESIZE, this.layoutBlocks);
            return;
        }

        public function setData(arg1:Object):void
        {
            var loc1:*=null;
            loc1 = new net.wg.gui.lobby.questsWindow.data.QuestDataVO(arg1);
            this._showAwards = Boolean(loc1.award);
            this._showNextTasks = Boolean(loc1.nextTasks.length);
            this.header.setData(loc1.header);
            this.infoBlock.setData(loc1.info);
            this.awards.setAwards(loc1.award);
            this.awards.visible = this._showAwards;
            this.nextTasksList.setData(loc1.nextTasks);
            this.nextTasksList.validateNow();
            return;
        }

        internal function layoutBlocks(arg1:flash.events.Event):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc5:*=NaN;
            loc1 = this.header.height;
            loc2 = this.infoBlock.height;
            var loc3:*=this._showAwards ? this.awards.height - AWARDS_TOP_PADDING : 0;
            var loc4:*=this._showNextTasks ? this.nextTasksList.height : 0;
            loc5 = loc2 + loc3 + loc4;
            this.bg.y = loc1;
            this.infoBlock.y = Math.round(loc1);
            this.awards.y = loc1 + loc2 - AWARDS_TOP_PADDING;
            this.nextTasksList.y = loc1 + loc2 + loc3;
            this.bg.height = loc5;
            this.bottomBg.y = this.bg.y + loc5 - 2;
            this.awards.visible = this._showAwards;
            this.nextTasksList.visible = this._showNextTasks;
            var loc6:*=loc1 + loc5 + this.bottomBg.height;
            setSize(this.width, loc6);
            dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
            return;
        }

        public override function dispose():void
        {
            this.header.removeEventListener(flash.events.Event.RESIZE, this.layoutBlocks);
            this.infoBlock.removeEventListener(flash.events.Event.RESIZE, this.layoutBlocks);
            this.awards.removeEventListener(flash.events.Event.RESIZE, this.layoutBlocks);
            this.header.dispose();
            this.infoBlock.dispose();
            this.awards.dispose();
            this.nextTasksList.dispose();
            super.dispose();
            return;
        }

        internal static const AWARDS_TOP_PADDING:int=13;

        public var header:net.wg.gui.lobby.questsWindow.HeaderBlock;

        public var infoBlock:net.wg.gui.lobby.questsWindow.MiddleInfoBlock;

        public var awards:net.wg.gui.lobby.questsWindow.QuestAwardsBlock;

        public var bg:flash.display.MovieClip;

        public var bottomBg:flash.display.MovieClip;

        internal var _showAwards:Boolean=false;

        internal var _showNextTasks:Boolean=false;

        public var nextTasksList:net.wg.gui.lobby.questsWindow.SubtasksList;
    }
}
