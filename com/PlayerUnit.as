package  com{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Stage;
	
	public class PlayerUnit extends MovieClip {
		private var key:KeyboardEvent;
		//
		// FIX THIS
		//
		private var stageRef:Stage;
		private var gravity:Number = .7;
		public var velocityX:Number = 0;
		public var velocityY:Number = 0;
		public var maxSpeedG:Number = 4;
		public var maxSpeed:Number = 2;
		public var friction:Number = .92;
		//
		private var isChild:Boolean = false;
		
		public function PlayerUnit(stageRef:Stage) 
		{
			this.stageRef = stageRef;
			x = stageRef.mouseX; // makes sure the player doesn't fall to his death immediately
			y = stageRef.stageHeight/2;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		public function loop(e:Event):void
		{
			velocityY += gravity;
			y += velocityY;
			x += velocityX;
			
			//handle velocity Y
			if(velocityY > maxSpeedG)
			{
				velocityY = maxSpeedG;
				if(this.rotation < 10)
					this.rotation += 1;
			}
			else if(velocityY < -maxSpeed)
			{
				velocityY = -maxSpeed;
				if(this.rotation > -10)
					this.rotation += -1;
			}
			
			//handle velocity X
			if(velocityX > maxSpeedG)
			{
				velocityX = maxSpeedG;
			}
			else if(velocityX < -maxSpeed)
			{
				velocityX = -maxSpeed;
			}
			
			if(velocityX > 0)
			{
				scaleX = 1;
			}
			else if(velocityX < 0)
			{
				
				scaleX = -1;
			}
			
			if(y > stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				velocityY = 0;
			}
			
			
			
		}
		
		
	}
	
	
}
