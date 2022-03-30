 package;

import flixel.addons.effects.FlxSkewedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end
import PlayState;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;
	public var noteType:Int = 0;
	public var mustPress:Bool = false;
	public var intensenote:Bool = false;
	public var jumpscare:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var iseight:Bool = false;
	public var prevNote:Note;
	public var modifiedByLua:Bool = false;
	public var netherrackvisible:Bool = false;
	public var sustainLength:Float = 0;
	public static var noteScale:Float = 0.7;
	public var isSustainNote:Bool = false;
	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var rating:String = "shit";

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false)
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime;
		jumpscare = noteData > 7 && noteData < 15;
		intensenote = noteData > 15;
		if(noteData > 15){jumpscare = false;}
		if(intensenote){jumpscare = false;}
		if (this.strumTime < 0 )
			this.strumTime = 0;
		
		switch(PlayState.SONG.noteStyle){
			default:
			this.noteData = noteData % 4;
			case 'eightnotes':
			this.noteData = noteData % 8;
			intensenote = false;
			jumpscare = false;
		}
	
		if(intensenote){noteData -= 8;}
				if(PlayState.SONG.noteStyle == 'eightnotes'){
			noteScale = 0.6;
			swagWidth = 160 * 0.58;
		}else{noteScale = 0.7; swagWidth = 160 * 0.7;}
		var daStage:String = PlayState.curStage;
		
		switch (PlayState.SONG.noteStyle)
		{
			case 'pixel':
				loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels','week6'), true, 17, 17);

				animation.add('greenScroll', [6]);
				animation.add('redScroll', [7]);
				animation.add('blueScroll', [5]);
				animation.add('purpleScroll', [4]);

				if (isSustainNote)
				{
					loadGraphic(Paths.image('weeb/pixelUI/arrowEnds','week6'), true, 7, 6);

					animation.add('purpleholdend', [4]);
					animation.add('greenholdend', [6]);
					animation.add('redholdend', [7]);
					animation.add('blueholdend', [5]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				case 'eightnotes':
				jumpscare = false;
				intensenote = false;
				frames = Paths.getSparrowAtlas('NOTE_assets');
				if(noteData % 4 > 3){iseight = true;}
				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');

				setGraphicSize(Std.int(width * noteScale));
				updateHitbox();
				antialiasing = true;
			default:
			
				frames = Paths.getSparrowAtlas('NOTE_assets');
								if(jumpscare){
						if(daStage == 'minecraft'){
						frames = Paths.getSparrowAtlas('netherrack', "shared");
						animation.addByPrefix('nethclear', 'netherrackclear');
						animation.addByPrefix('nethvis', 'netherrackvis');
						animation.play('nethclear');
						}else{
						frames = Paths.getSparrowAtlas('NOTE_static', "shared");}
					}
								if(intensenote){
						if(daStage == 'minecraft'){
						frames = Paths.getSparrowAtlas('fire', "shared");
						}else{
						frames = Paths.getSparrowAtlas('NOTE_intense', "shared");}
									
					}
				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');

				setGraphicSize(Std.int(width * noteScale));
				updateHitbox();
				antialiasing = true;
		}
		switch (PlayState.SONG.noteStyle){
		default:
				if(PlayState.curStage == 'minecraft' && jumpscare && !netherrackvisible){}else{
		switch (noteData % 4)
		{
			case 0:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('blueScroll');
			case 2:
				x += swagWidth * 2;
				animation.play('greenScroll');
			case 3:
				x += swagWidth * 3;
				animation.play('redScroll');
		}}
		case eightnotes:
		switch (noteData % 8)
		{
			case 0:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('blueScroll');
			case 2:
				x += swagWidth * 2;
				animation.play('greenScroll');
			case 3:
				x += swagWidth * 3;
				animation.play('redScroll');
			case 4:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 5:
				x += swagWidth * 1;
				animation.play('blueScroll');
			case 6:
				x += swagWidth * 2;
				animation.play('greenScroll');
			case 7:
				x += swagWidth * 3;
				animation.play('redScroll');

		}
		}
		// trace(prevNote);

		// we make sure its downscroll and its a SUSTAIN NOTE (aka a trail, not a note)
		// and flip it so it doesn't look weird.
		// THIS DOESN'T FUCKING FLIP THE NOTE, CONTRIBUTERS DON'T JUST COMMENT THIS OUT JESUS
		if (FlxG.save.data.downscroll && sustainNote) 
			flipY = true;

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;

			switch (noteData % 8)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
				case 6:
					animation.play('greenholdend');
				case 7:
					animation.play('redholdend');
				case 5:
					animation.play('blueholdend');
				case 4:
					animation.play('purpleholdend');
			}

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
					case 4:
						prevNote.animation.play('purplehold');
					case 5:
						prevNote.animation.play('bluehold');
					case 6:
						prevNote.animation.play('greenhold');
					case 7:
						prevNote.animation.play('redhold');
				}


				if(FlxG.save.data.scrollSpeed != 1)
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * FlxG.save.data.scrollSpeed;
				else
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}

	override function update(elapsed:Float)
	{
				var daStage:String = PlayState.curStage;
		super.update(elapsed);
		if (mustPress)
		{
			if(daStage == 'minecraft' && intensenote){
			// ass
			if (isSustainNote)
			{
				if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.5)
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
					canBeHit = true;
				else
					canBeHit = false;
			}
			else
			{
				if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.5)
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset* 0.5))
					canBeHit = true;
				else
					canBeHit = false;
			}

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset * Conductor.timeScale && !wasGoodHit)
				tooLate = true;
			}else{
			// ass
			if (isSustainNote)
			{
				if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 1.5)
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
					canBeHit = true;
				else
					canBeHit = false;
			}
			else
			{
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
					&& strumTime < Conductor.songPosition + Conductor.safeZoneOffset)
					canBeHit = true;
				else
					canBeHit = false;
			}

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset * Conductor.timeScale && !wasGoodHit)
				tooLate = true;
		}}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;	
		}
		var daStage:String = PlayState.curStage;
		if(daStage == 'minecraft' && jumpscare && strumTime < Conductor.songPosition - 90){
		animation.play('nethvis');
			
		}
		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}