package xvm.hangar.components.Profile
{
    import com.xvm.*;
    import com.xvm.components.*;
    import com.xvm.controls.*;
    import com.xvm.l10n.Locale;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.controls.Button;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.ListEvent;
    import xvm.hangar.components.Profile.*;

    // Filter     [level|v] [nation|v] [x] selection
    // [       ]  [class|v] [master|v] [x] premium     [SAVE]
    public class FilterControl extends Sprite
    {
        public var filterTextInput:TextInput;
        public var nationFilter:DropDown;
        public var classFilter:DropDown;
        public var levelFilter:DropDown;
        public var masteryFilter:DropDown;
        public var prefFilter:DropDown;
        public var saveButton:Button;

        public function FilterControl()
        {
            //width = 400;
            //height = 40;

            addChild(createLabel("Filter", 0, 0));
            filterTextInput = App.utils.classFactory.getComponent("TextInput", TextInput);
            filterTextInput.x = 0;
            filterTextInput.y = 17;
            filterTextInput.width = 65;
            filterTextInput.addEventListener(Event.CHANGE, onChange);
            addChild(filterTextInput);

            addChild(createLabel("Nation", 65, 0));
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
            saveButton.label = Locale.get("Save");
        }

        private function createLabel(label:String, x:Number, y:Number):TextField
        {
            var l:TextField = new TextField();
            l.antiAliasType = AntiAliasType.ADVANCED;
            l.selectable = false;
            l.x = x;
            l.y = y;
            l.autoSize = TextFieldAutoSize.LEFT;
            l.height = 17;
            l.defaultTextFormat = new TextFormat("$FieldFont", 12, Defines.UICOLOR_DEFAULT2);
            l.text = Locale.get(label);
            return l;
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
