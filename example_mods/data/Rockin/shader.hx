import shaders.ColorSwap;
function onCreatePost() {
    var clorsap = new ColorSwap();
    setVar('clorsap', clorsap);
    game.camGame.setFilters([new ShaderFilter(clorsap.shader)]);
    game.camHUD.setFilters([new ShaderFilter(clorsap.shader)]);
    clorsap.hue = -0.06;
    clorsap.saturation = 0.05;
    if (!ClientPrefs.data.shaders) {
        game.camGame.filtersEnabled = false;
        game.camOther.filtersEnabled = false;
        game.camHUD.filtersEnabled = false;
    }
}