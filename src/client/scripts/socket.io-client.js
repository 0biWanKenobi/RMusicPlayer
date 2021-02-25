
// avoid global scope pollution
(() => {
    var socket = io();
    socket.onAny((event, ...args) => {
    console.log(event, args);
    });

    socket.on('play', (_) => {
    onPlayClick();
    });

    socket.on('play_channel', (args) => {        
        var radioStation = JSON.parse(args);
        onPlayChannel(radioStation);
    });

    socket.on('pause', (_) => {
    onPauseClick();
    });

    // Shorthand for $( document ).ready()
    $(function() {
        $.ajax({
            method: "POST",
            url: "/requestPlaylist",
            dataType: "json",
            error: ( jqXHR, textStatus, errorThrown ) => {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            },
            success: (data) =>  {
                updateChannelInfo(data.last_played);
                data.shoutcast.forEach(playlist_element => {
                    const dlElement = $("<li></li>");
                    dlElement.attr({"id": playlist_element.id, "class": "list-group-item"});
                    dlElement.attr("data-shoutcast", playlist_element.shoutcast_url);
                    dlElement.html(playlist_element.radio_name);
                    $("#station-list").append(dlElement);
                });
                $(`#${data.last_played.id}`).addClass("active");
            }
        })
    });

})()


