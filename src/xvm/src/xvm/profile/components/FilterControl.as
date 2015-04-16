package xvm.profile.components
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.events.*;

    // Filter
    // [           ] [nation|v] [class|v] [level|v] [master|v] [prefs|v] [SAVE]
    public class FilterControl extends Sprite
    {
        #TODO: use or remove

        private var filterTextInput:TextInput;
        //private var nationFilter:DropDown;
        //private var classFilter:DropDown;
        //private var levelFilter:DropDown;
        //private var masteryFilter:DropDown;
        //private var prefFilter:DropDown;
        //private var saveButton:Button;

        public function FilterControl()
        {
            addChild(createLabel("Filter", 0, 0));
            filterTextInput = App.utils.classFactory.getComponent("TextInput", TextInput);
            filterTextInput.x = 0;
            filterTextInput.y = 17;
            filterTextInput.width = 250; //65;
            filterTextInput.text = Config.config.userInfo.defaultFilterValue;
            filterTextInput.addEventListener(Event.CHANGE, onChange);
            filterTextInput.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            addChild(filterTextInput);

            /*addChild(createLabel("Nation", 65, 0));
            nationFilter = new NationMultiSelectionDropDown();
            nationFilter.x = 65;
            nationFilter.y = 17;
            nationFilter.addEventListener(ListEvent.INDEX_CHANGE, onIndexChange);
            addChild(nationFilter);

            addChild(createLabel("Class", 120, 0));
            classFilter = new ClassMultiSelectionDropDown();
            classFilter.x = 120;
            classFilter.y = 17;
            classFilter.addEventListener(ListEvent.INDEX_CHANGE, onIndexChange);
            addChild(classFilter);

            addChild(createLabel("Level", 175, 0));
            levelFilter = new LevelMultiSelectionDropDown();
            levelFilter.x = 175;
            levelFilter.y = 17;
            levelFilter.addEventListener(ListEvent.INDEX_CHANGE, onIndexChange);
            addChild(levelFilter);

            addChild(createLabel("Mastery", 230, 0));
            masteryFilter = new MasteryMultiSelectionDropDown();
            masteryFilter.x = 230;
            masteryFilter.y = 17;
            masteryFilter.addEventListener(ListEvent.INDEX_CHANGE, onIndexChange);
            addChild(masteryFilter);

            addChild(createLabel("Type", 285, 0));
            prefFilter = new PrefMultiSelectionDropDown();
            prefFilter.x = 285;
            prefFilter.y = 17;
            prefFilter.addEventListener(ListEvent.INDEX_CHANGE, onIndexChange);
            addChild(prefFilter);

            saveButton = App.utils.classFactory.getComponent("ButtonNormal", Button);
            saveButton.x = 340;
            saveButton.y = 17;
            saveButton.label = Locale.get("Save");*/
        }

        public function get filter():String
        {
            return filterTextInput.text;
        }

        public function set filter(value:String):void
        {
            filterTextInput.text = value;
        }

        public function setFocus():void
        {
            stage.focus = filterTextInput;
        }

        // PRIVATE

        private function createLabel(label:String, x:Number, y:Number):TextField
        {
            var l:TextField = new TextField();
            l.antiAliasType = AntiAliasType.ADVANCED;
            l.selectable = false;
            l.x = x;
            l.y = y;
            l.autoSize = TextFieldAutoSize.LEFT;
            l.height = 17;
            l.defaultTextFormat = new TextFormat("$FieldFont", 12, XfwConst.UICOLOR_LABEL);
            l.text = Locale.get(label);
            return l;
        }

        private function onKeyDown(e:KeyboardEvent):void
        {
            //if (e.keyCode == 27) // ESC
            //    dispatchEvent(e);
        }

        private function onChange(e:Event):void
        {
            dispatchEvent(new Event(Event.CHANGE));
        }

        private function onIndexChange(e:ListEvent):void
        {
            dispatchEvent(new Event(Event.CHANGE));
        }
    }

}
