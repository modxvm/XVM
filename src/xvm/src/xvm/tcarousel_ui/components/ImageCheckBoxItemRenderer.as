/**
 * XFW
 * @author STL1te
 */
package xvm.tcarousel_ui.components
{
    import com.xfw.*;
    import flash.events.*;
    import net.wg.gui.events.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;

    public class ImageCheckBoxItemRenderer extends ListItemRedererImageText // from controls.swf
    {
        //public var checkBox:CheckBox;

        public function ImageCheckBoxItemRenderer()
        {
            super();
            icon.autoSize = true;
        }

        override protected function configUI():void
        {
            super.configUI();

            ico_border.visible = false;
            //checkBox = addChild(App.utils.classFactory.getComponent("CheckBox", CheckBox)) as CheckBox;
            //checkBox.label = "";
            //checkBox.x = 5;
            //checkBox.setActualSize(40, 20);

            //ico_border.x = 25;
            //textField.x = 75;

            //var menu:DropdownMenu = parent as DropdownMenu;
            //if (menu != null)
            //{
            //    textField.width = menu.menuWidth - textField.x - 5;
            //}

            //constraints.updateElement("textField", textField);
        }

        override protected function handleMousePress(event:MouseEvent):void
        {
            var e:MouseEventEx = event as MouseEventEx;
            if (e != null && (e.buttonIdx == 1 || e.buttonIdx == 2))
            {
                setState("release");
                dispatchEvent(new ButtonEvent(ButtonEvent.CLICK, true, false, e.mouseIdx, e.buttonIdx));
            }
            else
            {
                super.handleMousePress(event);
            }
        }

        override protected function draw():void
        {
            super.draw();
            /*checkBox.selected =*/
            selected = data.selected;
        }

        override protected function completeLoadA(event:UILoaderEvent):void
        {
            super.completeLoadA(event);
            var loader:* = icon.getChildAt(1);
            var iconWidth:Number = loader.content.width >> 1;
            icon.x = int(ico_border.x + (ico_border.width >> 1) - iconWidth);
            icon.scaleX = ico_border.scaleX = textField.scaleX;
            icon.scaleY = ico_border.scaleY = textField.scaleY;
        }
    }
}
