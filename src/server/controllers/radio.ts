import {readJson, writeJson} from '../common/json-load'
import { PlayList, RadioStation, RadioStationX } from '../models/radio_models';
import streamTitle from './radio_metadata';
import path from 'path';

const _jsonConfigPath = '../static/radio-stations.json';

export async function getAllRadioStations() : Promise<PlayList> {
    const radioStations = await readJson(_jsonConfigPath);
    return radioStations;
}

export async function setLastPlayed(lastPlayed: RadioStationX) :Promise<void>{
    const radioStations = await getAllRadioStations();
    radioStations.last_played = lastPlayed;
    const savePath = path.join(__dirname, _jsonConfigPath)
    await writeJson(savePath, radioStations);
}


export async function getRadioMetaData(url: string, type: string) : Promise<string | undefined>{
    return streamTitle({
        url: url,
        type: type
    });
}