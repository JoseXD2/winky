package;

/// Code created by Rozebud for FPS Plus (thanks rozebud)
// modified by KadeDev for use in Kade Engine/Tricky

import flixel.util.FlxAxes;
import flixel.FlxSubState;
import Options.Option;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.input.FlxKeyManager;


using StringTools;

class KeyBindMenu extends FlxSubState
{

    var keyTextDisplay:FlxText;
    var keyWarning:FlxText;
    var warningTween:FlxTween;
    var keyText:Array<String> = ["LEFT", "DOWN", "UP", "RIGHT","8KEY LEFT1", "8KEY DOWN1", "8KEYUP1", "8KEY RIGHT","8KEY LEFT2", "8KEY DOWN2", "8KEYUP2", "8KEY RIGHT2"];
    var keyText2:Array<String> = ["LEFT", "DOWN", "UP", "RIGHT","A", "S", "W", "D","J","K","I","L"];
    var defaultKeys:Array<String> = ["LEFT", "DOWN", "UP", "RIGHT","A", "S", "W", "D","J","K","I","L"];
    var curSelected:Int = 0;

    var keys:Array<String> = [FlxG.save.data.leftBind,
                              FlxG.save.data.downBind,
                              FlxG.save.data.upBind,
                              FlxG.save.data.rightBind,
                              (FlxG.save.data.eleftBind != null ? FlxG.save.data.eleftBind : "A"),    
                              (FlxG.save.data.edownBind != null ? FlxG.save.data.edownBind : "S"),
                              (FlxG.save.data.eupBind != null ? FlxG.save.data.eupBind : "W"),
                              (FlxG.save.data.erightBind != null ? FlxG.save.data.erightBind : "D"),
                              (FlxG.save.data.seleftBind != null ? FlxG.save.data.seleftBind : "J"),    
                              (FlxG.save.data.sedownBind != null ? FlxG.save.data.sedownBind : "K"),
                              (FlxG.save.data.seupBind != null ? FlxG.save.data.seupBind : "I"),
                              (FlxG.save.data.serightBind != null ? FlxG.save.data.serightBind : "L")
                              ];
    var tempKey:String = "";
    var blacklist:Array<String> = ["ESCAPE", "ENTER", "BACKSPACE", "SPACE"];

    var blackBox:FlxSprite;
    var infoText:FlxText;

    var state:String = "select";

