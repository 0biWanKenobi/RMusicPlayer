
import { URL } from "url";
import axios from 'axios';
const slash = require('super-trailing-slash');

/**
 * Get song title from icecast v2.4
 * @param url
 * @param timeout
 * @param mount
 */
async function getFromIcecast(url: string, timeout: number) :Promise<string>{

    if (typeof url === 'undefined')
        throw new Error('required url');


    url = url + '/status-json.xsl';
    const response = await axios.get(url, {
        timeout: timeout
    })


    let data = JSON.parse(response.data);
    let title = '';


    if (
        !data.icestats ||
        !data.icestats.source ||
        data.icestats.source.length === 0
      ) {
        throw new Error('Unable to determine current station information.');
      }

      var sources = data.icestats.source;
      for (var i = 0, mountCount = sources.length; i < mountCount; i++) {
        var source = sources[i];
        if (source.listenurl === url) {    
          return source.title
        }
      }
      throw new Error('Unable to determine current station information.')
}

/**
 * Get song title from shoutcast v2
 * @param url
 * @param timeout
 * @param sid
 * @returns {PromiseLike<T> | Promise<T>}
 */
async function getFromShoutcast2(url: string, sid: number, timeout: number): Promise<string> {

    if (typeof url === 'undefined')
        throw new Error('required url');

    if (typeof sid === 'undefined')
        throw new Error('required sid');

    url = url + '/stats?sid=' + sid + '&json=1';

    const response = await axios.get(url, {timeout: timeout})
    let data = JSON.parse(response.data);
    return data['songtitle'];
}

/**
 * Get song title from shoutcast v1
 * @param url
 * @param timeout
 * @returns {PromiseLike<T> | Promise<T>}
 */
async function getFromShoutcast(url: string, timeout: number): Promise<string>{

    if (typeof url === 'undefined')
        throw new Error('required url');

    url = url + '/7.html';

    const response = await axios.get(url, {timeout: timeout, headers: {
        'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.13) Gecko/20080311 Firefox/2.0.0.13'
    }})
    let body = JSON.parse(response.data);
  
    let match = (/<body>\d*,\d*,\d*,\d*,\d*,\d*,([\s\S]*?)<\/body>/).exec(body);
    return match && match[1].length > 0 ? match[1] : '';
  
}

/**
 * Retrieve song info
 * @param args
 * @returns {*}
 */
export default function streamTitle(args: {url:string, type: string, timeout?: number, sid?: number}) : Promise<string> | undefined{

    if (typeof args.url === 'undefined')
        throw new Error('required url');

    if (typeof args.type === 'undefined')
        throw new Error('required type');

    if (typeof args.timeout !== 'number')
        args.timeout = 1500;

    args.url = slash.remove(args.url);

    switch (args.type) {
        case 'shoutcast2': {
            if (typeof args.sid === 'undefined')
                throw new Error('required sid');
            return getFromShoutcast2(
                args.url,
                args.sid,
                args.timeout
            );
        }
        case 'icecast': {           
            return getFromIcecast(
                args.url,
                args.timeout
            );
        }
        case 'shoutcast': {
            return getFromShoutcast(
                args.url,
                args.timeout
            );
        }
    }

}
