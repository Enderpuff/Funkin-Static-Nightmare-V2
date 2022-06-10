package;

import flixel.FlxState;
import flixel.FlxGame;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import Sys;
import Random;

class CommandPromptState extends MusicBeatState
{
    var isLor:Bool = false;
    var lorThing:String = 'false';
    var advice:FlxText = new FlxText();
    var resetButton:FlxButton;
    var curImg:String;
    var displayingImg:Bool = false;
    var displayingImage:Bool = false;
    var cursorthing:FlxSprite = new FlxSprite();
    var cmdThing:InputText;
    var livecreepbfreaction:FlxSprite = new FlxSprite();
    var lor:FlxSprite = new FlxSprite();
    var summer:FlxSprite = new FlxSprite();
    var yeeb:FlxSprite = new FlxSprite();
    var juelz:FlxSprite = new FlxSprite();
    var miner:FlxSprite = new FlxSprite();
    var b3bf:FlxSprite = new FlxSprite();
    public var yoMamaMoment:Bool = false;
    public var yoMamaSuffix2:String;
    public var yoMamaSuffix:String;
    public var yoMamaJokes:Array<String> = [
      'so fat that ',
      'so dumb that ',
      'so stupid that ',
      'so british '
    ];
    public var yoMamaJokes2:Array<String> = [
      'she went to doctor to weigh herself and the doctor said: "That\'s my phone number!"',
      'she tough twitter was social media',
      'she went to hell'
    ];

    override public function create()
    {
        super.create();

        FlxG.sound.music.stop();
        FlxG.mouse.visible = false;

        advice = new FlxText(0, 100, 0, "(^In case you have any problem with the flixel text input)", 15);
        advice.font = "VCR OSD Mono";
        advice.color = 0xFF16C60C;
        add(advice);

        resetButton = new FlxButton(0, 75, 'Reset', function(){
            cmdReset();
        });

        summer.loadGraphic('assets/secretshit/cmdImages/summer.png');
        summer.alpha = 0;
        summer.screenCenter();

        yeeb.loadGraphic('assets/secretshit/cmdImages/yeeb.png');
        yeeb.alpha = 0;
        yeeb.screenCenter();

        lor.loadGraphic('assets/secretshit/cmdImages/lor.png');
        lor.alpha = 0;
        lor.screenCenter();

        juelz.loadGraphic('assets/secretshit/cmdImages/juelz.png');
        juelz.alpha = 0;
        juelz.screenCenter();
        
        livecreepbfreaction.loadGraphic('assets/secretshit/cmdImages/livecreepbfreaction.png');
        livecreepbfreaction.alpha = 0;
        livecreepbfreaction.screenCenter();

        b3bf.loadGraphic('assets/secretshit/cmdImages/b3real.png');
        b3bf.alpha = 0;
        b3bf.screenCenter();

		miner.loadGraphic('assets/secretshit/cmdImages/aiaiaiaiai.png');
        miner.screenCenter();
        miner.alpha = 0;

		cursorthing.loadGraphic('assets/secretshit/cmdCursor.png');

        cmdThing = new InputText(0, 0, 1280, 'C:/Users/YourPc/Downloads/StaticNightmare>', 20, 0xFF16C60C, FlxColor.TRANSPARENT, true);
        cmdThing.font = "VCR OSD Mono";
        cmdThing.y += 50;
        cmdThing.lines = 1;

        add(resetButton);
        add(cmdThing);
        add(summer);
        add(yeeb);
        add(lor);
        add(b3bf);
        add(miner);
        add(juelz);
        add(livecreepbfreaction);
        add(cursorthing);
    }


    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (yoMamaMoment){
            yoMamaJoke();
            yoMamaMoment = false;
        }

        cursorthing.x = FlxG.mouse.x;
        cursorthing.y = FlxG.mouse.y;

        if (FlxG.keys.justReleased.ESCAPE)
        {
            MusicBeatState.switchState(new MainMenuState());
            FlxG.sound.play(Paths.sound('cancelMenu'));
            FlxG.sound.playMusic(Paths.music('memories'));
        }

