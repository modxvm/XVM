package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.profile.components.AdvancedLineDescrIconText;
    import net.wg.gui.components.common.containers.GroupEx;
    import net.wg.gui.lobby.fortifications.data.ClanStatsVO;
    import net.wg.gui.components.common.containers.Group;
    import net.wg.gui.components.common.containers.VerticalGroupLayout;
    import scaleform.clik.constants.InvalidationType;
    
    public class FortClanStatisticBaseForm extends UIComponent
    {
        
        public function FortClanStatisticBaseForm()
        {
            super();
            alpha = 0;
        }
        
        private static var STATS_GROUP_WIDTH:Number = 580;
        
        private static var ICON_STATS_WIDTH_CORRECTION:Number = 3;
        
        public var battlesField:AdvancedLineDescrIconText;
        
        public var winsField:AdvancedLineDescrIconText;
        
        public var avgDefresField:AdvancedLineDescrIconText;
        
        public var battlesStatsGroup:GroupEx;
        
        public var defresStatsGroup:ClanStatsGroup;
        
        private var _model:ClanStatsVO;
        
        private var mainGroup:Group;
        
        private var isDataInitialized:Boolean = false;
        
        public function get model() : ClanStatsVO
        {
            return this._model;
        }
        
        public function set model(param1:ClanStatsVO) : void
        {
            this._model = param1;
            invalidateData();
        }
        
        override protected function onDispose() : void
        {
            this.battlesField.dispose();
            this.battlesField = null;
            this.winsField.dispose();
            this.winsField = null;
            this.avgDefresField.dispose();
            this.avgDefresField = null;
            if(this.mainGroup)
            {
                this.mainGroup.dispose();
                this.mainGroup = null;
            }
            this.battlesStatsGroup = null;
            this.defresStatsGroup = null;
            if(this._model != null)
            {
                this._model.dispose();
                this._model = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            var _loc1_:VerticalGroupLayout = null;
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._model))
            {
                if(!this.isDataInitialized)
                {
                    this.isDataInitialized = true;
                    alpha = 1;
                    this.mainGroup = new Group();
                    _loc1_ = new VerticalGroupLayout();
                    _loc1_.gap = 30;
                    this.mainGroup.layout = _loc1_;
                    addChild(this.mainGroup);
                    this.mainGroup.y = this.battlesStatsGroup.y;
                    this.mainGroup.addChild(this.battlesStatsGroup);
                    this.mainGroup.addChild(this.defresStatsGroup);
                    this.battlesStatsGroup.width = STATS_GROUP_WIDTH;
                    this.defresStatsGroup.width = STATS_GROUP_WIDTH + ICON_STATS_WIDTH_CORRECTION;
                    this.defresStatsGroup.verticalPadding = ClanStatsGroup.DEFRES_STATS_PADDING;
                }
                this.applyData();
            }
        }
        
        protected function applyData() : void
        {
            this.defresStatsGroup.validateNow();
            this.battlesStatsGroup.validateNow();
            this.mainGroup.validateNow();
        }
    }
}
