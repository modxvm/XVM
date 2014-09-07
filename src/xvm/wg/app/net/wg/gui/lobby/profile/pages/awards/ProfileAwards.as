package net.wg.gui.lobby.profile.pages.awards
{
    import net.wg.infrastructure.base.meta.impl.ProfileAwardsMeta;
    import net.wg.infrastructure.base.meta.IProfileAwardsMeta;
    import net.wg.gui.components.controls.ResizableScrollPane;
    import flash.text.TextField;
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.profile.pages.awards.data.ProfileAwardsInitVO;
    import net.wg.gui.lobby.profile.pages.awards.data.AchievementFilterVO;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.lobby.profile.data.ProfileAchievementVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.lobby.profile.ProfileConstants;
    
    public class ProfileAwards extends ProfileAwardsMeta implements IProfileAwardsMeta
    {
        
        public function ProfileAwards()
        {
            super();
        }
        
        private static var INVOKE_UPD_INVALID:String = "invokeUpdInv";
        
        private static function generateDropdownItem(param1:String) : Object
        {
            return {"label":App.utils.locale.makeString(param1)};
        }
        
        public var mainScrollPane:ResizableScrollPane;
        
        public var txtLabel:TextField;
        
        public var dropdownMenu:DropdownMenu;
        
        private var daapiInitialized:Boolean;
        
        private var startMenuX:int;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.startMenuX = this.dropdownMenu.x;
            var _loc1_:AwardsMainContainer = this.getMainContainer();
            AwardsBlock(_loc1_.blockSpecialAwards).showProgress = false;
            this.dropdownMenu.addEventListener(MouseEvent.MOUSE_OVER,this.checkBoxMouseOverHandler,false,0,true);
            this.dropdownMenu.addEventListener(MouseEvent.MOUSE_OUT,this.checkBoxMouseOutHandler,false,0,true);
        }
        
        private function checkBoxMouseOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(PROFILE.SECTION_AWARDS_DROPDOWN_TOOLTIP);
        }
        
        private function checkBoxMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        override public function as_setInitData(param1:Object) : void
        {
            var _loc9_:Object = null;
            super.as_setInitData(param1);
            var _loc2_:ProfileAwardsInitVO = new ProfileAwardsInitVO(param1);
            this.txtLabel.text = App.utils.locale.makeString(PROFILE.PROFILE_DROPDOWN_EXISTENCE);
            var _loc3_:AchievementFilterVO = _loc2_.achievementFilterVO;
            var _loc4_:String = _loc3_.selectedItem;
            var _loc5_:Array = _loc3_.dataProvider;
            this.dropdownMenu.dataProvider = new DataProvider(_loc5_);
            this.dropdownMenu.addEventListener(ListEvent.INDEX_CHANGE,this.menuIndexChangeHandler,false,0,true);
            var _loc6_:* = -1;
            var _loc7_:uint = _loc5_.length;
            var _loc8_:* = 0;
            while(_loc8_ < _loc7_)
            {
                _loc9_ = _loc5_[_loc8_];
                if(_loc9_.key == _loc4_)
                {
                    _loc6_ = _loc8_;
                    break;
                }
                _loc8_++;
            }
            this.dropdownMenu.selectedIndex = _loc6_;
            this.dropdownMenu.validateNow();
            this.daapiInitialized = true;
            invalidate(INVOKE_UPD_INVALID);
        }
        
        private function menuIndexChangeHandler(param1:ListEvent) : void
        {
            setFilterS(param1.itemData.key);
        }
        
        override protected function applyData(param1:Object) : Object
        {
            var _loc7_:AwardsBlock = null;
            var _loc11_:ProfileAchievementVO = null;
            var _loc12_:Array = null;
            var _loc13_:Array = null;
            var _loc14_:uint = 0;
            var _loc15_:uint = 0;
            var _loc16_:* = 0;
            var _loc2_:AwardsMainContainer = this.getMainContainer();
            var _loc3_:Array = param1.achievementsList;
            var _loc4_:Array = param1.totalItemsList;
            var _loc5_:Vector.<AwardsBlock> = new Vector.<AwardsBlock>();
            _loc5_.push(_loc2_.blockBattleHeroes);
            _loc5_.push(_loc2_.blockHonors);
            _loc5_.push(_loc2_.blockEpicAwards);
            _loc5_.push(_loc2_.blockGroupAwards);
            _loc5_.push(_loc2_.blockCommemoratives);
            _loc5_.push(_loc2_.blockStageAwards);
            _loc5_.push(_loc2_.blockSpecialAwards);
            var _loc6_:uint = _loc4_.length;
            var _loc8_:* = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
                _loc7_ = _loc5_[_loc8_];
                _loc7_.totalCount = _loc4_[_loc8_];
                _loc8_++;
            }
            var _loc9_:Array = [];
            var _loc10_:int = this.dropdownMenu.selectedIndex;
            _loc6_ = _loc3_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
                _loc7_ = _loc5_[_loc8_];
                _loc12_ = [];
                _loc13_ = _loc3_[_loc8_];
                _loc14_ = 0;
                _loc15_ = _loc13_.length;
                _loc16_ = 0;
                while(_loc16_ < _loc15_)
                {
                    _loc11_ = new ProfileAchievementVO(_loc13_[_loc16_]);
                    if(_loc10_ == 0)
                    {
                        if(_loc11_.isInDossier)
                        {
                            _loc14_++;
                        }
                    }
                    _loc12_.push(_loc11_);
                    _loc16_++;
                }
                if(_loc10_ != 0)
                {
                    _loc14_ = _loc15_;
                }
                _loc7_.currentCount = _loc14_;
                _loc9_.push(_loc12_);
                _loc8_++;
            }
            _loc2_.data = _loc9_;
            return param1;
        }
        
        override protected function applyResizing() : void
        {
            var _loc1_:Number = Math.round(currentDimension.x / 2 - centerOffset);
            this.dropdownMenu.x = this.startMenuX + _loc1_;
            this.txtLabel.autoSize = TextFieldAutoSize.LEFT;
            this.txtLabel.x = this.dropdownMenu.x - this.txtLabel.width - 5;
            var _loc2_:Number = Math.min(ProfileConstants.MIN_APP_WIDTH,currentDimension.x);
            this.mainScrollPane.target.x = _loc1_ + (_loc2_ - this.mainScrollPane.target.width >> 1) + 6;
            this.mainScrollPane.setSize(currentDimension.x,currentDimension.y);
        }
        
        protected function getMainContainer() : AwardsMainContainer
        {
            return AwardsMainContainer(this.mainScrollPane.target);
        }
        
        public function setBattlesHeroesData(param1:Array) : void
        {
            this.getMainContainer().blockBattleHeroes.dataProvider = param1;
        }
        
        public function setHonorsData(param1:String, param2:Array) : void
        {
            this.getMainContainer().blockHonors.dataProvider = new DataProvider(param2);
        }
        
        override protected function onDispose() : void
        {
            this.dropdownMenu.removeEventListener(MouseEvent.MOUSE_OVER,this.checkBoxMouseOverHandler);
            this.dropdownMenu.removeEventListener(MouseEvent.MOUSE_OUT,this.checkBoxMouseOutHandler);
            super.onDispose();
        }
    }
}
