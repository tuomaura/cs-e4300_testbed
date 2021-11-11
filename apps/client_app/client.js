const http = require('http');
const fs = require('fs');
const winston = require('winston');
const { v4: uuid } = require('uuid');
const os = require("os");

// Contains server IP address and port number
const CONFIG_FILE = 'config.json';
var config = JSON.parse(fs.readFileSync(CONFIG_FILE, 'utf8'));
var hostname = os.hostname();

const logger = winston.createLogger({
    level: 'info',
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.printf(info => {
            return `${info.timestamp}: ${info.message}`;
        })
    ),
    transports: [
        new winston.transports.Console(),
        new winston.transports.File({ filename: config.log_file })
    ]
});

function log(msg) {
    logger.log({level: 'info', message: msg});
}

function ping() {
    // Send a HTTP POST containing this ping value to the server
    var ping_value = uuid().slice(24,32);
    var post_data = JSON.stringify({
        'clientname': hostname,
        'ping': ping_value
    });

    var post_options = {
      host: config.server_ip,
      port: config.server_port,
      path: '/ping',
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(post_data)
      }
    };

    var req = http.request(post_options, function(res) {
        res.setEncoding('utf8');
        res.on('data', function(res_data_str) {
            // TODO: read until end (in practice, all data is in the first IP packet)
            try {
                res_data = JSON.parse(res_data_str);
            } catch (err) {
                log(`Invalid response: ${res_data_str}\n`);
                return;
            }
            var clientname = "clientname" in res_data ? res_data.clientname : null;
            var servername = "servername" in res_data ? res_data.servername : null;
            var ping_value = "ping" in res_data ? res_data.ping : null;
            var pong_value = "pong" in res_data ? res_data.pong : null;
            if (clientname || servername || ping_value || pong_value) {
                log(`${hostname} received response from ${servername}: ${ping_value} - ${pong_value}\n`);
            } else {
                log(`Invalid response: ${res_data_str}\n`);
            }
        });
    });

    req.on('error', function(err) {
        log(`Failed to connect to the server: ${err}\n`);
    });

    log(`${hostname} sending request: ${ping_value}`);
    req.write(post_data);
    req.end();
}

function repeat_ping() {
    ping();
    setTimeout(repeat_ping, 1000);
}

repeat_ping();
