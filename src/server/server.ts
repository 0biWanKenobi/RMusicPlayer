import express from 'express';
import http from 'http'
import dgram from 'dgram'
import path from 'path'
import { getAllRadioStations, setLastPlayed } from "./controllers/radio";
import { getIpAddress } from './controllers/network';
import { RadioStationX } from './models/radio_models'


//***** DGRAM UDP DISCOVERY */
const udpSocket = dgram.createSocket('udp4');

udpSocket.on('listening', () => {
    let addr = udpSocket.address();
    console.log(`Listening for UDP packets at ${addr.address}:${addr.port}`);    
});

udpSocket.on('message', (msg: Uint8Array, rinfo: {address: string, family: string, port: number, size: number}) => {
    console.log(`Received UDP message "${msg.toString()}" from ${rinfo.address}:${rinfo.port}`);
    if(msg != null && msg.toString() == 'remote_controller_client')
        udpSocket.send('remote_radio', 8085, rinfo.address)
  });

udpSocket.bind(8082);

//***** EXPRESS CONFIGURATION */
const app = express();
const server = new http.Server(app);
const io = require('socket.io')(server, {
    cors: {
      origin: "*",
      methods: ["GET", "POST"]
    }
  });
const PORT = 8000;


app.use(express.json({ type: 'application/json', limit: '10120kb' }));
app.use(express.urlencoded({ extended: true }));
app.use(express.text({ limit: '10120kb' }));

app.use(express.static(path.join(__dirname, '../client')))

app.get('/', (_, res) => {
    res.sendFile(path.join(__dirname, '../client/index.html'));
});

app.post('/play', (_,res) => {
    io.emit('play');
    res.status(200).send();
})

app.post('/play_channel', async (req,res) => {

    const nowPlaying: RadioStationX = JSON.parse(req.body ?? '{}');
    io.emit('play_channel', JSON.stringify(nowPlaying.radioStation));
    await setLastPlayed(nowPlaying);
    res.status(200).send();
})

app.post('/pause', (_,res) => {
    io.emit('pause'); 
    res.status(200).send();
})

app.post('/requestPlaylist', async (_,res) => {
    const radioStations = await getAllRadioStations();  
    res.status(200).json(radioStations);
})

// app.listen(PORT, () => {
//     console.log(`⚡️[server]: Server is running at http://localhost:${PORT}`);
//   });

//***** SOCKET.IO CONFIGURATION */
// io.on('connection', (socket:any) => {
//     console.log('a user connected');
//   });


const network = getIpAddress();
console.log(network);

server.listen(PORT, () => {
    console.log(`⚡️[server]: Server is running at http://localhost:${PORT}`);
});