package components
{
	public class GroupStatus extends GroupComponent
	{
		public function GroupStatus()
		{
			super();
			width = 135;
			height = 64;
		}

		protected override function get title():String
		{
			return "Статус";
		}
		
		protected override function get elements():Array
		{
			return [
				{label:"Живой", path:"alive"},
				{label:"Мертвый", path:"dead"}
			];
		}
	}
}