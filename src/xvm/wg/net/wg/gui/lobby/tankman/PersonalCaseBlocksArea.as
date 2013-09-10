package net.wg.gui.lobby.tankman 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.core.*;
    import scaleform.gfx.*;
    
    public class PersonalCaseBlocksArea extends scaleform.clik.core.UIComponent
    {
        public function PersonalCaseBlocksArea()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.removeElements();
            return;
        }

        internal function removeElements():void
        {
            var loc1:*=this.numChildren;
            var loc2:*;
            --loc2;
            while (loc2 >= 0) 
            {
                if (this.getChildAt(loc2) is net.wg.infrastructure.interfaces.entity.IDisposable) 
                {
                    net.wg.infrastructure.interfaces.entity.IDisposable(this.getChildAt(loc2)).dispose();
                }
                this.removeChildAt(loc2);
                --loc2;
            }
            return;
        }

        public function setData(arg1:Array):void
        {
            if (!App.instance || arg1 == null) 
            {
                return;
            }
            this.data = arg1;
            if (this.isElementsCreated) 
            {
                this.updateBlocks();
            }
            else 
            {
                this.initializeBlocks();
            }
            return;
        }

        internal function updateBlocks():void
        {
            var loc3:*=null;
            this.paddingY = Y_START_POSITION;
            var loc1:*=this.numChildren;
            var loc2:*;
            --loc2;
            while (loc2 >= 0) 
            {
                loc3 = this.getChildAt(loc2);
                if (this.getChildAt(loc2) is flash.display.Shape == false) 
                {
                    this.removeChildAt(loc2);
                }
                --loc2;
            }
            this.initializeBlocks();
            return;
        }

        internal function initializeBlocks():void
        {
            var loc2:*=null;
            var loc1:*=0;
            while (loc1 < this.data.length) 
            {
                loc2 = this.data[loc1];
                this.createTitles(loc2);
                ++loc1;
            }
            this.isElementsCreated = true;
            return;
        }

        internal function createTitles(arg1:Object):void
        {
            var loc1:*=this.classFactory(net.wg.data.constants.Linkages.PERSONAL_CASE_TITLE_BLOCK);
            if (scaleform.gfx.Extensions.isScaleform) 
            {
                loc1["blockName"].text = MENU.profile_stats_blocks(arg1.label);
            }
            else 
            {
                loc1["blockName"].text = arg1.label;
            }
            loc1.y = this.paddingY;
            this.addChild(loc1);
            this.paddingY = this.paddingY + PADDING_BETWEEN_BLOCKS;
            this.creteRows(arg1.stats);
            return;
        }

        internal function creteRows(arg1:Array):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=0;
            while (loc1 < arg1.length) 
            {
                loc2 = arg1[loc1];
                (loc3 = this.classFactory(net.wg.data.constants.Linkages.PERSONAL_CASE_BLOCK_ITEM)).setData = loc2;
                loc3.y = this.paddingY;
                this.addChild(loc3);
                this.paddingY = this.paddingY + PADDING_BETWEEN_BLOCKS;
                ++loc1;
            }
            this.paddingY = this.paddingY + PADDING_BETWEEN_BLOCK_TITLE;
            return;
        }

        internal function classFactory(arg1:String):*
        {
            return App.utils.classFactory.getComponent(arg1, flash.display.MovieClip);
        }

        internal static const Y_START_POSITION:uint=17;

        internal static const PADDING_BETWEEN_BLOCKS:uint=20;

        internal static const PADDING_BETWEEN_BLOCK_TITLE:uint=11;

        internal var data:Array;

        internal var isElementsCreated:Boolean=false;

        internal var paddingY:int=17;
    }
}
