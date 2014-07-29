package net.wg.gui.lobby.training
{
    import scaleform.clik.controls.ListItemRenderer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.data.VO.TrainingFormRendererVO;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.events.TrainingEvent;
    
    public class TrainingListItemRenderer extends ListItemRenderer
    {
        
        public function TrainingListItemRenderer()
        {
            super();
        }
        
        public var iconLoader:UILoaderAlt;
        
        public var textOwner:TextField;
        
        public var textArena:TextField;
        
        public var textComment:TextField;
        
        public var textCount:TextField;
        
        private var itemClicked:Boolean = false;
        
        private var dataVO:TrainingFormRendererVO;
        
        override protected function configUI() : void
        {
            super.configUI();
            focusTarget = owner;
            constraints.addElement("textComment",this.textComment,Constraints.ALL);
            constraints.addElement("textArena",this.textArena,Constraints.ALL);
            constraints.addElement("textCount",this.textCount,Constraints.RIGHT);
            constraints.addElement("textOwner",this.textOwner,Constraints.RIGHT);
            this.iconLoader.hideLoader = true;
            this.addEventListener(ButtonEvent.CLICK,this.onSelectItem);
        }
        
        override public function setData(param1:Object) : void
        {
            this.data = param1;
            this.itemClicked = false;
            if(param1)
            {
                this.dataVO = new TrainingFormRendererVO(param1);
            }
            invalidate(InvalidationType.DATA);
        }
        
        override protected function onDispose() : void
        {
            this.removeEventListener(ButtonEvent.CLICK,this.onSelectItem);
            this.iconLoader.dispose();
            this.iconLoader = null;
            this.textOwner = null;
            this.textArena = null;
            this.textComment = null;
            this.textCount = null;
            if(this.dataVO)
            {
                this.dataVO.dispose();
                this.dataVO = null;
            }
            data = null;
            super.onDispose();
        }
        
        public function onSelectItem(param1:ButtonEvent) : void
        {
            this.itemClicked = true;
            this.enabled = false;
            dispatchEvent(new TrainingEvent(TrainingEvent.OPEN_TRAINING_ROOM,{"id":this.dataVO.id}));
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (data))
            {
                this.visible = true;
                this.textComment.text = this.dataVO.comment;
                this.textArena.text = this.dataVO.arena;
                this.textCount.text = this.dataVO.count + "/" + 2 * this.dataVO.total;
                App.utils.commons.formatPlayerName(this.textOwner,App.utils.commons.getUserProps(this.dataVO.creatorName,this.dataVO.creatorClan,this.dataVO.creatorRegion,this.dataVO.creatorIgrType));
                this.iconLoader.visible = true;
                if(this.iconLoader.source != this.dataVO.icon)
                {
                    this.iconLoader.source = this.dataVO.icon;
                }
                constraints.update(_width,_height);
                this.enabled = !((this.dataVO.disabled) || (this.itemClicked));
            }
        }
    }
}
