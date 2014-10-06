package xvm.comments
{
    import com.xvm.*;
    import com.xvm.io.*;
    import flash.events.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.SoundButtonEx; // '*' conflicts with UI classes
    import net.wg.infrastructure.base.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;

    public class EditCommentView extends AbstractWindowView
    {
        private static const WINDOW_WIDTH:uint = 350;
        private static const WINDOW_HEIGHT:uint = 190;

        private var data:Object;

        private var playerNameField:LabelControl;
        private var textArea:TextAreaSimple;
        private var submitButton:SoundButtonEx;
        private var cancelButton:SoundButtonEx;

        public function EditCommentView(data:Object)
        {
            //Logger.add("EditCommentView");
            super();

            this.visible = true;
            this.isModal = false;
            this.isCentered = true;
            this.canClose = true;
            this.enabledCloseBtn = true;
            this.width = WINDOW_WIDTH;
            this.height = WINDOW_HEIGHT;

            this.data = data;

            onTryClosing = function():Boolean { return true; }
            onWindowClose = function():void { (window as EditCommentWindow).close(); }

            createControls();
        }

        override protected function configUI():void
        {
            //Logger.add("EditCommentView.configUI");
            super.configUI();

            textArea.addEventListener(Event.CHANGE, onTextChange);
            submitButton.addEventListener(MouseEvent.CLICK, onSumbitButtonClick);
            cancelButton.addEventListener(MouseEvent.CLICK, onWindowClose);

            App.utils.focusHandler.setFocus(textArea);
            textArea.text = CommentsGlobalData.instance.getComment(data.uid);
            onTextChange(null);
            textArea.validateNow();
            textArea.textField.setSelection(textArea.length, textArea.length);
        }

        override protected function onDispose():void
        {
            textArea.removeEventListener(Event.CHANGE, onTextChange);
            submitButton.removeEventListener(MouseEvent.CLICK, onSumbitButtonClick);
            cancelButton.removeEventListener(MouseEvent.CLICK, onWindowClose);
            super.onDispose();
        }

        override public function handleInput(e:InputEvent):void
        {
            if (!e.handled)
            {
                //Logger.addObject(e.details);
                if (e.details.value == InputValue.KEY_DOWN || e.details.value == InputValue.KEY_HOLD)
                {
                    switch (e.details.code)
                    {
                        case Keyboard.ESCAPE:
                            e.handled = true;
                            onWindowClose();
                            break;

                        case Keyboard.ENTER:
                            if (e.details.ctrlKey)
                            {
                                e.handled = true;
                                submitButton.dispatchEvent(new MouseEventEx(MouseEvent.CLICK));
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
                htmlText: "<font face='$TitleFont' size='18'>" + data.displayName + "</font>"
            })) as LabelControl;

            textArea = App.utils.classFactory.getComponent("TextAreaSimple", TextAreaSimple, {
                x: 0,
                y: 30,
                width: WINDOW_WIDTH - 30,
                height: WINDOW_HEIGHT - 45,
                maxChars: 1000
            });
            addChild(textArea);

            submitButton = App.utils.classFactory.getComponent("ButtonNormal", SoundButtonEx, {
                x: WINDOW_WIDTH - 205,
                y: WINDOW_HEIGHT - 21,
                width: 100,
                height: 25,
                soundType: "okButton",
                label: Locale.get("Save")
            });
            addChild(submitButton);

            cancelButton = App.utils.classFactory.getComponent("ButtonNormal", SoundButtonEx, {
                x: WINDOW_WIDTH - 100,
                y: WINDOW_HEIGHT - 21,
                width: 100,
                height: 25,
                soundType: "cancelButton",
                label: Locale.get("Cancel")
            });
            addChild(cancelButton);
        }

        private function onTextChange(e:Event):void
        {
            submitButton.label = textArea.text == null || textArea.text == "" ? Locale.get("Remove") : Locale.get("Save");
        }

        private function onSumbitButtonClick(e:MouseEventEx):void
        {
            //Logger.add("onSumbitButtonClick");
            try
            {
                if (e.buttonIdx == 0)
                {
                    CommentsGlobalData.instance.setComment(data.uid, textArea.text);
                    onWindowClose();
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
  "userName": "M_r_A",
  "himself": false,
  "chatRoster": 1,
  "displayName": "M_r_A",
  "group": "group_2",
  "colors": "8761728,6127961",
  "online": false,
  "uid": 7294494
}
*/
