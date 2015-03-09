package xvm.comments.UI
{
    import com.xvm.*;
    import com.xvm.components.*;
    import com.xvm.io.*;
    import flash.events.*;
    import flash.ui.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.SoundButtonEx; // '*' conflicts with UI classes
    import net.wg.gui.components.controls.TextInput;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    import xvm.comments.*;
    import xvm.comments.data.*;

    public class UI_EditContactDataView extends ContactNoteManageViewUI implements IUpdatable
    {
        private static const WINDOW_WIDTH:uint = 350;
        private static const WINDOW_HEIGHT:uint = 240;

        private var data:Object;

        private var playerNameField:LabelControl;
        private var nickLabel:LabelControl;
        private var nickTextInput:TextInput;
        private var commentLabel:LabelControl;
        private var commentTextArea:TextAreaSimple;
        private var submitButton:SoundButtonEx;
        private var cancelButton:SoundButtonEx;

        public function UI_EditContactDataView()
        {
            //Logger.add("EditDataView");
            super();
        }

        override public function update(data:Object):void
        {
            super.update(data);

            this.visible = true;
            /*this.isModal = false;
            this.isCentered = true;
            this.canClose = true;
            this.enabledCloseBtn = true;
            this.width = WINDOW_WIDTH;
            this.height = WINDOW_HEIGHT;
            this.tabChildren = true;

            this.data = data;

            this.as_config = { type: ContainerTypes.WINDOW };

            onTryClosing = function():Boolean { return true; }
            onWindowClose = function():void { (window as EditDataWindow).close(); }

            createControls();*/
        }

        override protected function configUI():void
        {
            //Logger.add("EditDataView.configUI");
            super.configUI();

            /*window.title = Locale.get("Edit data");

            nickTextInput.addEventListener(Event.CHANGE, onDataChange);
            commentTextArea.addEventListener(Event.CHANGE, onDataChange);
            submitButton.addEventListener(ButtonEvent.CLICK, onSumbitButtonClick);
            cancelButton.addEventListener(ButtonEvent.CLICK, onWindowClose);

            var pd:Object = CommentsGlobalData.instance.getPlayerData(data.uid);
            nickTextInput.text = (pd != null && pd.nick != null && pd.nick != "") ? pd.nick : data.userName;
            if (pd != null)
            {
                commentTextArea.text = pd.comment;
            }

            onDataChange(null);

            commentTextArea.validateNow();
            commentTextArea.textField.setSelection(commentTextArea.length, commentTextArea.length);

            setFocus(nickTextInput);*/
        }

        override protected function onDispose():void
        {
            /*nickTextInput.removeEventListener(Event.CHANGE, onDataChange);
            commentTextArea.removeEventListener(Event.CHANGE, onDataChange);
            submitButton.removeEventListener(ButtonEvent.CLICK, onSumbitButtonClick);
            cancelButton.removeEventListener(ButtonEvent.CLICK, onWindowClose);
            super.onDispose();*/
        }

        override public function handleInput(e:InputEvent):void
        {
            if (!e.handled)
            {
                //Logger.addObject(e.details);
                if (e.details.value == InputValue.KEY_DOWN /*|| e.details.value == InputValue.KEY_HOLD*/)
                {
                    switch (e.details.code)
                    {
                        case Keyboard.ESCAPE:
                            e.handled = true;
                            //onWindowClose();
                            break;

                        case Keyboard.ENTER:
                            if (e.details.ctrlKey)
                            {
                                e.handled = true;
                                submitButton.dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
                            }
                            break;
                    }
                }
            }

            super.handleInput(e);
        }

        // PRIVATE

        private function createControls():void
        {
            playerNameField = addChild(App.utils.classFactory.getComponent("LabelControl", LabelControl, {
                x: 5,
                y: -2,
                width: this.width,
                height: 30,
                htmlText: "<font face='$TitleFont' size='18'>" + data.userName + "</font>"
            })) as LabelControl;

            nickLabel = addChild(App.utils.classFactory.getComponent("LabelControl", LabelControl, {
                x: 0,
                y: 30,
                width: 55,
                height: 30,
                text: Locale.get("Nick")
            })) as LabelControl;

            nickTextInput = addChild(App.utils.classFactory.getComponent("TextInput", TextInput, {
                x: 60,
                y: 25,
                width: WINDOW_WIDTH - 60,
                height: 30,
                maxChars: 50
            })) as TextInput;

            commentLabel = addChild(App.utils.classFactory.getComponent("LabelControl", LabelControl, {
                x: 0,
                y: 55,
                width: WINDOW_WIDTH,
                height: 20,
                text: Locale.get("Comment")
            })) as LabelControl;

            commentTextArea = addChild(App.utils.classFactory.getComponent("TextAreaSimple", TextAreaSimple, {
                x: 0,
                y: 80,
                width: WINDOW_WIDTH,
                height: WINDOW_HEIGHT - 95,
                tabChildren: true,
                selectable: true,
                maxChars: 1000
            })) as TextAreaSimple;

            submitButton = addChild(App.utils.classFactory.getComponent("ButtonNormal", SoundButtonEx, {
                x: WINDOW_WIDTH - 205,
                y: WINDOW_HEIGHT - 22,
                width: 100,
                height: 25,
                soundType: "okButton",
                label: Locale.get("Save")
            })) as SoundButtonEx;

            cancelButton = addChild(App.utils.classFactory.getComponent("ButtonNormal", SoundButtonEx, {
                x: WINDOW_WIDTH - 100,
                y: WINDOW_HEIGHT - 22,
                width: 100,
                height: 25,
                soundType: "cancelButton",
                label: Locale.get("Cancel")
            })) as SoundButtonEx;
        }

        private function onDataChange(e:Event):void
        {
            submitButton.label =
                (nickTextInput.text == null || nickTextInput.text == "") &&
                (commentTextArea.text == null || commentTextArea.text == "")
                ? Locale.get("Remove") : Locale.get("Save");
        }

        private function onSumbitButtonClick(e:ButtonEvent):void
        {
            Logger.add("onSumbitButtonClick");
            try
            {
                Logger.addObject(e);
                if (e.buttonIdx == 0)
                {
                    CommentsGlobalData.instance.setPlayerData(
                        data.uid,
                        new PlayerCommentData(
                            nickTextInput.text == data.userName ? null : nickTextInput.text,
                            commentTextArea.text));
                    //onWindowClose();
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }
}
/*
data: {
  "uid": 7294494,
  "userName": "M_r_A"
}
*/
