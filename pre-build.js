const fs = require('fs-extra');
const path = require('path')


function exitWithMessage(message){
    console.warn(message);
    process.exit(0);
}

async function tryOrExit({fn, beginMsg, endMsg, errorMsg}) {
    try {
        console.log(beginMsg);
        fn();
        console.log(endMsg)
    } catch (error) {
        exitWithMessage(`${errorMsg}: ${error}`);
    }
}

async function cp_assets() {
    await fs.copy('src/client/assets', 'dist/client/assets')
}

async function cp_scripts() {
    await fs.copy('src/client/scripts', 'dist/client/scripts')
}

async function cp_static() {
    const static_assets = ['favicon.ico', 'index.html'];
    for (const asset of static_assets) {
        await fs.copyFile(`src/client/${asset}`, `dist/client/${asset}`)        
    }
    await fs.copy('src/server/static', 'dist/server/static');
}

(async() => {
    await tryOrExit({
        fn: cp_assets,
        beginMsg: 'Copia assets..',
        endMsg: 'Copia assets completata',
        errorMsg: 'Error copia assets'
    });

    await tryOrExit({
        fn: cp_scripts,
        beginMsg: 'Copia scripts..',
        endMsg: 'Copia scripts completata',
        errorMsg: 'Error copia scripts'
    });

    await tryOrExit({
        fn: cp_static,
        beginMsg: 'Copia file statici..',
        endMsg: 'Copia file statici completata',
        errorMsg: 'Error copia file statici'
    });

})()