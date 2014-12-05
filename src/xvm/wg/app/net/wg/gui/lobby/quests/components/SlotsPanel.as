package net.wg.gui.lobby.quests.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.quests.data.QuestSlotVO;
    
    public class SlotsPanel extends UIComponentEx
    {
        
        public function SlotsPanel()
        {
            super();
            this._slotRenderers = [this.slot0,this.slot1,this.slot2,this.slot3,this.slot4];
            this.slot4.showSeparator = false;
            this.noDataTF.visible = false;
        }
        
        public var noDataTF:TextField;
        
        public var slot0:QuestSlotRenderer;
        
        public var slot1:QuestSlotRenderer;
        
        public var slot2:QuestSlotRenderer;
        
        public var slot3:QuestSlotRenderer;
        
        public var slot4:QuestSlotRenderer;
        
        private var _slotRenderers:Array;
        
        private var _dataProvider:Array;
        
        public function get dataProvider() : Array
        {
            return this._dataProvider;
        }
        
        public function set dataProvider(param1:Array) : void
        {
            this._dataProvider = param1;
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.noDataTF.htmlText = QUESTS.PERSONAL_SEASONS_SLOTS_NOACTIVESLOTS;
        }
        
        override protected function onDispose() : void
        {
            this.noDataTF = null;
            this.disposeSlots();
            if(this._dataProvider)
            {
                this._dataProvider.splice(0);
                this._dataProvider = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._dataProvider))
            {
                this.updateSlotsData();
            }
        }
        
        private function showHideSlots(param1:Boolean) : void
        {
            var _loc2_:QuestSlotRenderer = null;
            for each(_loc2_ in this._slotRenderers)
            {
                _loc2_.visible = param1;
            }
        }
        
        private function disposeSlots() : void
        {
            var _loc1_:QuestSlotRenderer = null;
            for each(_loc1_ in this._slotRenderers)
            {
                _loc1_.dispose();
                _loc1_ = null;
            }
            this._slotRenderers.splice(0);
            this._slotRenderers = null;
        }
        
        private function updateSlotsData() : void
        {
            var _loc1_:QuestSlotRenderer = null;
            var _loc2_:QuestSlotVO = null;
            var _loc3_:* = false;
            var _loc4_:* = 0;
            while(_loc4_ < this._dataProvider.length)
            {
                _loc2_ = this._dataProvider[_loc4_];
                if(!_loc3_ && !_loc2_.isEmpty)
                {
                    _loc3_ = true;
                }
                _loc1_ = this._slotRenderers[_loc4_];
                _loc1_.model = _loc2_;
                _loc4_++;
            }
            this.showHideSlots(_loc3_);
            this.noDataTF.visible = !_loc3_;
        }
    }
}
