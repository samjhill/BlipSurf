package  com{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	
	public class main extends MovieClip {
		
		private var p:PlayerUnit;
		private var rwArray;
		private var timer:Timer;
		private var gameOver:Boolean;
		private var score:int;
		
		public function main() 
		{
			gotoAndStop("titleFrame");
			startButton.addEventListener(MouseEvent.MOUSE_DOWN, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			
		}
		public function keyHandler(e:KeyboardEvent):void
		{  
			//keyboard event handle
			if(e.keyCode == 39) //left arrow
			{
				p.velocityX += .5;
			}
			else if(e.keyCode == 37) //right arrow
			{
				p.velocityX -= .5;
			}
			else
			{
				p.velocityX *= p.friction;
			}
			
			if (e.keyCode == 38) //up arrow
			{
				p.velocityY -= 1;
				
				
			}
			else if (e.keyCode == 40) //down arrow
			{
				p.velocityY += .5;
				//trace(p.rotation);
				
				
			}
			
		}
		
		
		public function init(e:Event):void
		{
			
			rwArray = new Array();
			gameOver = false;
			//
			// initialize player
			//
			p = new PlayerUnit(stage);
			p.addEventListener(Event.ENTER_FRAME, onTrack);
			addChild(p);
			gotoAndStop("gameStartFrame");
			
			//
			// timer for loop
			//
			timer = new Timer(50, 0);
			timer.addEventListener(TimerEvent.TIMER, loop);
			timer.start();
			//
			
			//
			// set focus to stage
			// keyboard workaround
			//
			addEventListener(Event.ENTER_FRAME,focusStage);
			function focusStage(e:Event):void
			{
				stage.focus=stage;
			}
		}
		
		public function onTrack(e:Event):void
		{
			//
			//check for contact with rideWave
			rwArray.forEach(hit);
			function hit(element:*, index:Number, arr:Array):void
			{
				if(p.hitTestObject(element))
				{
					p.velocityY = 0;
					p.y = element.y;
				}
			}
			
		}
		
		//
		// Main game loop, loops every 100ms
		//
		public function loop(e:Event):void
		{
			
			//
			//create a lot of instances rideWave to make the track
			//
			if(gameOver == false)
			{
				var rw:rideWave = new rideWave(stage);
				rwArray.push(rw);
				addChild(rwArray[rwArray.length-1]);
				
			}
			//
			// SCORE HANDLING
			//  only gives the player points when he is in the air
			if(p.velocityY > 1 || p.velocityY < -1)
			{
				score += 1;
				scoreBox.text = score + "";
			}
			//
			// LOSE CONDITION
			//
			if(p.y >= 400)
			{
				//lose
				gameOver = true;
				restart();
			}
		}
		
		public function restart()
		{
			p.y = stage.stageHeight/2;
			timer.reset();
			score = 0;
			rwArray.length = 0;
			
			removeChild(p);
			//removeChild();
			
			gotoAndStop("titleFrame");
			startButton.addEventListener(MouseEvent.MOUSE_DOWN, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
		}
		
	}
	
}
