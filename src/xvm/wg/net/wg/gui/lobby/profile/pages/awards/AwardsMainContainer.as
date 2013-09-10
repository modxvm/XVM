package net.wg.gui.lobby.profile.pages.awards 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class AwardsMainContainer extends scaleform.clik.core.UIComponent
    {
        public function AwardsMainContainer()
        {
            super();
            addEventListener(flash.events.Event.RESIZE, this.blockResizeHandler, false, 0, true);
            return;
        }

        protected override function configUI():void
        {
            var loc2:*=null;
            super.configUI();
            var loc1:*=App.utils.locale;
            this.blockBattleHeroes.labelText = loc1.makeString(PROFILE.SECTION_AWARDS_LABELS_BATTLEHEROES);
            this.blockHonors.labelText = loc1.makeString(PROFILE.SECTION_AWARDS_LABELS_HONORARY);
            this.blockEpicAwards.labelText = loc1.makeString(PROFILE.SECTION_AWARDS_LABELS_EPIC);
            this.blockGroupAwards.labelText = loc1.makeString(PROFILE.SECTION_AWARDS_LABELS_GROUP);
            this.blockCommemoratives.labelText = loc1.makeString(PROFILE.SECTION_AWARDS_LABELS_MEMORY);
            this.blockStageAwards.labelText = loc1.makeString(PROFILE.SECTION_AWARDS_LABELS_STAGE);
            this.blockSpecialAwards.labelText = loc1.makeString(PROFILE.SECTION_AWARDS_LABELS_SPECIAL);
            new Vector.<net.wg.gui.lobby.profile.components.AwardsTileListBlock>(7)[0] = this.blockBattleHeroes;
            new Vector.<net.wg.gui.lobby.profile.components.AwardsTileListBlock>(7)[1] = this.blockHonors;
            new Vector.<net.wg.gui.lobby.profile.components.AwardsTileListBlock>(7)[2] = this.blockEpicAwards;
            new Vector.<net.wg.gui.lobby.profile.components.AwardsTileListBlock>(7)[3] = this.blockGroupAwards;
            new Vector.<net.wg.gui.lobby.profile.components.AwardsTileListBlock>(7)[4] = this.blockCommemoratives;
            new Vector.<net.wg.gui.lobby.profile.components.AwardsTileListBlock>(7)[5] = this.blockStageAwards;
            new Vector.<net.wg.gui.lobby.profile.components.AwardsTileListBlock>(7)[6] = this.blockSpecialAwards;
            this.blocks = new Vector.<net.wg.gui.lobby.profile.components.AwardsTileListBlock>(7);
            var loc3:*=0;
            var loc4:*=this.blocks;
            for each (loc2 in loc4) 
            {
                loc2.visible = false;
                loc2.addEventListener(flash.events.Event.RESIZE, this.blockResizeHandler, false, 0, true);
            }
            return;
        }

        internal function blockResizeHandler(arg1:flash.events.Event):void
        {
            arg1.stopPropagation();
            invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this._allMedalsData) 
            {
                loc1 = this.blocks.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    applyBlockData(this.blocks[loc2], this._allMedalsData[loc2]);
                    ++loc2;
                }
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                loc3 = this._gapBetweenBlocks;
                loc5 = this.blocks.length;
                loc6 = 0;
                while (loc6 < loc5) 
                {
                    (loc4 = this.blocks[loc6]).y = this._gapBetweenBlocks;
                    loc4.visible = loc4.dataProvider && loc4.dataProvider.length > 0;
                    if (loc4.visible) 
                    {
                        loc4.y = loc3;
                        loc3 = loc3 + Math.ceil(loc4.height + this._gapBetweenBlocks);
                    }
                    ++loc6;
                }
                _height = loc3 - this._gapBetweenBlocks;
                dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
            }
            return;
        }

        public function set data(arg1:Array):void
        {
            this._allMedalsData = arg1;
            invalidateData();
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            while (this.blocks.length > 0) 
            {
                loc1 = this.blocks.splice((this.blocks.length - 1), 1)[0];
                loc1.removeEventListener(flash.events.Event.RESIZE, this.blockResizeHandler);
                loc1.dispose();
                if (loc1.parent) 
                    loc1.parent.removeChild(loc1);
                loc1 = null;
            }
            this._allMedalsData = null;
            super.dispose();
            return;
        }

        public function set gapBetweenBlocks(arg1:uint):void
        {
            this._gapBetweenBlocks = arg1;
            invalidateSize();
            return;
        }

        internal static function applyBlockData(arg1:net.wg.gui.lobby.profile.components.AwardsTileListBlock, arg2:Array):void
        {
            arg1.dataProvider = arg2;
            return;
        }

        internal var _gapBetweenBlocks:uint=20;

        public var blockBattleHeroes:net.wg.gui.lobby.profile.components.AwardsTileListBlock;

        public var blockHonors:net.wg.gui.lobby.profile.components.AwardsTileListBlock;

        public var blockEpicAwards:net.wg.gui.lobby.profile.components.AwardsTileListBlock;

        public var blockGroupAwards:net.wg.gui.lobby.profile.components.AwardsTileListBlock;

        public var blockCommemoratives:net.wg.gui.lobby.profile.components.AwardsTileListBlock;

        public var blockStageAwards:net.wg.gui.lobby.profile.components.AwardsTileListBlock;

        public var blockSpecialAwards:net.wg.gui.lobby.profile.components.AwardsTileListBlock;

        internal var _allMedalsData:Array;

        internal var blocks:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.components.AwardsTileListBlock>;
    }
}
