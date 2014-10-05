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
        private var data:Object;

        private var playerNameField:LabelControl;
        private var textArea:TextAreaSimple;
        private var cancelButton:SoundButtonEx;
        private var submitButton:SoundButtonEx;

        public function EditCommentView(data:Object)
        {
            //Logger.add("EditCommentView");
            super();

            this.visible = true;
            this.width = 300;
            this.height = 190;

            this.data = data;

            onTryClosing = function():Boolean { return true; }
            onWindowClose = function():void { (window as EditCommentWindow).close(); }

            createControls();
        }

        override protected function configUI():void
        {
            //Logger.add("EditCommentView.configUI");
            super.configUI();

            cancelButton.addEventListener(MouseEvent.CLICK, onWindowClose);
            submitButton.addEventListener(MouseEvent.CLICK, onSumbitButtonClick);

            App.utils.focusHandler.setFocus(textArea);
            textArea.text = CommentsGlobalData.instance.getComment(data.uid);
            textArea.position = textArea.text.length;
        }

        override protected function onDispose():void
        {
            cancelButton.removeEventListener(MouseEvent.CLICK, onWindowClose);
            submitButton.removeEventListener(MouseEvent.CLICK, onSumbitButtonClick);
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
                width: 270,
                height: 145,
                maxChars: 250
            });
            addChild(textArea);

            cancelButton = App.utils.classFactory.getComponent("ButtonNormal", SoundButtonEx, {
                x: 95,
                y: 170,
                width: 100,
                height: 25,
                soundType: "cancelButton",
                label: App.utils.locale.makeString("#dialogs:controlsWrongNotification/cancel")
            });
            addChild(cancelButton);

            submitButton = App.utils.classFactory.getComponent("ButtonNormal", SoundButtonEx, {
                x: 200,
                y: 170,
                width: 100,
                height: 25,
                soundType: "okButton",
                label: App.utils.locale.makeString("#dialogs:controlsWrongNotification/submit"),
                selected: true
            });
            addChild(submitButton);
        }

        private function onSumbitButtonClick(e:MouseEventEx):void
        {
            Logger.add("onSumbitButtonClick");
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
