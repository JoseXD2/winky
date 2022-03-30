package;

import flixel.FlxG;
import flixel.input.FlxInput;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionInput;
import flixel.input.actions.FlxActionInputDigital;
import flixel.input.actions.FlxActionManager;
import flixel.input.actions.FlxActionSet;
import flixel.input.gamepad.FlxGamepadButton;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

#if (haxe >= "4.0.0")
enum abstract Action(String) to String from String
{
	var UP = "up";
	var LEFT = "left";
	var RIGHT = "right";
	var DOWN = "down";
	var UP_P = "up-press";
	var LEFT_P = "left-press";
	var RIGHT_P = "right-press";
	var DOWN_P = "down-press";
	var UP_R = "up-release";
	var LEFT_R = "left-release";
	var RIGHT_R = "right-release";
	var DOWN_R = "down-release";
	var EUP = "eup";
	var ELEFT = "eleft";
	var ERIGHT = "eright";
	var EDOWN = "edown";
	var EUP_P = "eup-press";
	var ELEFT_P = "eleft-press";
	var ERIGHT_P = "eright-press";
	var EDOWN_P = "edown-press";
	var EUP_R = "eup-release";
	var ELEFT_R = "eleft-release";
	var ERIGHT_R = "eright-release";
	var EDOWN_R = "edown-release";
	var SEUP = "seup";
	var SELEFT = "seleft";
	var SERIGHT = "seright";
	var SEDOWN = "sedown";
	var SEUP_P = "seup-press";
	var SELEFT_P = "seleft-press";
	var SERIGHT_P = "seright-press";
	var SEDOWN_P = "sedown-press";
	var SEUP_R = "seup-release";
	var SELEFT_R = "seleft-release";
	var SERIGHT_R = "seright-release";
	var SEDOWN_R = "sedown-release";
	var ACCEPT = "accept";
	var BACK = "back";
	var PAUSE = "pause";
	var RESET = "reset";
	var CHEAT = "cheat";
}
#else
@:enum
abstract Action(String) to String from String
{
	var UP = "up";
	var LEFT = "left";
	var RIGHT = "right";
	var DOWN = "down";
	var UP_P = "up-press";
	var LEFT_P = "left-press";
	var RIGHT_P = "right-press";
	var DOWN_P = "down-press";
	var UP_R = "up-release";
	var LEFT_R = "left-release";
	var RIGHT_R = "right-release";
	var DOWN_R = "down-release";
	var EUP = "eup";
	var ELEFT = "eleft";
	var ERIGHT = "eright";
	var EDOWN = "edown";
	var EUP_P = "eup-press";
	var ELEFT_P = "eleft-press";
	var ERIGHT_P = "eright-press";
	var EDOWN_P = "edown-press";
	var EUP_R = "eup-release";
	var ELEFT_R = "eleft-release";
	var ERIGHT_R = "eright-release";
	var EDOWN_R = "edown-release";
	var SEUP = "seup";
	var SELEFT = "seleft";
	var SERIGHT = "seright";
	var SEDOWN = "sedown";
	var SEUP_P = "seup-press";
	var SELEFT_P = "seleft-press";
	var SERIGHT_P = "seright-press";
	var SEDOWN_P = "sedown-press";
	var SEUP_R = "seup-release";
	var SELEFT_R = "seleft-release";
	var SERIGHT_R = "seright-release";
	var SEDOWN_R = "sedown-release";
	var ACCEPT = "accept";
	var BACK = "back";
	var PAUSE = "pause";
	var RESET = "reset";
	var CHEAT = "cheat";

}
#end

enum Device
{
	Keys;
	Gamepad(id:Int);
}

/**
 * Since, in many cases multiple actions should use similar keys, we don't want the
 * rebinding UI to list every action. ActionBinders are what the user percieves as
 * an input so, for instance, they can't set jump-press and jump-release to different keys.
 */
enum Control
{
	UP;
	LEFT;
	RIGHT;
	DOWN;
	EUP;
	ELEFT;
	ERIGHT;
	EDOWN;
	SEUP;
	SELEFT;
	SERIGHT;
	SEDOWN;
	RESET;
	ACCEPT;
	BACK;
	PAUSE;
	CHEAT;
}

