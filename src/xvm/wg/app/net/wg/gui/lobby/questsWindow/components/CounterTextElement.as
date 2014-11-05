package net.wg.gui.lobby.questsWindow.components
{
    import net.wg.gui.components.controls.achievements.RedCounter;
    import flash.text.TextField;
    import net.wg.gui.lobby.questsWindow.data.CounterTextElementVO;
    import net.wg.data.constants.QuestsStates;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    
    public class CounterTextElement extends AbstractResizableContent
    {
        
        public function CounterTextElement()
        {
            super();
        }
        
        public static var DEFAULT_WIDTH:int = 270;
        
        public var description:QuestsDashlineItem;
        
        public var counter:RedCounter;
        
        public var battlesLeftTF:TextField;
        
        protected var data:CounterTextElementVO = null;
        
        public var statusMC:QuestStatusComponent;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.battlesLeftTF.text = QUESTS.QUESTS_TABLE_BATTLESLEFT;
            this.counter.visible = this.battlesLeftTF.visible = false;
            this.statusMC.setStatus(QuestsStates.DONE);
            this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
            this.statusMC.showTooltip = false;
            this.statusMC.validateNow();
            this.statusMC.visible = false;
        }
        
        override protected function onDispose() : void
        {
            this.description.dispose();
            this.description = null;
            this.counter.dispose();
            this.counter = null;
            this.statusMC.dispose();
            this.statusMC = null;
            this.battlesLeftTF = null;
            if(this.data)
            {
                this.data.dispose();
                this.data = null;
            }
            super.onDispose();
        }
        
        override public function setData(param1:Object) : void
        {
            this.data = new CounterTextElementVO(param1);
            invalidateData();
        }
        
        override protected function draw() : void
        {
            if((isInvalid(InvalidationType.DATA)) && (this.data))
            {
                this.description.visible = true;
                this.counter.visible = this.battlesLeftTF.visible = (this.data.battlesLeft) && !this.data.showDone;
                this.counter.text = this.data.battlesLeft.toString();
                this.description.width = (this.data.battlesLeft) || (this.data.showDone)?DEFAULT_WIDTH:availableWidth;
                this.description.label = this.data.label;
                this.description.value = this.data.value;
                this.description.linkID = this.data.linkID;
                this.description.fullLblData = this.data.fullLabel;
                this.description.isNotAvailable = this.data.isNotAvailable;
                this.statusMC.visible = this.data.showDone;
                this.description.validateNow();
                this.layoutBlocks();
            }
        }
        
        protected function layoutBlocks() : void
        {
            var _loc1_:Number = this.data.label?Math.round(this.description.height):0;
            var _loc2_:Number = Boolean(this.data.battlesLeft > 0)?Math.round(this.counter.height + this.counter.y):0;
            var _loc3_:Number = Math.max(_loc1_,_loc2_);
            setSize(this.width,_loc3_);
            isReadyForLayout = true;
        }
    }
}
