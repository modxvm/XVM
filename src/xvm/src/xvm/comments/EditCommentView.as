package xvm.comments
{
    import com.xvm.*;
    import net.wg.infrastructure.base.*;

    public class EditCommentView extends AbstractWindowView
    {
        private var data:Object;

        public function EditCommentView(data:Object)
        {
            //Logger.add("EditCommentView");
            super();

            this.width = 300;
            this.height = 200;

            this.data = data;
        }

        override protected function configUI():void
        {
            //Logger.add("EditCommentView.configUI");
            super.configUI();

            window.title = Locale.get("Comment") + ": " + data.displayName;
            window.useBottomBtns = true;
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
