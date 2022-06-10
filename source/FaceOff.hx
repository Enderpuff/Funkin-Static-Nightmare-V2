package;

import flixel.tweens.FlxTween;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxG;

class FaceOff extends FlxSubState
{
    var creep:FlxSprite = new FlxSprite();

    override public function create()
    {
        super.create();

        creep = new FlxSprite(-265, -350);
        creep.frames = Paths.getSparrowAtlas('mainmenu/menu_creep');
        creep.animation.addByPrefix('idle', "creep idle", 5);
        creep.animation.play('idle');
        creep.setGraphicSize(Std.int(creep.width * 0.7));
        add(creep);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER){
            PlayState.SONG = Song.loadFromJson('face-off-hard', 'face-off');
            LoadingState.loadAndSwitchState(new PlayState(), true);
        }

        if (FlxG.keys.anyJustPressed([S, DOWN, F])){
            close();
        }
    }

    override public function close()
    {
        super.close();
        SecretMenu.buttons.forEach(function(spr:FlxSprite)
		{
            switch (spr.ID)
            {
                case 0:
                    FlxTween.tween(spr, {y: 170}, 0.1);
                case 1:
                    FlxTween.tween(spr, {y: 340}, 0.1);
            }
		});
    }
}