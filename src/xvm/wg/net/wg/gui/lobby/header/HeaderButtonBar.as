package net.wg.gui.lobby.header
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;

    public class HeaderButtonBar extends scaleform.clik.controls.ButtonBar implements net.wg.infrastructure.interfaces.IHelpLayoutComponent
    {
        public function HeaderButtonBar()
        {
            super();
            this.visible = false;
            return;
        }

        public function showHelpLayout():void
        {
            var loc1:*=_renderers.length;
            var loc2:*=1;
            while (loc2 < (loc1 - 1))
            {
                (_renderers[loc2] as net.wg.infrastructure.interfaces.IHelpLayoutComponent).showHelpLayout();
                ++loc2;
            }
            return;
        }

        public function closeHelpLayout():void
        {
            var loc1:*=_renderers.length;
            var loc2:*=1;
            while (loc2 < (loc1 - 1))
            {
                (_renderers[loc2] as net.wg.infrastructure.interfaces.IHelpLayoutComponent).closeHelpLayout();
                ++loc2;
            }
            return;
        }

        public function setDisableNav(arg1:Boolean):void
        {
            this._disableNav = arg1;
            this.enabled = !arg1;
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (!this._disableNav)
            {
                super.handleInput(arg1);
            }
            return;
        }

        protected override function updateRenderers():void
        {
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=false;
            var loc8:*=0;
            var loc9:*=null;
            var loc1:*=this.paddingLeft;
            var loc2:*=this.paddingTop;
            var loc3:*=-1;
            if (_renderers[0] is Class(_itemRendererClass))
            {
                while (_renderers.length > _dataProvider.length)
                {
                    loc5 = (_renderers.length - 1);
                    if (container.contains(_renderers[loc5]))
                    {
                        container.removeChild(_renderers[loc5]);
                    }
                    _renderers.splice(loc5--, 1);
                }
            }
            else
            {
                while (container.numChildren > 0)
                {
                    container.removeChildAt(0);
                }
                _renderers.length = 0;
            }
            var loc4:*=0;
            while (loc4 < _dataProvider.length && loc3 == -1)
            {
                loc7 = false;
                if (loc4 < _renderers.length)
                {
                    loc6 = _renderers[loc4];
                }
                else
                {
                    loc6 = new _itemRendererClass();
                    setupRenderer(loc6, loc4);
                    loc7 = true;
                }
                this.populateRendererData(loc6, loc4);
                if (_autoSize == flash.text.TextFieldAutoSize.NONE && _buttonWidth > 0)
                {
                    loc6.width = Math.round(_buttonWidth);
                }
                else if (_autoSize != flash.text.TextFieldAutoSize.NONE)
                {
                    loc6.autoSize = _autoSize;
                }
                loc6.validateNow();
                if (loc6.width + _spacing + loc1 < MAX_WIDTH)
                {
                    loc6.y = this.paddingTop;
                    loc6.x = Math.round(loc1);
                    loc1 = loc1 + (loc6.width + _spacing);
                    loc2 = Math.round(loc6.height + this.paddingTop);
                }
                else
                {
                    loc3 = loc4;
                    loc6 = null;
                }
                if (loc7 && !(loc6 == null))
                {
                    loc6.group = _group;
                    container.addChild(loc6);
                    _renderers.push(loc6);
                }
                ++loc4;
            }
            if (loc3 > -1)
            {
                loc8 = (_renderers.length - 1);
                while (loc8 >= loc3)
                {
                    loc9 = _renderers[loc8];
                    if (loc9)
                    {
                        if (container.contains(loc9))
                        {
                            container.removeChild(loc9);
                        }
                        _renderers.splice(loc8, 1);
                    }
                    --loc8;
                }
            }
            this.bg.width = Math.round(loc1 - _spacing + this.paddingRight);
            this.bg.height = Math.round(loc2 + this.paddingBottom);
            dispatchEvent(new net.wg.gui.events.HeaderButtonBarEvent(net.wg.gui.events.HeaderButtonBarEvent.RESIZE, this.bg.width));
            selectedIndex = Math.min((_dataProvider.length - 1), _selectedIndex);
            return;
        }

        protected override function populateRendererData(arg1:scaleform.clik.controls.Button, arg2:uint):void
        {
            arg1.label = itemToLabel(_dataProvider.requestItemAt(arg2));
            arg1.data = _dataProvider.requestItemAt(arg2);
            arg1.selected = arg2 == selectedIndex;
            if (_dataProvider[arg2].textColor)
            {
                net.wg.gui.components.controls.SoundButtonEx(arg1).textColor = _dataProvider[arg2].textColor;
            }
            if (_dataProvider[arg2].tooltip)
            {
                net.wg.gui.components.controls.SoundButtonEx(arg1).tooltip = _dataProvider[arg2].tooltip;
            }
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS) || isInvalid(scaleform.clik.constants.InvalidationType.DATA) || isInvalid(scaleform.clik.constants.InvalidationType.SETTINGS) || isInvalid(scaleform.clik.constants.InvalidationType.SIZE))
            {
                this.visible = true;
                removeChild(container);
                addChild(container);
                this.updateRenderers();
            }
            return;
        }

        internal static const MAX_WIDTH:Number=1024;

        public var bg:flash.display.MovieClip;

        public var paddingTop:Number=0;

        public var paddingBottom:Number=0;

        public var paddingLeft:Number=0;

        public var paddingRight:Number=0;

        internal var _disableNav:Boolean=false;
    }
}
