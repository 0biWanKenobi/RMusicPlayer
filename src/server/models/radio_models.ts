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

export class RadioStationX{
    listIndex: number;
    radioStation: RadioStation;

    constructor(radioStation: RadioStation, listIndex: number ){
        this.listIndex = listIndex;
        this.radioStation = radioStation;
    }
}

export class PlayList {
    shoutcast: RadioStation[];
    last_played: RadioStationX;

    constructor(shoutcast: RadioStation[], last_played: RadioStationX){
        this.shoutcast = shoutcast;
        this.last_played = last_played;
    }
}