enum KeyboardScheme
{
	Solo;
	Duo(first:Bool);
	None;
	Custom;
}

/**
 * A list of actions that a player would invoke via some input device.
 * Uses FlxActions to funnel various inputs to a single action.
 */
class Controls extends FlxActionSet
{
	var _up = new FlxActionDigital(Action.UP);
	var _left = new FlxActionDigital(Action.LEFT);
	var _right = new FlxActionDigital(Action.RIGHT);
	var _down = new FlxActionDigital(Action.DOWN);
	var _upP = new FlxActionDigital(Action.UP_P);
	var _leftP = new FlxActionDigital(Action.LEFT_P);
	var _rightP = new FlxActionDigital(Action.RIGHT_P);
	var _downP = new FlxActionDigital(Action.DOWN_P);
	var _upR = new FlxActionDigital(Action.UP_R);
	var _leftR = new FlxActionDigital(Action.LEFT_R);
	var _rightR = new FlxActionDigital(Action.RIGHT_R);
	var _downR = new FlxActionDigital(Action.DOWN_R);
	var _accept = new FlxActionDigital(Action.ACCEPT);
	var _back = new FlxActionDigital(Action.BACK);
	var _pause = new FlxActionDigital(Action.PAUSE);
	var _reset = new FlxActionDigital(Action.RESET);
	var _cheat = new FlxActionDigital(Action.CHEAT);

	var _eup = new FlxActionDigital(Action.EUP);
	var _eleft = new FlxActionDigital(Action.ELEFT);
	var _eright = new FlxActionDigital(Action.ERIGHT);
	var _edown = new FlxActionDigital(Action.EDOWN);
	var _eupP = new FlxActionDigital(Action.EUP_P);
	var _eleftP = new FlxActionDigital(Action.ELEFT_P);
	var _erightP = new FlxActionDigital(Action.ERIGHT_P);
	var _edownP = new FlxActionDigital(Action.EDOWN_P);
	var _eupR = new FlxActionDigital(Action.EUP_R);
	var _eleftR = new FlxActionDigital(Action.ELEFT_R);
	var _erightR = new FlxActionDigital(Action.ERIGHT_R);
	var _edownR = new FlxActionDigital(Action.EDOWN_R);

	var _seup = new FlxActionDigital(Action.SEUP);
	var _seleft = new FlxActionDigital(Action.SELEFT);
	var _seright = new FlxActionDigital(Action.SERIGHT);
	var _sedown = new FlxActionDigital(Action.SEDOWN);
	var _seupP = new FlxActionDigital(Action.SEUP_P);
	var _seleftP = new FlxActionDigital(Action.SELEFT_P);
	var _serightP = new FlxActionDigital(Action.SERIGHT_P);
	var _sedownP = new FlxActionDigital(Action.SEDOWN_P);
	var _seupR = new FlxActionDigital(Action.SEUP_R);
	var _seleftR = new FlxActionDigital(Action.SELEFT_R);
	var _serightR = new FlxActionDigital(Action.SERIGHT_R);
	var _sedownR = new FlxActionDigital(Action.SEDOWN_R);

	#if (haxe >= "4.0.0")
	var byName:Map<String, FlxActionDigital> = [];
	#else
	var byName:Map<String, FlxActionDigital> = new Map<String, FlxActionDigital>();
	#end

	public var gamepadsAdded:Array<Int> = [];
	public var keyboardScheme = KeyboardScheme.None;

	public var UP(get, never):Bool;



	inline function get_UP()
		return _up.check();

	public var LEFT(get, never):Bool;

	inline function get_LEFT()
		return _left.check();

	public var RIGHT(get, never):Bool;

	inline function get_RIGHT()
		return _right.check();

	public var DOWN(get, never):Bool;

	inline function get_DOWN()
		return _down.check();

	public var UP_P(get, never):Bool;

	inline function get_UP_P()
		return _upP.check();

	public var LEFT_P(get, never):Bool;