        if (FlxG.keys.justReleased.ENTER && !displayingImg)
        {
            switch (cmdThing.text)
            {
                case 'C:/Users/YourPc/Downloads/StaticNightmare>yo mama':
                    yoMamaMoment = true;
                case 'C:/Users/YourPc/Downloads/StaticNightmare>i have brain damage':
                    Sys.exit(0);
                    cmdReset();
                case 'C:/Users/YourPc/Downloads/StaticNightmare>eerie noise':
                    PlayState.SONG = Song.loadFromJson('mirror-hard', 'mirror-beta');
                    LoadingState.loadAndSwitchState(new PlayState());
                    cmdReset();
                case 'C:/Users/YourPc/Downloads/StaticNightmare>testicle':
                    PlayState.SONG = Song.loadFromJson('sideways-hard', 'sideways');
                    LoadingState.loadAndSwitchState(new PlayState());
                    cmdReset();
                #if windows
                case 'C:/Users/YourPc/Downloads/StaticNightmare>lime test windows' | 'C:/Users/YourPc/Downloads/StaticNightmare>lime test windows -debug':
                    Sys.command('directory.bat');
                    cmdReset();
                #end
                case 'C:/Users/YourPc/Downloads/StaticNightmare>exit' | 'C:/Users/YourPc/Downloads/StaticNightmare>quit' | 'C:/Users/YourPc/Downloads/StaticNightmare>perish' | 'C:/Users/YourPc/Downloads/StaticNightmare>die':
                    Sys.exit(0);
                    cmdReset();
                case 'C:/Users/YourPc/Downloads/StaticNightmare>b3':
                    new FlxTimer().start(0.3, function (tmr:FlxTimer) {
                        displayingImg = true;
                    });
                    FlxTween.tween(b3bf, {alpha: 1}, 0.3);
                    cmdReset();
                case 'C:/Users/YourPc/Downloads/StaticNightmare>crazy pizza':
                    new FlxTimer().start(0.3, function (tmr:FlxTimer) {
                        displayingImg = true;
                    });
                    FlxTween.tween(miner, {alpha: 1}, 0.3);
                    cmdReset();
                case 'C:/Users/YourPc/Downloads/StaticNightmare>live reaction':
                    new FlxTimer().start(0.3, function (tmr:FlxTimer) {
                        displayingImg = true;
                    });
                    FlxTween.tween(livecreepbfreaction, {alpha: 1}, 0.3);
                    cmdReset();
                case 'C:/Users/YourPc/Downloads/StaticNightmare>lor':
                    new FlxTimer().start(0.3, function (tmr:FlxTimer) {
                        displayingImg = true;
                    });
                    FlxTween.tween(lor, {alpha: 1}, 0.3);
                    lorThing = 'play';
                    isLor = true;
                    cmdReset();
                case 'C:/Users/YourPc/Downloads/StaticNightmare>summer':
                    new FlxTimer().start(0.3, function (tmr:FlxTimer) {
                        displayingImg = true;
                    });
                    FlxTween.tween(summer, {alpha: 1}, 0.3);
                    cmdReset();
                case 'C:/Users/YourPc/Downloads/StaticNightmare>yeeb':
                    new FlxTimer().start(0.3, function (tmr:FlxTimer) {
                        displayingImg = true;
                    });
                    FlxTween.tween(yeeb, {alpha: 1}, 0.3);
                    cmdReset();
                case 'C:/Users/YourPc/Downloads/StaticNightmare>juelz':
                    new FlxTimer().start(0.3, function (tmr:FlxTimer) {
                        displayingImg = true;
                    });
                    FlxTween.tween(juelz, {alpha: 1}, 0.3);
                    cmdReset();
            }
        }

        if (displayingImg && isLor){
            if (lorThing == 'play'){
                FlxG.sound.play('assets/secretshit/music/lor.ogg');
                lorThing = 'playing';
            }
        }

        if (lorThing == 'false'){
            FlxG.sound.destroy();
            lorThing == 'null';
        }

        if (FlxG.keys.justReleased.ENTER && displayingImg)
        {
            if (miner.alpha == 1){
                displayingImg = false;
                FlxTween.tween(miner, {alpha: 0}, 0.3);
            }
            else if (b3bf.alpha == 1){
                displayingImg = false;
                FlxTween.tween(b3bf, {alpha: 0}, 0.3);
            }
            else if (livecreepbfreaction.alpha == 1){
                displayingImg = false;
                FlxTween.tween(livecreepbfreaction, {alpha: 0}, 0.3);
            }
            else if (lor.alpha == 1){
                displayingImg = false;
                FlxTween.tween(lor, {alpha: 0}, 0.3);
                lorThing = 'false';
            }
            else if (summer.alpha == 1){
                displayingImg = false;
                FlxTween.tween(summer, {alpha: 0}, 0.3);
            }
            else if (yeeb.alpha == 1){
                displayingImg = false;
                FlxTween.tween(yeeb, {alpha: 0}, 0.3);
            }
            else if (juelz.alpha == 1){
                displayingImg = false;
                FlxTween.tween(juelz, {alpha: 0}, 0.3);
            }
        }
    }


    function cmdReset()
    {
        cmdThing.text = 'C:/Users/YourPc/Downloads/StaticNightmare>';
    }

    function cmdError()
    {
        cmdThing.text = 'C:/Users/YourPc/Downloads/StaticNightmare>';
        FlxG.sound.play(Paths.sound('cancelMenu'));
    }

    function yoMamaJoke()
    {
        yoMamaSuffix = Random.fromArray(yoMamaJokes);
        yoMamaSuffix2 = Random.fromArray(yoMamaJokes2);
        trace("Yo mama is " + yoMamaSuffix + yoMamaSuffix2);
    }
}
