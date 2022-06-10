package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxState;
import sys.FileSystem;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Cutscene extends FlxState
{
	public var counter:Float = 5;
	public var pressEnter:FlxText;
	public var timeRemaining:FlxText;
	public var skipCutsceneTxt:FlxText;
	public var skippedCutscene:Bool = false;
    public var endingSong:Bool = false;
    public var inCutscene:Bool = false;
    public var camHUD:FlxCamera;

    override public function create()
    {
        super.create();

        //setting up shit
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
        FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];
        PlayerSettings.init();
        ClientPrefs.loadPrefs();
		Highscore.load();
        FlxG.mouse.visible = false;

		skipCutsceneTxt = new FlxText(0, 0, -1, 'Would you like to skip the cutscene?', 32);
		skipCutsceneTxt.setFormat('VCR OSD Mono', 32, FlxColor.WHITE);
		skipCutsceneTxt.screenCenter();
		add(skipCutsceneTxt);

		timeRemaining = new FlxText(skipCutsceneTxt.x + 70, skipCutsceneTxt.y + 32, -1, '', 32);
		timeRemaining.setFormat('VCR OSD Mono', 32, FlxColor.WHITE);
		add(timeRemaining);

		pressEnter = new FlxText(0, 0, 'Press ENTER to skip', 32);
		pressEnter.y = 720 - pressEnter.height;
		pressEnter.screenCenter(X);
		pressEnter.setFormat('VCR OSD Mono', 32, FlxColor.WHITE);
		add(pressEnter);

        camHUD = new FlxCamera();
        FlxG.cameras.add(camHUD);
		FlxG.fullscreen = true;

		FlxTween.tween(pressEnter, {alpha: 0}, 0.3, {type: PINGPONG});
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

		if (!inCutscene || !skippedCutscene){
			counter -= elapsed;
		}

		timeRemaining.text = 'Cutscene will start in ' + flixel.util.FlxStringUtil.formatTime(counter);

		if (counter <= 0){
			counter = 100;
			remove(pressEnter);
			remove(timeRemaining);
			remove(skipCutsceneTxt);
			startVideo('opening_cutscene');
		}

		if (FlxG.keys.anyJustPressed([ENTER])){
			skippedCutscene = true;
			counter = 100;
			FlxG.switchState(new MainMenuState());
		}
    }

    public function startVideo(name:String):Void {
		#if VIDEOS_ALLOWED
		var foundFile:Bool = false;
		var fileName:String = #if MODS_ALLOWED Paths.modFolders('videos/' + name + '.' + Paths.VIDEO_EXT); #else ''; #end
		#if sys
		if(FileSystem.exists(fileName)) {
			foundFile = true;
		}
		#end

		if(!foundFile) {
			fileName = Paths.video(name);
			#if sys
			if(FileSystem.exists(fileName)) {
			#else
			if(OpenFlAssets.exists(fileName)) {
			#end
				foundFile = true;
			}
		}

		if(foundFile) {
			inCutscene = true;
			var bg = new FlxSprite(-FlxG.width, -FlxG.height).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
			bg.scrollFactor.set();
			bg.cameras = [camHUD];
			add(bg);

			(new FlxVideo(fileName)).finishCallback = function() {
				remove(bg);
                FlxG.switchState(new MainMenuState());
			}
			return;
		}
		else
		{
			FlxG.log.warn('Couldnt find video file: ' + fileName);
		}
		#end
	}
}