import {readJson} from '../common/json-load'
import streamTitle from './radio_metadata';

export async function getAllRadioStations() {
    const radioStations = await readJson('../static/radio-stations.json');
    return radioStations;
}


export async function getRadioMetaData(url: string, type: string) : Promise<string | undefined>{
    return streamTitle({
        url: url,
        type: type
    });
}