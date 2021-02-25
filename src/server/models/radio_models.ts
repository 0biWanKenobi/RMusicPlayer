export class RadioStation {
    radio_name: string;
    image: string;
    image_flag: string;
    id: string;
    shoutcast_url: string;
    format: string;


    constructor(radio_name: string, image: string, image_flag: string, id: string, shoutcast_url: string, format: string  ){
        this.radio_name = radio_name;
        this.image = image;
        this.image_flag = image_flag;
        this.id = id;
        this.shoutcast_url = shoutcast_url;
        this.format = format;
    }
}

export class PlayList {
    shoutcast: RadioStation[];
    last_played: RadioStation;

    constructor(shoutcast: RadioStation[], last_played: RadioStation){
        this.shoutcast = shoutcast;
        this.last_played = last_played;
    }
}