package net.wg.gui.lobby.questsWindow 
{
    import flash.events.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class MiddleInfoBlock extends scaleform.clik.core.UIComponent
    {
        public function MiddleInfoBlock()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.description.visible = false;
            this.description.mouseChildren = false;
            this.description.mouseEnabled = false;
            return;
        }

        public override function dispose():void
        {
            if (this.description) 
            {
                this.description.dispose();
                this.description = null;
            }
            if (this.subtasksList) 
            {
                this.subtasksList.dispose();
                this.subtasksList = null;
            }
            if (this.conditions) 
            {
                this.conditions.dispose();
                this.conditions = null;
            }
            if (this.infoData) 
            {
                this.infoData.dispose();
                this.infoData = null;
            }
            super.dispose();
            return;
        }

        public function setData(arg1:net.wg.gui.lobby.questsWindow.data.InfoDataVO):void
        {
            this.infoData = arg1;
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                loc1 = 0;
                if (this.infoData) 
                {
                    this.setDescription();
                    this.setSubtasks();
                    this.setCondition();
                    loc1 = this.descrHeight + this.subtasksHeight + this.conditionsHeight;
                }
                setSize(this.width, loc1);
                dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
            }
            return;
        }

        internal function setCondition():void
        {
            this.conditions.y = this.descrHeight + this.subtasksHeight;
            if (this.infoData.conditions) 
            {
                this.conditions.setData(this.infoData.conditions);
                this.conditions.validateNow();
                this.conditions.visible = true;
                this.conditionsHeight = Math.round(this.conditions.height);
            }
            else 
            {
                this.conditionsHeight = 0;
                this.conditions.visible = false;
            }
            return;
        }

        internal function setSubtasks():void
        {
            this.subtasksList.y = this.descrHeight;
            if (this.infoData.subtasks) 
            {
                this.subtasksList.setData(this.infoData.subtasks);
                this.subtasksList.validateNow();
                this.subtasksList.visible = true;
                this.subtasksHeight = Math.round(this.subtasksList.height);
            }
            else 
            {
                this.subtasksList.visible = false;
                this.subtasksHeight = 0;
            }
            return;
        }

        internal function setDescription():void
        {
            var loc1:*=null;
            if (this.infoData.descr) 
            {
                loc1 = this.infoData.descr;
                this.description.setLabels(loc1.title, loc1.descr);
                this.description.validateNow();
                this.description.visible = true;
                this.descrHeight = Math.round(this.description.height);
            }
            else 
            {
                this.description.visible = false;
                this.descrHeight = 0;
            }
            return;
        }

        public var description:net.wg.gui.lobby.questsWindow.DescriptionBlock;

        public var subtasksList:net.wg.gui.lobby.questsWindow.SubtasksList;

        public var conditions:net.wg.gui.lobby.questsWindow.ConditionsComponent;

        public var infoData:net.wg.gui.lobby.questsWindow.data.InfoDataVO=null;

        internal var descrHeight:Number=0;

        internal var subtasksHeight:Number=0;

        internal var conditionsHeight:Number=0;
    }
}
