package net.wg.gui.lobby.quests.components.renderers
{
    import net.wg.gui.components.controls.TableRenderer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskListRendererVO;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    
    public class QuestTaskListItemRenderer extends TableRenderer
    {
        
        public function QuestTaskListItemRenderer()
        {
            super();
        }
        
        public var mainLabel:TextField;
        
        public var taskChainProgress:TextField;
        
        public var taskStatus:TextField;
        
        public var taskStatusIcon:UILoaderAlt;
        
        public var arrow:UILoaderAlt;
        
        private var _rendererVO:QuestTaskListRendererVO;
        
        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            this._rendererVO = param1 as QuestTaskListRendererVO;
            if(param1 != null)
            {
                App.utils.asserter.assertNotNull(this._rendererVO,"data must be QuestTaskListRendererVO");
            }
            invalidateData();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.clearView();
                this.setView(this._rendererVO);
                this.updateDisable();
            }
            if(isInvalid(InvalidationType.STATE))
            {
                this.arrow.visible = (selected) && (this.isNotChain());
            }
        }
        
        private function isNotChain() : Boolean
        {
            return !(this._rendererVO == null) && !(this._rendererVO.type == QuestTaskListRendererVO.CHAIN);
        }
        
        override protected function updateDisable() : void
        {
            super.updateDisable();
            if(disableMc != null)
            {
                disableMc.visible = !enabled && (this.isNotChain());
            }
        }
        
        override protected function onDispose() : void
        {
            this.arrow.dispose();
            this.taskStatusIcon.dispose();
            if(this._rendererVO != null)
            {
                this._rendererVO.dispose();
            }
            this.mainLabel = null;
            this.taskChainProgress = null;
            this.taskStatus = null;
            this.arrow = null;
            this.taskStatusIcon = null;
            this._rendererVO = null;
            super.onDispose();
        }
        
        private function setView(param1:Object) : void
        {
            var _loc2_:* = false;
            if(this._rendererVO != null)
            {
                switch(this._rendererVO.type)
                {
                    case QuestTaskListRendererVO.STATISTICS:
                        this.mainLabel.htmlText = this._rendererVO.statData.label;
                        this.arrow.source = this._rendererVO.statData.arrowIconPath;
                        this.mainLabel.visible = true;
                        this.arrow.visible = true;
                        break;
                    case QuestTaskListRendererVO.CHAIN:
                        this.mainLabel.htmlText = this._rendererVO.chainData.name;
                        this.taskChainProgress.htmlText = this._rendererVO.chainData.progressText;
                        this.mainLabel.visible = true;
                        this.taskChainProgress.visible = true;
                        break;
                    case QuestTaskListRendererVO.TASK:
                        this.mainLabel.htmlText = this._rendererVO.taskData.name;
                        this.taskStatus.htmlText = this._rendererVO.taskData.stateName;
                        this.taskStatusIcon.source = this._rendererVO.taskData.stateIconPath;
                        this.arrow.source = this._rendererVO.taskData.arrowIconPath;
                        this.mainLabel.visible = true;
                        this.arrow.visible = true;
                        this.taskStatusIcon.visible = this.taskStatus.text.length > 0;
                        this.taskStatus.visible = true;
                        break;
                }
                _loc2_ = this.isNotChain();
                enabled = _loc2_;
                this.arrow.visible = _loc2_;
                if(rendererBg != null)
                {
                    rendererBg.visible = _loc2_;
                }
            }
        }
        
        private function clearView() : void
        {
            this.taskChainProgress.visible = false;
            this.taskStatus.visible = false;
            rendererBg.visible = false;
            this.mainLabel.visible = false;
            this.arrow.visible = false;
            this.taskStatusIcon.visible = false;
        }
        
        override public function set selected(param1:Boolean) : void
        {
            if((param1) && !selected)
            {
                App.toolTipMgr.hide();
            }
            super.selected = param1;
        }
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            if(!selected && !(this._rendererVO == null) && !(this._rendererVO.tooltip == null))
            {
                App.toolTipMgr.show(this._rendererVO.tooltip);
            }
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            App.toolTipMgr.hide();
        }
    }
}