	inline function get_LEFT_P()
		return _leftP.check();

	public var RIGHT_P(get, never):Bool;

	inline function get_RIGHT_P()
		return _rightP.check();

	public var DOWN_P(get, never):Bool;

	inline function get_DOWN_P()
		return _downP.check();

	public var UP_R(get, never):Bool;

	inline function get_UP_R()
		return _upR.check();

	public var LEFT_R(get, never):Bool;

	inline function get_LEFT_R()
		return _leftR.check();

	public var RIGHT_R(get, never):Bool;

	inline function get_RIGHT_R()
		return _rightR.check();

	public var DOWN_R(get, never):Bool;

	inline function get_DOWN_R()
		return _downR.check();

	public var ACCEPT(get, never):Bool;

	inline function get_ACCEPT()
		return _accept.check();

	public var BACK(get, never):Bool;

	inline function get_BACK()
		return _back.check();

	public var PAUSE(get, never):Bool;

	inline function get_PAUSE()
		return _pause.check();

	public var RESET(get, never):Bool;

	inline function get_RESET()
		return _reset.check();

	public var CHEAT(get, never):Bool;

	inline function get_CHEAT()
		return _cheat.check();

	public var EUP(get, never):Bool;

	inline function get_EUP()
		return _eup.check();

	public var ELEFT(get, never):Bool;

	inline function get_ELEFT()
		return _eleft.check();

	public var ERIGHT(get, never):Bool;

	inline function get_ERIGHT()
		return _eright.check();

	public var EDOWN(get, never):Bool;

	inline function get_EDOWN()
		return _edown.check();

	public var EUP_P(get, never):Bool;

	inline function get_EUP_P()
		return _eupP.check();

	public var ELEFT_P(get, never):Bool;

	inline function get_ELEFT_P()
		return _eleftP.check();

	public var ERIGHT_P(get, never):Bool;

	inline function get_ERIGHT_P()
		return _erightP.check();

	public var EDOWN_P(get, never):Bool;

	inline function get_EDOWN_P()
		return _edownP.check();

	public var EUP_R(get, never):Bool;

	inline function get_EUP_R()
		return _eupR.check();

	public var ELEFT_R(get, never):Bool;

	inline function get_ELEFT_R()
		return _eleftR.check();

	public var ERIGHT_R(get, never):Bool;

	inline function get_ERIGHT_R()
		return _erightR.check();

	public var EDOWN_R(get, never):Bool;

	inline function get_EDOWN_R()
		return _edownR.check();
	
	public var SEUP(get, never):Bool;

	inline function get_SEUP()
		return _seup.check();

	public var SELEFT(get, never):Bool;

	inline function get_SELEFT()
		return _seleft.check();

	public var SERIGHT(get, never):Bool;

	inline function get_SERIGHT()
		return _seright.check();

	public var SEDOWN(get, never):Bool;

	inline function get_SEDOWN()
		return _sedown.check();

	public var SEUP_P(get, never):Bool;

	inline function get_SEUP_P()
		return _seupP.check();

	public var SELEFT_P(get, never):Bool;

	inline function get_SELEFT_P()
		return _seleftP.check();

	public var SERIGHT_P(get, never):Bool;

	inline function get_SERIGHT_P()
		return _serightP.check();

	public var SEDOWN_P(get, never):Bool;

	inline function get_SEDOWN_P()
		return _sedownP.check();

	public var SEUP_R(get, never):Bool;

	inline function get_SEUP_R()
		return _seupR.check();

	public var SELEFT_R(get, never):Bool;

	inline function get_SELEFT_R()
		return _seleftR.check();

	public var SERIGHT_R(get, never):Bool;

	inline function get_SERIGHT_R()
		return _serightR.check();

	public var SEDOWN_R(get, never):Bool;

