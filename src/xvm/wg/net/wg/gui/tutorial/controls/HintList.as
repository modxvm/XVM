package net.wg.gui.tutorial.controls 
{
    import flash.events.*;
    import net.wg.gui.tutorial.constants.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class HintList extends scaleform.clik.core.UIComponent
    {
        public function HintList()
        {
            this._dataProvider = [];
            this.items = [];
            super();
            return;
        }

        public function get dataProvider():Array
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:Array):void
        {
            this._dataProvider = arg1;
            invalidateData();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.removeItems();
            this._dataProvider = this._dataProvider.splice(0, this._dataProvider.length);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.repopulate();
                this.relayout();
            }
            return;
        }

        public function relayout():void
        {
            var loc2:*=null;
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=this.items;
            for each (loc2 in loc4) 
            {
                loc2.y = loc1 ^ 0;
                loc1 = loc1 + (loc2.height + this.verticalGap);
            }
            return;
        }

        internal function repopulate():void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.removeItems();
            var loc3:*=0;
            var loc4:*=this._dataProvider;
            for each (loc1 in loc4) 
            {
                loc2 = this.createRenderer(loc1);
                loc2.addEventListener(flash.events.MouseEvent.CLICK, this.onItemClick);
                addChild(loc2);
                loc2.validateNow();
                this.items.push(loc2);
            }
            return;
        }

        internal function onItemClick(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=arg1.currentTarget as net.wg.gui.tutorial.controls.HintBaseItemRenderer;
            var loc2:*=new scaleform.clik.events.ListEvent(scaleform.clik.events.ListEvent.ITEM_CLICK);
            loc2.itemData = loc1.data;
            dispatchEvent(loc2);
            return;
        }

        internal function createRenderer(arg1:Object):net.wg.gui.tutorial.controls.HintBaseItemRenderer
        {
            var loc1:*=null;
            var loc2:*="";
            var loc3:*=arg1.type;
            switch (loc3) 
            {
                case net.wg.gui.tutorial.constants.HintItemType.TEXT:
                    loc2 = this.textItemRenderer;
                    break;
                case net.wg.gui.tutorial.constants.HintItemType.VIDEO_LINK:
                    loc2 = this.videoItemRenderer;
                    break;
            }
            loc1 = App.utils.classFactory.getComponent(loc2, net.wg.gui.tutorial.controls.HintBaseItemRenderer);
            loc1.data = arg1;
            return loc1;
        }

        internal function removeItems():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.items;
            for each (loc1 in loc3) 
            {
                removeChild(loc1);
                loc1.dispose();
            }
            this.items = this.items.splice(0, this.items.length);
            return;
        }

        public var textItemRenderer:String;

        public var videoItemRenderer:String;

        public var verticalGap:Number=0;

        internal var _dataProvider:Array;

        internal var items:Array;
    }
}
