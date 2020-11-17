const express = require('express');
const body_parser = require("body-parser");
const winston = require('winston');
const fs = require('fs');
const { v4: uuid } = require('uuid');
const os = require("os");

const app = express();
app.use(body_parser.urlencoded({extended: false}));
app.use(body_parser.json());

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

app.post('/ping', function(req, res){
    try {
        var clientname = "clientname" in req.body ? req.body.clientname : null;
        var ping_value = "ping" in req.body ? req.body.ping : null;
        if (ping_value || clientname) {
            var pong_value = uuid().slice(24,32);
            log(`${hostname} received request from ${clientname}: ${ping_value}`);
            log(`${hostname} responding to ${clientname}: ${ping_value} - ${pong_value}\n`);
            res.send(JSON.stringify({
                'clientname': clientname,
                'servername': hostname,
                'ping': ping_value,
                'pong': pong_value
            }));
        } else {
            log(`Invalid request: ${JSON.stringify(req.body)}\n`);
            res.send(JSON.stringify({'error': 'invalid request'}));
        }
    } catch (err) {
        log(`${err}\n`);
    }
})

app.listen(config.server_port, function(err){
    if (err) {
        log(`Failed to start the server: ${err}`);
        return;
    }
    log(`Server is listening on port ${config.server_port}...`);
})