	inline function get_SEDOWN_R()
		return _sedownR.check();
	#if (haxe >= "4.0.0")
	public function new(name, scheme = None)
	{
		super(name);

		add(_up);
		add(_left);
		add(_right);
		add(_down);
		add(_upP);
		add(_leftP);
		add(_rightP);
		add(_downP);
		add(_upR);
		add(_leftR);
		add(_rightR);
		add(_downR);

		add(_eup);
		add(_eleft);
		add(_eright);
		add(_edown);
		add(_eupP);
		add(_eleftP);
		add(_erightP);
		add(_edownP);
		add(_eupR);
		add(_eleftR);
		add(_erightR);
		add(_edownR);

		add(_seup);
		add(_seleft);
		add(_seright);
		add(_sedown);
		add(_seupP);
		add(_seleftP);
		add(_serightP);
		add(_sedownP);
		add(_seupR);
		add(_seleftR);
		add(_serightR);
		add(_sedownR);


		add(_accept);
		add(_back);
		add(_pause);
		add(_reset);
		add(_cheat);

		for (action in digitalActions)
			byName[action.name] = action;

		setKeyboardScheme(scheme, false);
	}
	#else
	public function new(name, scheme:KeyboardScheme = null)
	{
		super(name);

		add(_up);
		add(_left);
		add(_right);
		add(_down);
		add(_upP);
		add(_leftP);
		add(_rightP);
		add(_downP);
		add(_eupR);
		add(_eleftR);
		add(_erightR);
		add(_edownR);
		add(_eaccept);
		add(_back);
		add(_pause);
		add(_reset);
		add(_cheat);

		for (action in digitalActions)
			byName[action.name] = action;
			
		if (scheme == null)
			scheme = None;
		setKeyboardScheme(scheme, false);
	}
	#end

	override function update()
	{
		super.update();
	}

	// inline
	public function checkByName(name:Action):Bool
	{
		#if debug
		if (!byName.exists(name))
			throw 'Invalid name: $name';
		#end
		return byName[name].check();
	}

	public function getDialogueName(action:FlxActionDigital):String
	{
		var input = action.inputs[0];
		return switch input.device
		{
			case KEYBOARD: return '[${(input.inputID : FlxKey)}]';
			case GAMEPAD: return '(${(input.inputID : FlxGamepadInputID)})';
			case device: throw 'unhandled device: $device';
		}
	}

	public function getDialogueNameFromToken(token:String):String
	{
		return getDialogueName(getActionFromControl(Control.createByName(token.toUpperCase())));
	}

	function getActionFromControl(control:Control):FlxActionDigital
	{
		return switch (control)
		{
			case UP: _up;
			case DOWN: _down;
			case LEFT: _left;
			case RIGHT: _right;
			case EUP: _eup;
			case EDOWN: _edown;
			case ELEFT: _eleft;
			case ERIGHT: _eright;
			case SEUP: _seup;
			case SEDOWN: _sedown;
			case SELEFT: _seleft;
			case SERIGHT: _seright;
			case ACCEPT: _accept;
			case BACK: _back;
			case PAUSE: _pause;
			case RESET: _reset;
			case CHEAT: _cheat;
		}
	}

	static function init():Void
	{
		var actions = new FlxActionManager();
		FlxG.inputs.add(actions);
	}

