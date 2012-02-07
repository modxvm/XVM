package components
{
	public class GroupView extends GroupComponent
	{
		public function GroupView()
		{
			super();
			width = 135;
			height = 62;
		}

		protected override function get title():String
		{
			return "Вид";
		}

		protected override function get elements():Array
		{
			return [
				{label:"Нормальный", path:"normal"},
				{label:"Расширенный", path:"extended"}
			];
		}
	}
}
