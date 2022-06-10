package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSubState;
import flixel.FlxG;

class SecretMenu extends MusicBeatState
{
    public var daButtons:Array<String> =[
    'extras',
    'command'
    ];

	public static var instance:SecretMenu;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
    public static var button:FlxSprite;
    public static var buttons:FlxTypedGroup<FlxSprite>;
    var offset:Float;
    var scale:Float = 1;
	public var currentSel:Int = 0;
	var enteredSubMenu:Bool = false;

    override function create()
    {
        super.create();

		instance = this;

        MainMenuState.selectedSomethin = true;

		buttons = new FlxTypedGroup<FlxSprite>();
		add(buttons);

		currentSel = 0;

	    for (i in 0...daButtons.length)
	    {
		    offset = 108 - (Math.max(daButtons.length, 4) - 4) * 80;
		    button = new FlxSprite(0, (i * 170) + offset);
		    button.scale.x = scale;
		    button.scale.y = scale;
			button.frames = Paths.getSparrowAtlas('mainmenu/menu_' + daButtons[i]);
			button.animation.addByPrefix('idle', daButtons[i] + " basic", 24);
			button.animation.addByPrefix('selected', daButtons[i] + " white", 24);
			button.animation.play('idle');
			button.ID = i;
			buttons.add(button);
			//button.x += 370;
			button.screenCenter(X);
			var scr:Float = (daButtons.length - 4) * 0.135;
			if (daButtons.length < 6)
				scr = 0;
			button.scrollFactor.set(0, scr);
			button.antialiasing = ClientPrefs.globalAntialiasing;
			button.updateHitbox();
        }

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);   

		FlxG.camera.follow(camFollowPos, null, 1);

		changeItem();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!enteredSubMenu)
		{
			if (FlxG.keys.anyJustPressed([W, UP, J]))
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.anyJustPressed([S, DOWN, F]))
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (FlxG.keys.justPressed.RIGHT)
			{
				MusicBeatState.switchState(new MainMenuState());
				MainMenuState.cameFromSecret = true;
				MainMenuState.selectedSomethin = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
			}

			if (FlxG.keys.justPressed.ENTER)
            {
				enteredSubMenu = true;

				buttons.forEach(function(spr:FlxSprite)
				{
					if (currentSel != spr.ID)
					{
						FlxTween.tween(spr, {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
					}
					else
					{
						FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
						{
							var daChoice:String = daButtons[currentSel];

							switch (daChoice)
							{
								case 'extras':
									MusicBeatState.switchState(new options.OptionsState());
									options.OptionsState.secretMenu = true;
                                case 'command':
									MusicBeatState.switchState(new CommandPromptState());
							}
						});
					}
				});
            }
        }
    }

	public function changeItem(huh:Int = 0)
	{
		currentSel += huh;

		if (currentSel >= daButtons.length)
			currentSel = 0;
		if (currentSel < 0)
			buttons.forEach(function(spr:FlxSprite)
			{
				FlxTween.tween(spr, {y: 2000}, 0.1);
				new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					openSubState(new FaceOff());
				});
			});

			buttons.forEach(function(spr:FlxSprite)
			{
				spr.animation.play('idle');
				spr.updateHitbox();
		
				if (spr.ID == currentSel)
				{
					spr.animation.play('selected');
					spr.centerOffsets();
				}
			});
	}

	override public function openSubState(SubState:FlxSubState):Void
	{
		super.openSubState(SubState);
	}
}