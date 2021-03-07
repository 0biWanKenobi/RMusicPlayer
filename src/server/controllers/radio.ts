import {readJson, writeJson} from '../common/json-load'
import { PlayList, RadioStationX } from '../models/radio_models';
import path from 'path';

const _jsonConfigPath = '../static/radio-stations.json';

export async function getAllRadioStations() : Promise<PlayList> {
    const radioStations : PlayList = await readJson(_jsonConfigPath);
    return radioStations;
}

export async function setLastPlayed(lastPlayed: RadioStationX) :Promise<void>{
    const radioStations = await getAllRadioStations();
    radioStations.last_played = lastPlayed;
    const savePath = path.join(__dirname, _jsonConfigPath)
    await writeJson(savePath, radioStations);
}