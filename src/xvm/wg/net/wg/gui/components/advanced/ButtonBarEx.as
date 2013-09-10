package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class ButtonBarEx extends scaleform.clik.controls.ButtonBar implements net.wg.infrastructure.interfaces.IGroupedControl
    {
        public function ButtonBarEx()
        {
            super();
            return;
        }

        public function get paddingHorizontal():Number
        {
            return this._paddingHorizontal;
        }

        public function set paddingHorizontal(arg1:Number):void
        {
            this._paddingHorizontal = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.SETTINGS);
            return;
        }

        protected override function setupRenderer(arg1:scaleform.clik.controls.Button, arg2:uint):void
        {
            var loc1:*=null;
            super.setupRenderer(arg1, arg2);
            arg1.autoSize = this.autoSize;
            if (arg1 is net.wg.gui.components.controls.SoundButtonEx) 
            {
                loc1 = arg1 as net.wg.gui.components.controls.SoundButtonEx;
                loc1.paddingHorizontal = this.paddingHorizontal;
            }
            return;
        }

        public function get selectedRenderer():scaleform.clik.interfaces.IListItemRenderer
        {
            if (_selectedIndex >= 0) 
            {
                return _renderers[_selectedIndex];
            }
            return null;
        }

        public override function get data():Object
        {
            return selectedItem;
        }

        public function disposeRenderers():void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=_renderers.length;
            --loc2;
            while (loc2 >= 0) 
            {
                loc3 = getButtonAt(loc2);
                if (loc3 != null) 
                {
                    if (loc4 = loc3 as net.wg.infrastructure.interfaces.entity.IDisposable) 
                    {
                        loc4.dispose();
                    }
                    loc5 = loc3 as flash.display.DisplayObject;
                    if (container) 
                    {
                        if (container.contains(loc5)) 
                        {
                            container.removeChild(loc5);
                        }
                    }
                }
                _renderers.splice(loc2, 1);
                --loc2;
            }
            this.removeChild(container);
            if (_dataProvider) 
            {
                _dataProvider.cleanUp();
            }
            _dataProvider = null;
            return;
        }

        public override function dispose():void
        {
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false);
            if (_dataProvider) 
            {
                _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange, false);
            }
            this.disposeRenderers();
            if (_group) 
            {
                _group.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, handleButtonGroupChange, false);
                _group.dispose();
                _group = null;
            }
            super.dispose();
            return;
        }

        protected override function populateRendererData(arg1:scaleform.clik.controls.Button, arg2:uint):void
        {
            var loc1:*=_dataProvider.requestItemAt(arg2);
            if (arg1.hasOwnProperty("tooltip") && loc1 && loc1.hasOwnProperty("tooltip")) 
            {
                arg1["tooltip"] = loc1.tooltip;
            }
            super.populateRendererData(arg1, arg2);
            return;
        }

        public override function toString():String
        {
            return "[WG ButtonBarEx " + name + "]";
        }

        internal var _paddingHorizontal:Number=10;
    }
}
