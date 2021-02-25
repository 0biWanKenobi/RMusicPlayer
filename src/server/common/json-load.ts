import fs from 'fs';
import { promisify } from 'util';
const promisifiedReadFile = promisify(fs.readFile);
const promisifiedWriteFile = promisify(fs.writeFile);

export async function readJson (path :string) {
    const jsonBuffer = await promisifiedReadFile(require.resolve(path));
    const jsonString = jsonBuffer.toString('utf-8')
    return JSON.parse(jsonString);
  }

export async function writeJson(path: string, json: Object){
  const fileContent = JSON.stringify(json, null, "\t");
  await promisifiedWriteFile(path, fileContent);
}