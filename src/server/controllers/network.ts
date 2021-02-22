import { networkInterfaces } from 'os';



export function getIpAddress(){
    
    const nets = networkInterfaces();
    const results = Object.create({}); // Or just '{}', an empty object
    

    for (const name of Object.keys(nets)) {
        const netsByName = nets[name];
        if(typeof netsByName === 'undefined') continue;

        for (const net of netsByName) {        
            // Skip over non-IPv4 and internal (i.e. 127.0.0.1) addresses
            if(!(net.family === 'IPv4') || net.internal) continue;
            
            if (!results[name]) {
                results[name] = [];
            }
            results[name].push(net.address);
            
        }
    }

    return results;
}
