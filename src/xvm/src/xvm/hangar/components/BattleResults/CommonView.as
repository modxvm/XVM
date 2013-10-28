package xvm.hangar.components.BattleResults
{
    import com.xvm.*;
    import com.xvm.l10n.Locale;
    import com.xvm.utils.Utils;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormatAlign;
    import net.wg.gui.lobby.battleResults.CommonStats;
    import xvm.hangar.UI.battleResults.UI_BR_SubtaskComponent_UI;

    /**
     * @author Pavel Máca
     */
    public class CommonView
    {
        private const FIELD_POS_TITLE:String = "fieldPosTitle";
        private const FIELD_POS_NON_PREM:String = "fieldPosNonPrem";
        private const FIELD_POS_PREM:String = "fieldPosPrem";
        private const CSS_FIELD_CLASS:String = "xvm_bsField";

        private var view:CommonStats;

        private var shotsTitle:TextField;
        private var shotsCount:TextField;
        private var shotsPercent:TextField;
        private var damageAssistedTitle:TextField;
        private var damageAssistedValue:TextField;
        private var damageValue:TextField;

        public static function init(view:CommonStats):void
        {
            var instance:CommonView = new CommonView();
            instance.view = view;

            instance.compactQuests();

            if (Config.config.battleResults.showExtendedInfo)
            {
                instance.hideDetailBtn();
                instance.hideQuestLabel();
                instance.initTextFields();
                instance.setData(view.detailsMc.data);
            }

            if (Config.config.battleResults.showNetIncome)
                instance.showNetIncome(view.detailsMc.data);
        }

        private function compactQuests():void
        {
            // replace quest item renderer class
            UI_BR_SubtaskComponent_UI; // this make sure it's compiled
            view.questList.linkage = "xvm.UI.battleResults.UI_BR_SubtaskComponent_UI";

            // hide shadows
            view.upperShadow.visible = false;
            view.lowerShadow.visible = false;
        }

        private function hideDetailBtn():void
        {
            view.detailsMc.detailedReportBtn.visible = false;
        }

        private function hideQuestLabel():void
        {
            view.detailsMc.progressTF.visible = false;
        }

        private function showNetIncome(data:Object):void
        {
            view.detailsMc.creditsLbl.htmlText = data.creditsNoPremTotalStr;
            view.detailsMc.premCreditsLbl.htmlText = data.creditsPremTotalStr;
        }

        private function initTextFields():void
        {
            shotsTitle = this.createTextField(FIELD_POS_TITLE, 1);
            shotsCount = this.createTextField(FIELD_POS_NON_PREM, 1);
            shotsPercent = this.createTextField(FIELD_POS_PREM, 1);
            damageAssistedTitle = this.createTextField(FIELD_POS_TITLE, 2);
            damageAssistedValue = this.createTextField(FIELD_POS_NON_PREM, 2);
            damageValue = this.createTextField(FIELD_POS_PREM, 2);
        }

        private function createTextField(position:String, line:Number):TextField
        {
            var newTf:TextField = new TextField();
            var orig:TextField;
            switch (position)
            {
                case FIELD_POS_TITLE:
                    orig = view.detailsMc.xpTitleLbl;
                    newTf.autoSize = TextFieldAutoSize.LEFT;
                    break;
                case FIELD_POS_NON_PREM:
                    orig = view.detailsMc.xpLbl;
                    break;
                case FIELD_POS_PREM:
                    orig = view.detailsMc.premXpLbl;
                    break;
                default:
                    return null;
            }
            newTf.x = orig.x;
            newTf.alpha = 1;

            newTf.styleSheet = Utils.createTextStyleSheet(CSS_FIELD_CLASS, view.detailsMc.xpTitleLbl.defaultTextFormat);
            newTf.selectable = false;

            var y_space:Number = view.detailsMc.xpTitleLbl.height;
            var y_pos:Number = view.detailsMc.xpTitleLbl.y;

            newTf.y = y_pos + line * y_space;

            view.detailsMc.addChild(newTf);

            return newTf;
        }

        private function formatThousand(val:Number):String
        {
            return App.utils.locale.integer(val);
        }

        private function formatText(text:String, color:String, align:String = TextFormatAlign.LEFT):String
        {
            return "<p class='" + CSS_FIELD_CLASS + "' align='" + align + "'><font color='" + color + "'>" + text + "</font></p>";
        }

        private function setData(data:Object):void
        {
            shotsTitle.htmlText = formatText(Locale.get("Hit percent"), "#C9C9B6");
            shotsCount.htmlText = formatText(data.hits + "/" + data.shots, "#C9C9B6", TextFormatAlign.RIGHT);

            var hitPercent:Number;
            if (data.shots > 0)
                hitPercent = (data.hits / data.shots) * 100;
            else
                hitPercent = 0;
            shotsPercent.htmlText = formatText(App.utils.locale.float(hitPercent) + "%", "#C9C9B6", TextFormatAlign.RIGHT);

            damageAssistedTitle.htmlText = formatText(Locale.get("Damage (assisted / own)"), "#C9C9B6");
            damageAssistedValue.htmlText = formatText(formatThousand(data.damageAssisted), "#408CCF", TextFormatAlign.RIGHT);
            damageValue.htmlText = formatText(formatThousand(data.damageDealt), "#FFC133", TextFormatAlign.RIGHT);
        }

    }

}
