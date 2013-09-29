package net.wg.gui.lobby.training 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.utils.*;
    
    public class TrainingListItemRenderer extends scaleform.clik.controls.ListItemRenderer
    {
        public function TrainingListItemRenderer()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            focusTarget = owner;
            constraints.addElement("textComment", this.textComment, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("textArena", this.textArena, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("textCount", this.textCount, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("textOwner", this.textOwner, scaleform.clik.utils.Constraints.RIGHT);
            this.iconLoader.hideLoader = true;
            this.addEventListener(flash.events.MouseEvent.CLICK, this.onSelectItem);
            return;
        }

        public override function setData(arg1:Object):void
        {
            this.data = arg1;
            this.itemClicked = false;
            if (arg1) 
            {
                this.dataVO = new net.wg.data.VO.TrainingFormRendererVO(arg1);
            }
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        public override function dispose():void
        {
            this.removeEventListener(flash.events.MouseEvent.CLICK, this.onSelectItem);
            this.iconLoader.dispose();
            this.iconLoader = null;
            this.textOwner.dispose();
            this.textOwner = null;
            this.textArena = null;
            this.textComment = null;
            this.textCount = null;
            if (this.dataVO) 
            {
                this.dataVO.dispose();
                this.dataVO = null;
            }
            data = null;
            super.dispose();
            return;
        }

        public function onSelectItem(arg1:flash.events.MouseEvent):void
        {
            this.itemClicked = true;
            this.enabled = false;
            dispatchEvent(new net.wg.gui.events.TrainingEvent(net.wg.gui.events.TrainingEvent.OPEN_TRAINING_ROOM, {"id":this.dataVO.id}));
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && data) 
            {
                this.visible = true;
                this.textComment.text = this.dataVO.comment;
                this.textArena.text = this.dataVO.arena;
                this.textCount.text = this.dataVO.count + "/" + 2 * this.dataVO.total;
                this.textOwner.label = this.dataVO.owner;
                this.iconLoader.visible = true;
                if (this.iconLoader.source != this.dataVO.icon) 
                {
                    this.iconLoader.source = this.dataVO.icon;
                }
                this.enabled = !(this.dataVO.disabled || this.itemClicked);
            }
            return;
        }

        public var iconLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var textOwner:net.wg.gui.components.controls.TextFieldShort;

        public var textArena:flash.text.TextField;

        public var textComment:flash.text.TextField;

        public var textCount:flash.text.TextField;

        internal var itemClicked:Boolean=false;

        internal var dataVO:net.wg.data.VO.TrainingFormRendererVO;
    }
}
