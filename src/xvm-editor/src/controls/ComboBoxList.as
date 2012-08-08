package controls
{
    import mx.controls.List;
    import mx.controls.listClasses.*;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;
    import mx.controls.Alert;

    public class ComboBoxList extends List
    {

        public function MyComboBoxList(): void
        {
            addEventListener("keyUp", keyUpHandler);
        }

        //ensure that the separator does not get mouse events
        override protected function mouseEventToItemRenderer(event:MouseEvent):IListItemRenderer
        {
            var row:IListItemRenderer = super.mouseEventToItemRenderer(event);

            if (row && row.data && row.data.type == "separator")
                return null;
            else return row;
        }

        //ensure that the separator can't be accessed with the keyboard
        override protected function moveSelectionVertically(code:uint, shiftKey:Boolean,
                                                       ctrlKey:Boolean):void
        {
            super.moveSelectionVertically(code, shiftKey, ctrlKey);

            if(code == Keyboard.DOWN && selectedItem.type == "separator")
            {
                caretIndex++;
            }
            if(code == Keyboard.UP && selectedItem.type == "separator")
            {
                caretIndex--;
            }

            finishKeySelection();
        }

    }
}