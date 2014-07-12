package net.wg.gui.utils
{
    import net.wg.data.constants.TooltipTags;
    
    public class ComplexTooltipHelper extends Object
    {
        
        public function ComplexTooltipHelper() {
            super();
        }
        
        private var header:String = "";
        
        private var body:String = "";
        
        private var note:String = "";
        
        public function addHeader(param1:String, param2:Boolean = false) : ComplexTooltipHelper {
            if(!(param1 == null) && param1.length > 0)
            {
                if(param2)
                {
                    param1 = App.utils.locale.makeString(param1);
                }
                this.header = TooltipTags.HEADER_OPEN_TAG.concat(param1,TooltipTags.HEADER_CLOSE_TAG);
            }
            return this;
        }
        
        public function addBody(param1:String, param2:Boolean = false) : ComplexTooltipHelper {
            if(!(param1 == null) && param1.length > 0)
            {
                if(param2)
                {
                    param1 = App.utils.locale.makeString(param1);
                }
                this.body = TooltipTags.BODY_OPEN_TAG.concat(param1,TooltipTags.BODY_CLOSE_TAG);
            }
            return this;
        }
        
        public function addNote(param1:String, param2:Boolean = false) : ComplexTooltipHelper {
            if(!(param1 == null) && param1.length > 0)
            {
                if(param2)
                {
                    param1 = App.utils.locale.makeString(param1);
                }
                this.note = TooltipTags.NOTE_OPEN_TAG.concat(param1,TooltipTags.NOTE_CLOSE_TAG);
            }
            return this;
        }
        
        public function make() : String {
            return this.header.concat(this.body,this.note);
        }
    }
}
