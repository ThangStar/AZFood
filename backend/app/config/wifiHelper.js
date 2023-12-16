const { networkInterfaces } = require('os');

const nets = networkInterfaces();

const checkAddressWifi = () => {
    const wifiIPAddresses = [];
    for (const name of Object.keys(nets)) {
        for (const net of nets[name]) {
            const isIPv4 = typeof net.family === 'string' ? net.family === 'IPv4' : net.family === 4;
            if (isIPv4 && !net.internal) {
                wifiIPAddresses.push(net.address);
            }
        }
    }

    if (wifiIPAddresses[0] === process.env.IPWF) {
        console.log("Đúng địa chỉ wifi ");
        return true;
    } else {
        console.log("Sai địa chỉ wifi ");
        return false;
    }
};

module.exports = checkAddressWifi;
