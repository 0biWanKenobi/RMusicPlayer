var music = document.getElementById("music");
var playButton = document.getElementById("play");
var pauseButton = document.getElementById("pause");
var playhead = document.getElementById("elapsed");

pauseButton.style.display = "none";


const onPlayClick = function() {
	music.play();
	playButton.style.display = "none";
	pause.style.display = "inline";
}

const onPlayChannel = function(channel) {
	let player = $("#music-source");	
	player
		.attr({src: channel.shoutcast_url, type: channel.format})
		.detach()
		.appendTo($("#music"));
	music.pause();
	music.load();
	updateChannelInfo(channel);
	music.oncanplaythrough = onPlayClick();
}

const updateChannelInfo = function(info){
	$("#radio-name").html(info.radio_name);
	$("#program-name").html(info.program_name);
	$("#radio-logo").attr("src", info.image);
	$("#station-list li").removeClass('active');
	$(`#${info.id}`).addClass('active');
}

playButton.onclick = onPlayClick;

const onPauseClick = function() {
	music.pause();
	playButton.style.display = "inline";
	pause.style.display = "none";
}

pauseButton.onclick = onPauseClick;

