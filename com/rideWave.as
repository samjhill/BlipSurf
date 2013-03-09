package  com{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.utils.*;
	import flash.display.DisplayObjectContainer;
	
	public class rideWave extends MovieClip {
		
		private var stageRef:Stage;
		private var timer:Timer;
		
		public function rideWave(stageRef:Stage) 
		{
			//SMOOTH LINE TUTORIAL
			//http://www.wastedpotential.com/flash-as3-smooth-lines-with-the-drawing-api/
			
			this.stageRef = stageRef;
			
			//original position
			// x is constant
			x = stageRef.stage.mouseX;
			//follow the mouse at spawn
			y = stageRef.stage.mouseY;
			
			timer = new Timer(.01, 0);
			timer.addEventListener(TimerEvent.TIMER, moveLeft);
			timer.start();
		}
		
		public function moveLeft(e:Event):void
		{
			
			//move left at a constant spead
			this.x -= 5;
			//garbage collection after it reaches the stage's edge
			if(this.x < 0)
			{
				destroy(this);
			}
				
		}
		
		public function destroy(object:*):void
		{
			if(object.parent != null)
			{
				var parent:DisplayObjectContainer = object.parent;
				parent.removeChild(object);
			}
			
		}
	}
	
	
}