	/**
	 * Calls a function passing each action bound by the specified control
	 * @param control
	 * @param func
	 * @return ->Void)
	 */
	function forEachBound(control:Control, func:FlxActionDigital->FlxInputState->Void)
	{
		switch (control)
		{
			case UP:
				func(_up, PRESSED);
				func(_upP, JUST_PRESSED);
				func(_upR, JUST_RELEASED);
			case LEFT:
				func(_left, PRESSED);
				func(_leftP, JUST_PRESSED);
				func(_leftR, JUST_RELEASED);
			case RIGHT:
				func(_right, PRESSED);
				func(_rightP, JUST_PRESSED);
				func(_rightR, JUST_RELEASED);
			case DOWN:
				func(_down, PRESSED);
				func(_downP, JUST_PRESSED);
				func(_downR, JUST_RELEASED);
			case EUP:
				func(_eup, PRESSED);
				func(_eupP, JUST_PRESSED);
				func(_eupR, JUST_RELEASED);
			case ELEFT:
				func(_eleft, PRESSED);
				func(_eleftP, JUST_PRESSED);
				func(_eleftR, JUST_RELEASED);
			case ERIGHT:
				func(_eright, PRESSED);
				func(_erightP, JUST_PRESSED);
				func(_erightR, JUST_RELEASED);
			case EDOWN:
				func(_edown, PRESSED);
				func(_edownP, JUST_PRESSED);
				func(_edownR, JUST_RELEASED);
			case SEUP:
				func(_seup, PRESSED);
				func(_seupP, JUST_PRESSED);
				func(_seupR, JUST_RELEASED);
			case SELEFT:
				func(_seleft, PRESSED);
				func(_seleftP, JUST_PRESSED);
				func(_seleftR, JUST_RELEASED);
			case SERIGHT:
				func(_seright, PRESSED);
				func(_serightP, JUST_PRESSED);
				func(_serightR, JUST_RELEASED);
			case SEDOWN:
				func(_sedown, PRESSED);
				func(_sedownP, JUST_PRESSED);
				func(_sedownR, JUST_RELEASED);
			case ACCEPT:
				func(_accept, JUST_PRESSED);
			case BACK:
				func(_back, JUST_PRESSED);
			case PAUSE:
				func(_pause, JUST_PRESSED);
			case RESET:
				func(_reset, JUST_PRESSED);
			case CHEAT:
				func(_cheat, JUST_PRESSED);
		}
	}

	public function replaceBinding(control:Control, device:Device, ?toAdd:Int, ?toRemove:Int)
	{
		if (toAdd == toRemove)
			return;

		switch (device)
		{
			case Keys:
				if (toRemove != null)
					unbindKeys(control, [toRemove]);
				if (toAdd != null)
					bindKeys(control, [toAdd]);

			case Gamepad(id):
				if (toRemove != null)
					unbindButtons(control, id, [toRemove]);
				if (toAdd != null)
					bindButtons(control, id, [toAdd]);
		}
	}

	public function copyFrom(controls:Controls, ?device:Device)
	{
		#if (haxe >= "4.0.0")
		for (name => action in controls.byName)
		{
			for (input in action.inputs)
			{
				if (device == null || isDevice(input, device))
					byName[name].add(cast input);
			}
		}
		#else
		for (name in controls.byName.keys())
		{
			var action = controls.byName[name];
			for (input in action.inputs)
			{
				if (device == null || isDevice(input, device))
				byName[name].add(cast input);
			}
		}
		#end

		switch (device)
		{
			case null:
				// add all
				#if (haxe >= "4.0.0")
				for (gamepad in controls.gamepadsAdded)
					if (!gamepadsAdded.contains(gamepad))
						gamepadsAdded.push(gamepad);
				#else
				for (gamepad in controls.gamepadsAdded)
					if (gamepadsAdded.indexOf(gamepad) == -1)
					  gamepadsAdded.push(gamepad);
				#end

				mergeKeyboardScheme(controls.keyboardScheme);

			case Gamepad(id):
				gamepadsAdded.push(id);
			case Keys:
				mergeKeyboardScheme(controls.keyboardScheme);
		}
	}

	inline public function copyTo(controls:Controls, ?device:Device)
	{
		controls.copyFrom(this, device);
	}

	function mergeKeyboardScheme(scheme:KeyboardScheme):Void
	{
		if (scheme != None)
		{
			switch (keyboardScheme)
			{
				case None:
					keyboardScheme = scheme;
				default:
					keyboardScheme = Custom;
			}
		}
	}

