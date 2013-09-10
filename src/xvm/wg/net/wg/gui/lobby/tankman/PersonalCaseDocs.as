package net.wg.gui.lobby.tankman 
{
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.carousels.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class PersonalCaseDocs extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function PersonalCaseDocs()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtn_buttonClickHandler);
            this.firstnames.addEventListener(net.wg.gui.lobby.tankman.PersonalCaseInputList.NAME_SELECTED, this.firstnames_nameSelectedHandler);
            this.lastnames.addEventListener(net.wg.gui.lobby.tankman.PersonalCaseInputList.NAME_SELECTED, this.lastnames_nameSelectedHandler);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.submitBtn) 
                this.submitBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtn_buttonClickHandler);
            if (this.firstnames) 
            {
                this.firstnames.removeEventListener(net.wg.gui.lobby.tankman.PersonalCaseInputList.NAME_SELECTED, this.firstnames_nameSelectedHandler);
                this.firstnames.dispose();
            }
            if (this.lastnames) 
            {
                this.lastnames.removeEventListener(net.wg.gui.lobby.tankman.PersonalCaseInputList.NAME_SELECTED, this.lastnames_nameSelectedHandler);
                this.lastnames.dispose();
            }
            if (this.portraitsCarousel) 
            {
                this.portraitsCarousel.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.portraitsCarousel_listIndexChangeHandler);
                this.portraitsCarousel.dispose();
                this.portraitsCarousel = null;
            }
            this.cleanTempData();
            this.firstnames = null;
            this.lastnames = null;
            this.model = null;
            this.submitBtn = null;
            this.gold = null;
            this.credits = null;
            return;
        }

        internal function cleanTempData():void
        {
            this.selectedFirstName = null;
            this.selectedLastName = null;
            this.selectedIcon = null;
            return;
        }

        public function update(arg1:Object):void
        {
            if (arg1 == null) 
                return;
            this.model = arg1 as net.wg.gui.lobby.tankman.PersonalCaseDocsModel;
            this.cleanTempData();
            this.firstnames.updateData(this.model.firstNames, this.model.currentTankmanFirstName);
            this.firstnames.searchText.maxChars = this.model.fistNameMaxChars;
            this.lastnames.updateData(this.model.lastNames, this.model.currentTankmanLastName);
            this.lastnames.searchText.maxChars = this.model.lastNameMaxChars;
            this.gold.text = this.model.priceOfGold.toString();
            this.credits.text = this.model.priveOfCredits.toString();
            this.updateTextColor();
            this.submitBtn.enabled = false;
            if (!this.isDataProviderUpdated) 
            {
                this.updatePortraitsDocs();
                this.isDataProviderUpdated = true;
            }
            return;
        }

        internal function updatePortraitsDocs():void
        {
            this.portraitsCarousel.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.portraitsCarousel_listIndexChangeHandler);
            this.portraitsCarousel.dataProvider = new scaleform.clik.data.DataProvider(this.model.icons);
            this.portraitsCarousel.invalidate(net.wg.gui.components.carousels.CarouselBase.INIT_CAROUSEL);
            return;
        }

        internal function updateTextColor():void
        {
            var loc1:*=this.isHasMoney();
            this.gold.textColor = loc1 ? net.wg.data.constants.Currencies.TEXT_COLORS[net.wg.data.constants.Currencies.GOLD] : net.wg.data.constants.Currencies.TEXT_COLORS[net.wg.data.constants.Currencies.ERROR];
            this.credits.textColor = this.model.useOnlyGold ? net.wg.data.constants.Currencies.TEXT_COLORS[net.wg.data.constants.Currencies.CREDITS] : loc1 ? net.wg.data.constants.Currencies.TEXT_COLORS[net.wg.data.constants.Currencies.CREDITS] : net.wg.data.constants.Currencies.TEXT_COLORS[net.wg.data.constants.Currencies.ERROR];
            return;
        }

        internal function isHasMoney():Boolean
        {
            if (this.model.useOnlyGold) 
                return this.model.userGold >= this.model.priceOfGold;
            return this.model.userGold >= this.model.priceOfGold || this.model.userCredits >= this.model.priveOfCredits;
        }

        internal function firstnames_nameSelectedHandler(arg1:flash.events.Event):void
        {
            this.selectedFirstName = this.firstnames.selectedItem;
            this.checkSelectedItems();
            return;
        }

        internal function lastnames_nameSelectedHandler(arg1:flash.events.Event):void
        {
            this.selectedLastName = this.lastnames.selectedItem;
            this.checkSelectedItems();
            return;
        }

        internal function checkSelectedItems():void
        {
            this.submitBtn.enabled = this.checkAllData();
            return;
        }

        internal function checkAllData():Boolean
        {
            if (!this.isHasMoney()) 
                return false;
            if (this.selectedFirstName && !(this.selectedFirstName.value == this.model.currentTankmanFirstName)) 
                return true;
            if (this.selectedLastName && !(this.selectedLastName.value == this.model.currentTankmanLastName)) 
                return true;
            if (this.selectedIcon && this.checkOriginalIcon(this.selectedIcon.value)) 
                return true;
            return false;
        }

        internal function submitBtn_buttonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc1:*=new net.wg.gui.events.PersonalCaseEvent(net.wg.gui.events.PersonalCaseEvent.CHANGE_PASSPORT, true);
            loc1.newTankmanFirstName = this.selectedFirstName ? this.selectedFirstName : this.firstnames.selectedItem;
            loc1.newTankmanLastName = this.selectedLastName ? this.selectedLastName : this.lastnames.selectedItem;
            if (!this.selectedIcon) 
            {
                loc2 = this.model.originalIconFile;
                loc3 = loc2.lastIndexOf("-") + 1;
                loc4 = loc2.lastIndexOf(".");
                loc5 = loc2.substr(loc3, loc4 - loc3);
                this.selectedIcon = {};
                this.selectedIcon.id = parseInt(loc5);
                this.selectedIcon.value = "fake";
            }
            loc1.newIcon = this.selectedIcon;
            dispatchEvent(loc1);
            return;
        }

        internal function portraitsCarousel_listIndexChangeHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            if (arg1.itemData == null) 
                return;
            if (arg1.itemData && this.checkOriginalIcon(arg1.itemData.value)) 
            {
                this.selectedIcon = {};
                this.selectedIcon.id = arg1.itemData.id;
                this.selectedIcon.value = arg1.itemData.value;
            }
            else 
                this.selectedIcon = null;
            this.checkSelectedItems();
            return;
        }

        internal function checkOriginalIcon(arg1:String=null):Boolean
        {
            if (this.model.originalIconFile.indexOf(arg1, 0) == -1) 
                return true;
            return false;
        }

        public var gold:net.wg.gui.components.controls.IconText=null;

        public var credits:net.wg.gui.components.controls.IconText=null;

        public var submitBtn:net.wg.gui.components.controls.SoundButtonEx=null;

        public var firstnames:net.wg.gui.lobby.tankman.PersonalCaseInputList=null;

        public var lastnames:net.wg.gui.lobby.tankman.PersonalCaseInputList=null;

        public var portraitsCarousel:net.wg.gui.components.carousels.PortraitsCarousel=null;

        internal var model:net.wg.gui.lobby.tankman.PersonalCaseDocsModel=null;

        internal var isDataProviderUpdated:Boolean=false;

        internal var selectedFirstName:Object=null;

        internal var selectedLastName:Object=null;

        internal var selectedIcon:Object=null;
    }
}
