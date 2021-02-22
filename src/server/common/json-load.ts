import fs from 'fs';
import { promisify } from 'util';
const promisifiedReadFile = promisify(fs.readFile);

export async function readJson (path :string) {
    const jsonBuffer = await promisifiedReadFile(require.resolve(path));
    const jsonString = jsonBuffer.toString('utf-8')
    return JSON.parse(jsonString);
  }

