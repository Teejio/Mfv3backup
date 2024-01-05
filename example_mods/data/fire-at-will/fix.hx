var char:Character;
var char2:Character;
function onCreate() {
	char = new Character(game.dad.x - 400, game.dad.y - 175, 'WolfTM');
	game.addBehindDad(char);
	setVar('wolf', char);
	char.playAnim('idle');
	char2 = new Character(game.boyfriend.x + 350, game.boyfriend.y - 75, 'LucasTM', true);
	game.addBehindBF(char2);
	setVar('lucas', char2);
	char2.playAnim('idle');
}
