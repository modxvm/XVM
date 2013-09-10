package net.wg.gui.utils 
{
    import net.wg.data.constants.*;
    
    public class ComplexTooltipHelper extends Object
    {
        public function ComplexTooltipHelper()
        {
            super();
            return;
        }

        public function addHeader(arg1:String, arg2:Boolean=false):net.wg.gui.utils.ComplexTooltipHelper
        {
            if (!(arg1 == null) && arg1.length > 0) 
            {
                if (arg2) 
                    arg1 = App.utils.locale.makeString(arg1);
                this.header = net.wg.data.constants.TooltipTags.HEADER_OPEN_TAG.concat(arg1, net.wg.data.constants.TooltipTags.HEADER_CLOSE_TAG);
            }
            return this;
        }

        public function addBody(arg1:String, arg2:Boolean=false):net.wg.gui.utils.ComplexTooltipHelper
        {
            if (!(arg1 == null) && arg1.length > 0) 
            {
                if (arg2) 
                    arg1 = App.utils.locale.makeString(arg1);
                this.body = net.wg.data.constants.TooltipTags.BODY_OPEN_TAG.concat(arg1, net.wg.data.constants.TooltipTags.BODY_CLOSE_TAG);
            }
            return this;
        }

        public function addNote(arg1:String, arg2:Boolean=false):net.wg.gui.utils.ComplexTooltipHelper
        {
            if (!(arg1 == null) && arg1.length > 0) 
            {
                if (arg2) 
                    arg1 = App.utils.locale.makeString(arg1);
                this.note = net.wg.data.constants.TooltipTags.NOTE_OPEN_TAG.concat(arg1, net.wg.data.constants.TooltipTags.NOTE_CLOSE_TAG);
            }
            return this;
        }

        public function make():String
        {
            return this.header.concat(this.body, this.note);
        }

        internal var header:String="";

        internal var body:String="";

        internal var note:String="";
    }
}
