package net.wg.mock
{
    import net.wg.utils.IViewRestrictions;
    import net.wg.data.daapi.ViewRestrictionVO;

    public class MockViewRestrictions extends Object implements IViewRestrictions
    {

        public function MockViewRestrictions()
        {
            super();
        }

        public function updateRestrictions(param1:String, param2:ViewRestrictionVO) : void
        {
        }

        public function dispose() : void
        {
        }

        public function get topOffset() : int
        {
            return 0;
        }

        public function get bottomOffset() : int
        {
            return 0;
        }

        public function get rightOffset() : int
        {
            return 0;
        }

        public function get leftOffset() : int
        {
            return 0;
        }

        public function get verticalOffset() : int
        {
            return 0;
        }

        public function get horizontalOffset() : int
        {
            return 0;
        }
    }
}
