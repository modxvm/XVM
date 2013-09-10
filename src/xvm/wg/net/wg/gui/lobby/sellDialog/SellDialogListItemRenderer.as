package net.wg.gui.lobby.sellDialog 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    
    public class SellDialogListItemRenderer extends scaleform.clik.controls.ListItemRenderer
    {
        public function SellDialogListItemRenderer()
        {
            this.elements = new Vector.<net.wg.data.VO.SellDialogElement>();
            this.renderers = new Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>();
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.elements.splice(0, this.elements.length);
            var loc1:*=this.renderers.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                net.wg.infrastructure.interfaces.entity.IDisposable(this.renderers[loc2]).dispose();
                ++loc2;
            }
            this.renderers.splice(0, loc1);
            return;
        }

        protected override function configUI():void
        {
            this.buttonMode = false;
            this.clickArea.buttonMode = false;
            this.mouseChildren = true;
            if (!(_focusIndicator == null) && !_focused && _focusIndicator.totalFrames == 1) 
            {
                focusIndicator.visible = false;
            }
            if (this.container == null) 
            {
                this.container = new flash.display.Sprite();
                addChild(this.container);
            }
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1) 
            {
                this.header.text = net.wg.data.VO.SellDialogItem(arg1).header;
                this.elements = net.wg.data.VO.SellDialogItem(arg1).elements;
                this.data = arg1;
                invalidateData();
            }
            return;
        }

        internal function createItemRenderers(arg1:Number):__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>
        {
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < arg1) 
            {
                loc1.push(this.createItemRenderer(loc2));
                if (loc2 == (arg1 - 1)) 
                {
                    loc1[loc2].hideLine();
                }
                ++loc2;
            }
            return Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>(loc1);
        }

        internal function createItemRenderer(arg1:Number):net.wg.infrastructure.interfaces.ISaleItemBlockRenderer
        {
            var loc1:*=App.utils.classFactory.getComponent(net.wg.data.constants.Linkages.SALE_ITEM_BLOCK_RENDERER, net.wg.infrastructure.interfaces.ISaleItemBlockRenderer);
            this.container.addChild(flash.display.DisplayObject(loc1));
            return loc1;
        }

        public function getRenderers():__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>
        {
            return this.renderers;
        }

        internal function drawLayout():void
        {
            var loc1:*=41;
            var loc2:*=27;
            var loc3:*=loc1;
            var loc4:*=0;
            while (loc4 < this.renderers.length) 
            {
                this.renderers[loc4].x = 0;
                this.renderers[loc4].y = loc1 + loc2 * loc4;
                this.renderers[loc4].setData(this.elements[loc4]);
                this.renderers[loc4].validateNow();
                ++loc4;
            }
            if (this.renderers) 
            {
                loc3 = this.renderers.length * loc2 + loc1;
            }
            var loc5:*;
            this.clickArea.height = loc5 = loc3;
            this.height = loc5;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && data) 
            {
                this.renderers = this.createItemRenderers(this.elements.length);
                this.drawLayout();
            }
            return;
        }

        public override function setSize(arg1:Number, arg2:Number):void
        {
            this.scrollingRenderrBg.width = arg1;
            var loc1:*=0;
            while (loc1 < this.renderers.length) 
            {
                this.renderers[loc1].setSize(arg1, this.renderers[loc1].height);
                ++loc1;
            }
            super.setSize(arg1, arg2);
            return;
        }

        public var clickArea:flash.display.MovieClip;

        public var header:flash.text.TextField;

        internal var elements:__AS3__.vec.Vector.<net.wg.data.VO.SellDialogElement>;

        internal var renderers:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>;

        internal var eventLengs:Number=0;

        protected var _itemRenderer:Class;

        public var container:flash.display.Sprite;

        public var rendererBG:flash.display.MovieClip;

        public var scrollingRenderrBg:flash.display.MovieClip;
    }
}
