package net.wg.gui.lobby.quests.components.renderers
{
    import net.wg.gui.components.controls.TableRenderer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskListRendererVO;
    import flash.utils.Dictionary;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTileStatisticsVO;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestChainVO;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskVO;
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
        
        public var arrow:UILoaderAlt;
        
        private var _rendererVO:QuestTaskListRendererVO;
        
        private var _stateSetters:Dictionary;
        
        override protected function configUI() : void
        {
            super.configUI();
            this._stateSetters = new Dictionary();
            this._stateSetters[QuestTaskListRendererVO.STATISTICS] = this.setStatisticsView;
            this._stateSetters[QuestTaskListRendererVO.CHAIN] = this.setChainView;
            this._stateSetters[QuestTaskListRendererVO.TASK] = this.setTaskView;
        }
        
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
                this.clear();
                this.setView(this._rendererVO);
                this.updateDisable();
            }
            if(isInvalid(InvalidationType.STATE))
            {
                this.arrow.visible = selected;
            }
        }
        
        override public function set selected(param1:Boolean) : void
        {
            if((param1) && !selected)
            {
                App.toolTipMgr.hide();
            }
            super.selected = param1;
        }
        
        override protected function updateDisable() : void
        {
            super.updateDisable();
            if(disableMc != null)
            {
                disableMc.visible = (_data) && !enabled && !(this._rendererVO.type == QuestTaskListRendererVO.CHAIN);
            }
        }
        
        private function setView(param1:Object) : void
        {
            var _loc2_:Function = null;
            var _loc3_:* = false;
            if(this._rendererVO != null)
            {
                _loc2_ = this._stateSetters[this._rendererVO.type] as Function;
                App.utils.asserter.assertNotNull(_loc2_,"Cant find view setter for type ");
                _loc2_(this._rendererVO.data);
                _loc3_ = !(this._rendererVO.type == QuestTaskListRendererVO.CHAIN);
                enabled = _loc3_;
                this.arrow.visible = _loc3_;
                if(rendererBg != null)
                {
                    rendererBg.visible = _loc3_;
                }
            }
        }
        
        private function setStatisticsView(param1:QuestTileStatisticsVO) : void
        {
            this.mainLabel.htmlText = param1.label;
            this.arrow.source = param1.arrowIconPath;
        }
        
        private function setChainView(param1:QuestChainVO) : void
        {
            this.mainLabel.htmlText = param1.name;
            this.taskChainProgress.htmlText = param1.progressText;
        }
        
        private function setTaskView(param1:QuestTaskVO) : void
        {
            this.mainLabel.htmlText = param1.name;
            this.taskStatus.htmlText = param1.stateName;
            this.arrow.source = param1.arrowIconPath;
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
        
        private function clear() : void
        {
            this.mainLabel.htmlText = "";
            this.taskChainProgress.htmlText = "";
            this.taskStatus.htmlText = "";
            this.arrow.unload();
            rendererBg.visible = false;
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:* = undefined;
            this.arrow.dispose();
            if(this._rendererVO != null)
            {
                this._rendererVO.dispose();
            }
            this.mainLabel = null;
            this.taskChainProgress = null;
            this.taskStatus = null;
            this.arrow = null;
            this._rendererVO = null;
            if(this._stateSetters)
            {
                for(_loc1_ in this._stateSetters)
                {
                    delete this._stateSetters[_loc1_];
                    true;
                }
                this._stateSetters = null;
            }
            super.onDispose();
        }
    }
}
