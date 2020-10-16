/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.contacts
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.TextInput; // '*' conflicts with UI classes
    import net.wg.gui.messenger.data.*;

    public class UI_EditContactDataView extends ContactNoteManageViewUI
    {
        private var userProps:ContactUserPropVO = null;

        private var nickLabel:LabelControl;
        private var nickTextInput:TextInput;
        private var commentLabel:LabelControl;
        private var commentTextArea:TextAreaSimple;

        public function UI_EditContactDataView()
        {
            //Logger.add("EditDataView");
            super();
        }

        override public function getComponentForFocus():InteractiveObject
        {
            return nickTextInput;
        }

        override public function getFocusChain():Vector.<InteractiveObject>
        {
            return new <InteractiveObject>[nickTextInput, commentTextArea].concat(super.getFocusChain());
        }

        override protected function configUI():void
        {
            //Logger.add("EditDataView.configUI");
            super.configUI();

            createControls();

            nickTextInput.addEventListener(Event.CHANGE, onDataChange, false, 0, true);
            commentTextArea.addEventListener(Event.CHANGE, onDataChange, false, 0, true);
        }

        override protected function onDispose():void
        {
            nickTextInput.removeEventListener(Event.CHANGE, onDataChange);
            commentTextArea.removeEventListener(Event.CHANGE, onDataChange);

            super.onDispose();
        }

        override public function as_setOkBtnEnabled(param1:Boolean):void
        {
            return; // disable original behavior
        }

        public function as_setUserProps_xvm(value:Object):void
        {
            //Logger.addObject(value, 2, "as_setUserProps");

            var xvm_contact_data:Object = value.xvm_contact_data;
            delete value.xvm_contact_data;

            userProps = new ContactUserPropVO(value);

            super.as_setUserProps(value);

            if (xvm_contact_data)
            {
                nickTextInput.text = xvm_contact_data.nick || value.userName;
                commentTextArea.text = xvm_contact_data.comment;
                //onDataChange(null);
            }
        }

        override public function onOkS(value:Object):void
        {
            App.utils.asserter.assertNotNull(this.onOk, "onOk" + Errors.CANT_NULL);
            this.onOk({
                nick: nickTextInput.text,
                comment: commentTextArea.text
            });
        }

        // PRIVATE

        private function createControls():void
        {
            input.enabled = false;
            input.visible = false;

            var x:Number = input.x;
            var y:Number = input.y + 5;
            var w:Number = input.width;

            nickLabel = addChild(App.utils.classFactory.getComponent("LabelControl", LabelControl, {
                x: x,
                y: y,
                width: 55,
                height: 30,
                text: Locale.get("Nick")
            })) as LabelControl;

            nickTextInput = addChild(App.utils.classFactory.getComponent("TextInput", TextInput, {
                x: x,
                y: y + 20,
                width: w,
                height: 30,
                maxChars: 50
            })) as TextInput;
            nickTextInput.focusable

            commentLabel = addChild(App.utils.classFactory.getComponent("LabelControl", LabelControl, {
                x: x,
                y: y + 55,
                width: w,
                height: 20,
                text: Locale.get("Comment")
            })) as LabelControl;

            commentTextArea = addChild(App.utils.classFactory.getComponent("TextAreaSimple", TextAreaSimple, {
                x: x,
                y: y + 80,
                width: w,
                height: 110,
                tabChildren: true,
                selectable: true,
                maxChars: 1000,
                showBgForm: true
            })) as TextAreaSimple;

            btns.y = y + 200;
        }

        private function onDataChange(e:Event):void
        {
            btns.btnOk.label = (nickTextInput.text || commentTextArea.text) ? Locale.get("Save") : Locale.get("Remove");
        }
    }
}
/*
userProps: {
  "tags": [
    "sub/none",
    "friend"
  ],
  "rgb": 13224374,
  "igrVspace": -4,
  "suffix": "",
  "prefix": "",
  "igrType": 0,
  "region": null,
  "clanAbbrev": null,
  "userName": "Ural4ik"
}
*/