	/**
	 * Sets all actions that pertain to the binder to trigger when the supplied keys are used.
	 * If binder is a literal you can inline this
	 */
	public function bindKeys(control:Control, keys:Array<FlxKey>)
	{
		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, state) -> addKeys(action, keys, state));
		#else
		forEachBound(control, function(action, state) addKeys(action, keys, state));
		#end
	}

	/**
	 * Sets all actions that pertain to the binder to trigger when the supplied keys are used.
	 * If binder is a literal you can inline this
	 */
	public function unbindKeys(control:Control, keys:Array<FlxKey>)
	{
		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, _) -> removeKeys(action, keys));
		#else
		forEachBound(control, function(action, _) removeKeys(action, keys));
		#end
	}

	inline static function addKeys(action:FlxActionDigital, keys:Array<FlxKey>, state:FlxInputState)
	{
		for (key in keys)
			action.addKey(key, state);
	}

	static function removeKeys(action:FlxActionDigital, keys:Array<FlxKey>)
	{
		var i = action.inputs.length;
		while (i-- > 0)
		{
			var input = action.inputs[i];
			if (input.device == KEYBOARD && keys.indexOf(cast input.inputID) != -1)
				action.remove(input);
		}
	}

	public function setKeyboardScheme(scheme:KeyboardScheme, reset = true)
	{

		loadKeyBinds();

	}

	public function loadKeyBinds()
	{

		trace(FlxKey.fromString(FlxG.save.data.EupBind));

		removeKeyboard();
	
		inline bindKeys(Control.UP, [FlxKey.fromString(FlxG.save.data.upBind), FlxKey.UP]);
		inline bindKeys(Control.DOWN, [FlxKey.fromString(FlxG.save.data.downBind), FlxKey.DOWN]);
		inline bindKeys(Control.LEFT, [FlxKey.fromString(FlxG.save.data.leftBind), FlxKey.LEFT]);
		inline bindKeys(Control.RIGHT, [FlxKey.fromString(FlxG.save.data.rightBind), FlxKey.RIGHT]);
		inline bindKeys(Control.EUP, [FlxKey.fromString(FlxG.save.data.eupBind), FlxKey.W]);
		inline bindKeys(Control.EDOWN, [FlxKey.fromString(FlxG.save.data.edownBind), FlxKey.S]);
		inline bindKeys(Control.ELEFT, [FlxKey.fromString(FlxG.save.data.eleftBind), FlxKey.A]);
		inline bindKeys(Control.ERIGHT, [FlxKey.fromString(FlxG.save.data.erightBind), FlxKey.D]);
		inline bindKeys(Control.SEUP, [FlxKey.fromString(FlxG.save.data.seupBind), FlxKey.I]);
		inline bindKeys(Control.SEDOWN, [FlxKey.fromString(FlxG.save.data.sedownBind), FlxKey.K]);
		inline bindKeys(Control.SELEFT, [FlxKey.fromString(FlxG.save.data.seleftBind), FlxKey.J]);
		inline bindKeys(Control.SERIGHT, [FlxKey.fromString(FlxG.save.data.serightBind), FlxKey.L]);
		inline bindKeys(Control.ACCEPT, [Z, SPACE, ENTER]);
		inline bindKeys(Control.BACK, [BACKSPACE, ESCAPE]);
		inline bindKeys(Control.PAUSE, [P, ENTER, ESCAPE]);
		inline bindKeys(Control.RESET, [FlxKey.fromString(FlxG.save.data.killBind)]);
	}

	function removeKeyboard()
	{
		for (action in this.digitalActions)
		{
			var i = action.inputs.length;
			while (i-- > 0)
			{
				var input = action.inputs[i];
				if (input.device == KEYBOARD)
					action.remove(input);
			}
		}
	}

	public function addGamepad(id:Int, ?buttonMap:Map<Control, Array<FlxGamepadInputID>>):Void
	{
		gamepadsAdded.push(id);
		
		#if (haxe >= "4.0.0")
		for (control => buttons in buttonMap)
			inline bindButtons(control, id, buttons);
		#else
		for (control in buttonMap.keys())
			bindButtons(control, id, buttonMap[control]);
		#end
	}

	inline function addGamepadLiteral(id:Int, ?buttonMap:Map<Control, Array<FlxGamepadInputID>>):Void
	{
		gamepadsAdded.push(id);

		#if (haxe >= "4.0.0")
		for (control => buttons in buttonMap)
			inline bindButtons(control, id, buttons);
		#else
		for (control in buttonMap.keys())
			bindButtons(control, id, buttonMap[control]);
		#end
	}

	public function removeGamepad(deviceID:Int = FlxInputDeviceID.ALL):Void
	{
		for (action in this.digitalActions)
		{
			var i = action.inputs.length;
			while (i-- > 0)
			{
				var input = action.inputs[i];
				if (input.device == GAMEPAD && (deviceID == FlxInputDeviceID.ALL || input.deviceID == deviceID))
					action.remove(input);
			}
		}

		gamepadsAdded.remove(deviceID);
	}

	public function addDefaultGamepad(id):Void
	{
		#if !switch
		addGamepadLiteral(id, [
			Control.ACCEPT => [A],
			Control.BACK => [B],
			Control.UP => [DPAD_UP, LEFT_STICK_DIGITAL_UP],
			Control.DOWN => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
			Control.LEFT => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
			Control.RIGHT => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
			Control.PAUSE => [START],
			Control.RESET => [Y]
		]);
		#else
		addGamepadLiteral(id, [
			//Swap A and B for switch
			Control.ACCEPT => [B],
			Control.BACK => [A],
			Control.UP => [DPAD_UP, LEFT_STICK_DIGITAL_UP, RIGHT_STICK_DIGITAL_UP],
			Control.DOWN => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN, RIGHT_STICK_DIGITAL_DOWN],
			Control.LEFT => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT, RIGHT_STICK_DIGITAL_LEFT],
			Control.RIGHT => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT, RIGHT_STICK_DIGITAL_RIGHT],
			Control.PAUSE => [START],
			//Swap Y and X for switch
			Control.RESET => [Y],
			Control.CHEAT => [X]
		]);
		#end
	}

	/**
	 * Sets all actions that pertain to the binder to trigger when the supplied keys are used.
	 * If binder is a literal you can inline this
	 */
	public function bindButtons(control:Control, id, buttons)
	{
		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, state) -> addButtons(action, buttons, state, id));
		#else
		forEachBound(control, function(action, state) addButtons(action, buttons, state, id));
		#end
	}

	/**
	 * Sets all actions that pertain to the binder to trigger when the supplied keys are used.
	 * If binder is a literal you can inline this
	 */
	public function unbindButtons(control:Control, gamepadID:Int, buttons)
	{
		#if (haxe >= "4.0.0")
		inline forEachBound(control, (action, _) -> removeButtons(action, gamepadID, buttons));
		#else
		forEachBound(control, function(action, _) removeButtons(action, gamepadID, buttons));
		#end
	}

	inline static function addButtons(action:FlxActionDigital, buttons:Array<FlxGamepadInputID>, state, id)
	{
		for (button in buttons)
			action.addGamepad(button, state, id);
	}

	static function removeButtons(action:FlxActionDigital, gamepadID:Int, buttons:Array<FlxGamepadInputID>)
	{
		var i = action.inputs.length;
		while (i-- > 0)
		{
			var input = action.inputs[i];
			if (isGamepad(input, gamepadID) && buttons.indexOf(cast input.inputID) != -1)
				action.remove(input);
		}
	}

	public function getInputsFor(control:Control, device:Device, ?list:Array<Int>):Array<Int>
	{
		if (list == null)
			list = [];

		switch (device)
		{
			case Keys:
				for (input in getActionFromControl(control).inputs)
				{
					if (input.device == KEYBOARD)
						list.push(input.inputID);
				}
			case Gamepad(id):
				for (input in getActionFromControl(control).inputs)
				{
					if (input.deviceID == id)
						list.push(input.inputID);
				}
		}
		return list;
	}

	public function removeDevice(device:Device)
	{
		switch (device)
		{
			case Keys:
				setKeyboardScheme(None);
			case Gamepad(id):
				removeGamepad(id);
		}
	}

	static function isDevice(input:FlxActionInput, device:Device)
	{
		return switch device
		{
			case Keys: input.device == KEYBOARD;
			case Gamepad(id): isGamepad(input, id);
		}
	}

	inline static function isGamepad(input:FlxActionInput, deviceID:Int)
	{
		return input.device == GAMEPAD && (deviceID == FlxInputDeviceID.ALL || input.deviceID == deviceID);
	}
}
