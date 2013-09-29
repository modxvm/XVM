package net.wg.gui.lobby.battleResults 
{
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;
    
    public class TeamStatsList extends net.wg.gui.components.controls.ScrollingListEx
    {
        public function TeamStatsList()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            wrapping = scaleform.clik.constants.WrappingMode.NORMAL;
            return;
        }

        protected override function drawLayout():void
        {
            var loc8:*=null;
            var loc1:*=_renderers.length;
            var loc2:*=rowHeight;
            var loc3:*=availableWidth - padding.horizontal;
            var loc4:*=margin + padding.left;
            var loc5:*=margin + padding.top;
            var loc6:*=isInvalid(scaleform.clik.constants.InvalidationType.DATA);
            var loc7:*=0;
            while (loc7 < loc1) 
            {
                (loc8 = getRendererAt(loc7)).x = Math.round(loc4);
                loc8.y = Math.round(loc5 + loc7 * loc2);
                loc8.width = loc3;
                if (!loc6) 
                {
                    loc8.validateNow();
                }
                ++loc7;
            }
            drawScrollBar();
            return;
        }

        protected override function handleItemClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=(arg1.currentTarget as scaleform.clik.interfaces.IListItemRenderer).index;
            if (isNaN(loc1)) 
            {
                return;
            }
            if (dispatchItemEvent(arg1)) 
            {
                if (useRightButton && useRightButtonForSelect || arg1.buttonIdx == 0) 
                {
                    selectedIndex = loc1;
                }
            }
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.handled) 
            {
                return;
            }
            var loc1:*=getRendererAt(_selectedIndex, _scrollPosition);
            if (loc1 != null) 
            {
                loc1.handleInput(arg1);
                if (arg1.handled) 
                {
                    return;
                }
            }
            var loc2:*=arg1.details;
            var loc3:*=loc2.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc2.value == scaleform.clik.constants.InputValue.KEY_HOLD;
            var loc4:*=loc2.navEquivalent;
            switch (loc4) 
            {
                case scaleform.clik.constants.NavigationCode.UP:
                {
                    if (selectedIndex != -1) 
                    {
                        if (_selectedIndex > 0) 
                        {
                            if (loc3) 
                            {
                                selectedIndex--;
                            }
                        }
                        else if (wrapping != scaleform.clik.constants.WrappingMode.STICK) 
                        {
                            if (wrapping != scaleform.clik.constants.WrappingMode.WRAP) 
                            {
                                return;
                            }
                            else if (loc3) 
                            {
                                selectedIndex = (_dataProvider.length - 1);
                            }
                        }
                    }
                    else if (loc3) 
                    {
                        return;
                    }
                    break;
                }
                case scaleform.clik.constants.NavigationCode.DOWN:
                {
                    if (_selectedIndex != -1) 
                    {
                        if (_selectedIndex < (_dataProvider.length - 1)) 
                        {
                            if (loc3) 
                            {
                                selectedIndex++;
                            }
                        }
                        else if (wrapping != scaleform.clik.constants.WrappingMode.STICK) 
                        {
                            if (wrapping != scaleform.clik.constants.WrappingMode.WRAP) 
                            {
                                return;
                            }
                            else if (loc3) 
                            {
                                selectedIndex = 0;
                            }
                        }
                    }
                    else if (loc3) 
                    {
                        selectedIndex = _scrollPosition;
                    }
                    break;
                }
                case scaleform.clik.constants.NavigationCode.END:
                {
                    if (!loc3) 
                    {
                        selectedIndex = (_dataProvider.length - 1);
                    }
                    break;
                }
                case scaleform.clik.constants.NavigationCode.HOME:
                {
                    if (!loc3) 
                    {
                        selectedIndex = 0;
                    }
                    break;
                }
                case scaleform.clik.constants.NavigationCode.PAGE_UP:
                {
                    if (loc3) 
                    {
                        selectedIndex = Math.max(0, _selectedIndex - _totalRenderers);
                    }
                    break;
                }
                case scaleform.clik.constants.NavigationCode.PAGE_DOWN:
                {
                    if (loc3) 
                    {
                        selectedIndex = Math.min((_dataProvider.length - 1), _selectedIndex + _totalRenderers);
                    }
                    break;
                }
                default:
                {
                    return;
                }
            }
            arg1.handled = true;
            return;
        }
    }
}
