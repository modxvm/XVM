package net.wg.gui.lobby.profile.pages.statistics.header
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.icons.BattleTypeIcon;
    import net.wg.gui.components.common.containers.GroupEx;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticsTooltipDataVO;
    import net.wg.data.managers.impl.ToolTipParams;
    import net.wg.gui.components.common.containers.HorizontalGroupLayout;
    import net.wg.data.constants.Linkages;
    
    public class HeaderContainer extends UIComponent implements IDisposable
    {
        
        public function HeaderContainer()
        {
            super();
            this.group.layout = new HorizontalGroupLayout();
            this.group.itemRendererClass = App.utils.classFactory.getClass(Linkages.ADVANCED_LINE_DESCR_ICON_TEXT_UI);
        }
        
        public var icon:BattleTypeIcon;
        
        public var group:GroupEx;
        
        public var image:HeaderBGImage;
        
        public function setDossierData(param1:Array) : void
        {
            var _loc3_:StatisticsHeaderVO = null;
            var _loc5_:Object = null;
            var _loc6_:String = null;
            var _loc7_:Object = null;
            var _loc8_:StatisticsTooltipDataVO = null;
            var _loc2_:Array = [];
            var _loc4_:* = 0;
            while(_loc4_ < param1.length)
            {
                _loc5_ = param1[_loc4_];
                _loc3_ = new StatisticsHeaderVO(_loc5_);
                _loc6_ = _loc3_.type;
                _loc7_ = _loc3_.additionalData;
                switch(_loc6_)
                {
                    case HeaderItemsTypes.TOOL_TIP_VALUES:
                        _loc8_ = new StatisticsTooltipDataVO(_loc7_.tooltipData);
                        _loc3_.toolTipParams = new ToolTipParams(_loc8_.header,_loc8_.body,_loc8_.note);
                        break;
                    case HeaderItemsTypes.RATIO:
                        if(_loc3_.text != "-1")
                        {
                            _loc3_.text = _loc3_.text + "<font size=\'14\' color=\'#939188\'>" + "/" + App.utils.locale.integer(_loc7_.total) + "</font>";
                        }
                        break;
                }
                _loc2_.push(_loc3_);
                _loc4_++;
            }
            this.group.dataProvider = _loc2_;
        }
        
        public function set battlesType(param1:String) : void
        {
            var _loc2_:String = null;
            if(param1 == PROFILE.PROFILE_DROPDOWN_LABELS_ALL)
            {
                _loc2_ = "random";
                this.image.gotoAndStop(1);
            }
            else if(param1 == PROFILE.PROFILE_DROPDOWN_LABELS_TEAM)
            {
                _loc2_ = "team7x7";
                this.image.gotoAndStop(2);
            }
            else if(param1 == PROFILE.PROFILE_DROPDOWN_LABELS_HISTORICAL)
            {
                _loc2_ = "historical";
                this.image.gotoAndStop(3);
            }
            else if(param1 == PROFILE.PROFILE_DROPDOWN_LABELS_FORTIFICATIONS)
            {
                _loc2_ = "fortifications";
                this.image.gotoAndStop(4);
            }
            else
            {
                throw new Error(this + " :: Unknown battle type: " + param1);
            }
            
            
            
            this.icon.type = _loc2_;
        }
        
        override protected function onDispose() : void
        {
            this.icon.dispose();
            this.icon = null;
            this.group.dispose();
            this.group = null;
            this.image = null;
            super.onDispose();
        }
    }
}
