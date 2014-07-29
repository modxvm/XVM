package net.wg.gui.lobby.profile.pages.statistics
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.profile.components.LditBattles;
    import net.wg.gui.components.advanced.LineDescrIconText;
    import net.wg.gui.lobby.profile.components.LditValued;
    import net.wg.gui.lobby.profile.components.LditMarksOfMastery;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    
    public class TfContainer extends UIComponent implements IDisposable
    {
        
        public function TfContainer()
        {
            super();
            addEventListener(Event.RESIZE,this.resizeComponentsHandler,false,0,true);
        }
        
        public static var LAYOUT_INVALID:String = "layoutInv";
        
        public var icon:UILoaderAlt;
        
        public var tfTotalBattles:LditBattles;
        
        public var tfWins:LineDescrIconText;
        
        public var tfSurvival:LineDescrIconText;
        
        public var tfHits:LineDescrIconText;
        
        public var tfAvgExperience:LineDescrIconText;
        
        public var tfMaxExperience:LditValued;
        
        public var tfMarksOfMastery:LditMarksOfMastery;
        
        private function resizeComponentsHandler(param1:Event) : void
        {
            param1.stopImmediatePropagation();
            invalidate(LAYOUT_INVALID);
        }
        
        override protected function draw() : void
        {
            var _loc1_:Vector.<UIComponent> = null;
            var _loc2_:* = NaN;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:UIComponent = null;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            super.draw();
            if(isInvalid(LAYOUT_INVALID,InvalidationType.SIZE))
            {
                _loc1_ = new Vector.<UIComponent>();
                _loc1_.push(this.tfTotalBattles);
                _loc1_.push(this.tfWins);
                _loc1_.push(this.tfHits);
                _loc1_.push(this.tfAvgExperience);
                _loc1_.push(this.tfMaxExperience);
                _loc1_.push(this.tfSurvival);
                _loc1_.push(this.tfMarksOfMastery);
                _loc2_ = 0;
                _loc3_ = _loc1_.length;
                _loc4_ = 0;
                while(_loc4_ < _loc3_)
                {
                    _loc5_ = _loc1_[_loc4_];
                    if(_loc5_)
                    {
                        _loc2_ = _loc2_ + _loc5_.width;
                    }
                    _loc4_++;
                }
                _loc6_ = (_width - _loc2_) / (_loc3_ + 1);
                _loc7_ = _loc6_;
                _loc4_ = 0;
                while(_loc4_ < _loc3_)
                {
                    _loc5_ = _loc1_[_loc4_];
                    if(_loc5_)
                    {
                        _loc5_.x = _loc7_;
                        _loc7_ = _loc7_ + (_loc5_.width + _loc6_);
                    }
                    _loc4_++;
                }
            }
        }
        
        public function setDossierData(param1:Object) : void
        {
            var _loc2_:ProfileStatisticsVO = new ProfileStatisticsVO(param1);
            this.tfTotalBattles.text = _loc2_.getBattlesCountStr();
            this.tfTotalBattles.setValues(_loc2_.getWinsCountStr(),_loc2_.getLossesCountStr(),_loc2_.getDrawsCountStr());
            this.tfWins.text = _loc2_.getWinsEfficiencyStr() + "%";
            this.tfSurvival.text = _loc2_.getSurvivalEfficiencyStr() + "%";
            this.tfHits.text = _loc2_.getHitsEfficiencyStr() + "%";
            if(_loc2_.maxXP != -1)
            {
                this.tfMaxExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXEXP;
                this.tfMaxExperience.enabled = true;
                this.tfMaxExperience.text = _loc2_.getMaxExperienceStr();
                this.tfMaxExperience.value = _loc2_.maxXP > 0?_loc2_.maxXPByVehicle:null;
            }
            else
            {
                this.tfMaxExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXEXPDISABLED;
                this.tfMaxExperience.value = null;
                this.tfMaxExperience.enabled = false;
            }
            this.tfAvgExperience.text = _loc2_.getAvgExperienceStr();
            if(_loc2_.marksOfMastery != -1)
            {
                this.tfMarksOfMastery.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MARKOFMASTERY;
                this.tfMarksOfMastery.enabled = true;
                this.tfMarksOfMastery.text = _loc2_.getMarksOfMasteryCountStr();
                this.tfMarksOfMastery.totalCount = _loc2_.totalUserVehiclesCount;
            }
            else
            {
                this.tfMarksOfMastery.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MARKOFMASTERYDISABLED;
                this.tfMarksOfMastery.enabled = false;
            }
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(Event.RESIZE,this.resizeComponentsHandler);
            super.onDispose();
        }
    }
}
