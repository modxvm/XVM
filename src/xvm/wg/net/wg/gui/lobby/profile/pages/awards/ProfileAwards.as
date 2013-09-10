package net.wg.gui.lobby.profile.pages.awards 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.data.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class ProfileAwards extends net.wg.infrastructure.base.meta.impl.ProfileAwardsMeta implements net.wg.infrastructure.base.meta.IProfileAwardsMeta
    {
        public function ProfileAwards()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.startMenuX = this.dropdownMenu.x;
            var loc1:*=this.getMainContainer();
            net.wg.gui.lobby.profile.pages.awards.AwardsBlock(loc1.blockSpecialAwards).showProgress = false;
            this.dropdownMenu.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.checkBoxMouseOverHandler, false, 0, true);
            this.dropdownMenu.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.checkBoxMouseOutHandler, false, 0, true);
            return;
        }

        internal function checkBoxMouseOverHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(PROFILE.SECTION_AWARDS_DROPDOWN_TOOLTIP);
            return;
        }

        internal function checkBoxMouseOutHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            var loc1:*=[];
            loc1.push(generateDropdownItem(PROFILE.SECTION_AWARDS_DROPDOWN_LABELS_ALL));
            loc1.push(generateDropdownItem(PROFILE.SECTION_AWARDS_DROPDOWN_LABELS_INPROCESS));
            loc1.push(generateDropdownItem(PROFILE.SECTION_AWARDS_DROPDOWN_LABELS_NONE));
            this.dropdownMenu.dataProvider = new scaleform.clik.data.DataProvider(loc1);
            this.dropdownMenu.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.menuIndexChangeHandler, false, 0, true);
            this.dropdownMenu.selectedIndex = 0;
            this.dropdownMenu.validateNow();
            this.daapiInitialized = true;
            invalidate(INVOKE_UPD_INVALID);
            return;
        }

        internal function menuIndexChangeHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            invalidate(INVOKE_UPD_INVALID);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVOKE_UPD_INVALID) && this.daapiInitialized) 
            {
                this.updateByDossier(new net.wg.data.gui_items.dossier.AccountDossier(currentDossier ? currentDossier.id : null));
            }
            return;
        }

        protected override function updateByDossier(arg1:net.wg.data.gui_items.dossier.AccountDossier):void
        {
            var loc6:*=null;
            var loc8:*=null;
            var loc9:*=0;
            var loc10:*=null;
            super.updateByDossier(arg1);
            var loc1:*=this.getMainContainer();
            var loc2:*=arg1.getAllAchievements();
            var loc3:*;
            (loc3 = new Vector.<net.wg.gui.lobby.profile.pages.awards.AwardsBlock>()).push(loc1.blockBattleHeroes);
            loc3.push(loc1.blockHonors);
            loc3.push(loc1.blockEpicAwards);
            loc3.push(loc1.blockGroupAwards);
            loc3.push(loc1.blockCommemoratives);
            loc3.push(loc1.blockStageAwards);
            loc3.push(loc1.blockSpecialAwards);
            var loc4:*=this.dropdownMenu.selectedIndex;
            var loc5:*=loc2.length;
            var loc7:*=0;
            loc7 = 0;
            while (loc7 < loc5) 
            {
                (loc6 = loc3[loc7]).totalCount = loc2[loc7].length;
                ++loc7;
            }
            var loc11:*=loc4;
            switch (loc11) 
            {
                case 1:
                {
                    loc2 = arg1.getAchievements(true);
                    break;
                }
                case 2:
                {
                    loc2 = arg1.getAchievements(false);
                    break;
                }
            }
            loc7 = 0;
            while (loc7 < loc5) 
            {
                loc6 = loc3[loc7];
                loc8 = loc2[loc7];
                if (loc4 != 0) 
                {
                    loc6.currentCount = loc8.length;
                }
                else 
                {
                    loc9 = 0;
                    loc11 = 0;
                    var loc12:*=loc8;
                    for each (loc10 in loc12) 
                    {
                        if (!loc10.isInDossier) 
                        {
                            continue;
                        }
                        ++loc9;
                    }
                    loc6.currentCount = loc9;
                }
                ++loc7;
            }
            net.wg.gui.lobby.profile.pages.awards.StageAwardsBlock(loc1.blockStageAwards).battlesCount = arg1.getBattlesCount();
            loc1.data = loc2;
            return;
        }

        protected override function applyResizing():void
        {
            var loc1:*=Math.round(currentDimension.x / 2 - centerOffset);
            this.dropdownMenu.x = this.startMenuX + loc1;
            var loc2:*=Math.min(net.wg.gui.lobby.profile.ProfileConstants.MIN_APP_WIDTH, currentDimension.x);
            this.mainScrollPane.target.x = loc1 + (loc2 - this.mainScrollPane.target.width >> 1) + 6;
            this.mainScrollPane.setSize(currentDimension.x, currentDimension.y);
            return;
        }

        protected function getMainContainer():net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer
        {
            return net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer(this.mainScrollPane.target);
        }

        public function setBattlesHeroesData(arg1:Array):void
        {
            this.getMainContainer().blockBattleHeroes.dataProvider = arg1;
            return;
        }

        public function setHonorsData(arg1:String, arg2:Array):void
        {
            this.getMainContainer().blockHonors.dataProvider = new scaleform.clik.data.DataProvider(arg2);
            return;
        }

        protected override function onDispose():void
        {
            this.dropdownMenu.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.checkBoxMouseOverHandler);
            this.dropdownMenu.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.checkBoxMouseOutHandler);
            super.onDispose();
            return;
        }

        internal static function generateDropdownItem(arg1:String):Object
        {
            return {"label":App.utils.locale.makeString(arg1)};
        }

        internal static const INVOKE_UPD_INVALID:String="invokeUpdInv";

        public var mainScrollPane:net.wg.gui.lobby.profile.components.ResizableScrollPane;

        public var dropdownMenu:net.wg.gui.components.controls.DropdownMenu;

        internal var daapiInitialized:Boolean;

        internal var startMenuX:int;
    }
}