	override function create()
	{	

        for (i in 0...keys.length)
        {
            var k = keys[i];
            if (k == null)
                keys[i] = defaultKeys[i];
        }
	
		//FlxG.sound.playMusic('assets/music/configurator' + TitleState.soundExt);

		persistentUpdate = persistentDraw = true;

        keyTextDisplay = new FlxText(-10, 0, 1280, "", 72);
		keyTextDisplay.scrollFactor.set(0, 0);
		keyTextDisplay.setFormat("VCR OSD Mono", 42, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		keyTextDisplay.borderSize = 2;
		keyTextDisplay.borderQuality = 3;

        blackBox = new FlxSprite(0,0).makeGraphic(FlxG.width,FlxG.height,FlxColor.BLACK);
        add(blackBox);

        infoText = new FlxText(-10, 620, 1280, "(Escape to save, backspace to leave without saving)", 72);
		infoText.scrollFactor.set(0, 0);
		infoText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoText.borderSize = 2;
		infoText.borderQuality = 3;
        infoText.alpha = 0;
        infoText.screenCenter(FlxAxes.X);
        add(infoText);
        add(keyTextDisplay);

        blackBox.alpha = 0;
        keyTextDisplay.alpha = 0;

        FlxTween.tween(keyTextDisplay, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(infoText, {alpha: 1}, 1.4, {ease: FlxEase.expoInOut});
        FlxTween.tween(blackBox, {alpha: 0.7}, 1, {ease: FlxEase.expoInOut});

        OptionsMenu.instance.acceptInput = false;

        textUpdate();

		super.create();
	}

	override function update(elapsed:Float)
	{

        switch(state){

            case "select":
                if (FlxG.keys.justPressed.UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}

				if (FlxG.keys.justPressed.DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}

                if (FlxG.keys.justPressed.ENTER){
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    state = "input";
                }
                else if(FlxG.keys.justPressed.ESCAPE){
                    quit();
                }
				else if (FlxG.keys.justPressed.BACKSPACE){
                    reset();
                }

            case "input":
                tempKey = keys[curSelected];
                keys[curSelected] = "?";
                textUpdate();
                state = "waiting";

            case "waiting":
                if(FlxG.keys.justPressed.ESCAPE){
                    keys[curSelected] = tempKey;
                    state = "select";
                    FlxG.sound.play(Paths.sound('confirmMenu'));
                }
                else if(FlxG.keys.justPressed.ENTER){
                    addKey(defaultKeys[curSelected]);
                    save();
                    state = "select";
                }
                else if(FlxG.keys.justPressed.ANY){
                    addKey(FlxG.keys.getIsDown()[0].ID.toString());
                    save();
                    state = "select";
                }


            case "exiting":


            default:
                state = "select";

        }

        if(FlxG.keys.justPressed.ANY)
			textUpdate();

		super.update(elapsed);
		
	}

    function textUpdate(){

        keyTextDisplay.text = "\n\n";

        for(i in 0...12){

            var textStart = (i == curSelected) ? "> " : "  ";
            keyTextDisplay.text += textStart + keyText[i] + ": " + ((keys[i] != keyText[i]) ? (keys[i] + " / ") : "" ) + keyText2[i] + " KEY\n";

        }

        keyTextDisplay.screenCenter();

    }

    function save(){

        FlxG.save.data.upBind = keys[2];
        FlxG.save.data.downBind = keys[1];
        FlxG.save.data.leftBind = keys[0];
        FlxG.save.data.rightBind = keys[3];
        FlxG.save.data.eupBind = keys[6];
        FlxG.save.data.edownBind = keys[5];
        FlxG.save.data.eleftBind = keys[4];
        FlxG.save.data.erightBind = keys[7];
        FlxG.save.data.seupBind = keys[10];
        FlxG.save.data.sedownBind = keys[9];
        FlxG.save.data.seleftBind = keys[8];
        FlxG.save.data.serightBind = keys[11];

        FlxG.save.flush();

        PlayerSettings.player1.controls.loadKeyBinds();

    }

    function reset(){

        for(i in 0...5){
            keys[i] = defaultKeys[i];
        }
        quit();

    }

    function quit(){

        state = "exiting";

        save();

        OptionsMenu.instance.acceptInput = true;
        trace('ee eup' + FlxG.save.data.eupBind); 
        trace('ee edown' + FlxG.save.data.edownBind);
        FlxTween.tween(keyTextDisplay, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(blackBox, {alpha: 0}, 1.1, {ease: FlxEase.expoInOut, onComplete: function(flx:FlxTween){close();}});
        FlxTween.tween(infoText, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
    }


	function addKey(r:String){

        var shouldReturn:Bool = true;

        var notAllowed:Array<String> = [];

        for(x in blacklist){notAllowed.push(x);}

        trace(notAllowed);

        for(x in 0...keys.length)
            {
                var oK = keys[x];
                if(oK == r)
                    keys[x] = null;
                if (notAllowed.contains(oK))
                    return;
            }

        if(shouldReturn){
            keys[curSelected] = r;
            FlxG.sound.play(Paths.sound('scrollMenu'));
        }
        else{
            keys[curSelected] = tempKey;
            FlxG.sound.play(Paths.sound('scrollMenu'));
            keyWarning.alpha = 1;
            warningTween.cancel();
            warningTween = FlxTween.tween(keyWarning, {alpha: 0}, 0.5, {ease: FlxEase.circOut, startDelay: 2});
        }

	}

    function changeItem(_amount:Int = 0)
    {
        curSelected += _amount;
                
        if (curSelected > 11)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = 11;
    }
}
