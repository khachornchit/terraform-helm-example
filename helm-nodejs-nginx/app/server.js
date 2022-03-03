const express = require('express');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const fetch = require("node-fetch");
const axios = require("axios")
const redis = require('redis')

const client = redis.createClient({
    host: 'redis',
    port: 6379,
    db: 0,
});

client.on('connect', () => {
    console.log('connected to redis');
});

const app = express();
const PORT = 3000;
const BASE_URL = 'https://api.github.com/users'

app.use(bodyParser.json());
app.use(morgan("[App Server] :method :url :status :response-time ms"));

app.get('/ping', (req, res) => {
    return res.json({
        message: 'Pong! 🏓, yeah !',
    });
});

app.get('/api/users', async (req, res) => {
    let response;

    if (process.env.NODE_ENV === 'production') {
        response = await fetch('http://user-service-clusterip-service/v1/users');
    } else {
        response = await fetch("http://localhost:4000/v1/users");
    }

    const data = await response.json();

    return res.json({
        data,
    });
});

app.get('/api/github', async (req, res) => {
    const username = req.query.username || 'khachornchit'
    const url = `${BASE_URL}/${username}`

    const response = await axios.get(url)
    res.json(response.data)
})

// Redis

async function getRepository(req, res, next) {
    try {
        console.log('Fetching data...')
        const {username} = req.params
        const response = await fetch(`https://api.github.com/users/${username}`)
        const data = await response.json(response)
        const repos = data.public_repos
        client.setex(username, 3600, repos)
        res.send(setResponse(username, repos))
    } catch (err) {
        console.error(err)
        res.status(500)
    }
}

const setResponse = (username, repos) => {
    return `github >> ${username} has ${repos} repositories!`
}

const cache = (req, res, next) => {
    const {username} = req.params;
    client.get(username, (err, data) => {
        if (err) throw err;

        if (data !== null) {
            res.send(setResponse(username, data))
        } else {
            next()
        }
    })
}

app.get('/repository/:username', cache, getRepository)

app.get('/api/redis', async (req, res) => {
    const username = req.query.username || 'khachornchit'

    client.get(username, async (error, data) => {
        if (error) {
            res.json({
                message: 'Something went wrong!',
                error
            })
        }

        if (data) {
            return res.json(JSON.parse(data))
        }

        const url = `${BASE_URL}/${username}`
        const response = await axios.get(url)

        // set แบบมี expire ด้วย (เก็บไว้ 60วินาที)
        await client.setex(username, 60, JSON.stringify(response.data))
        res.json(response.data)
    })
})

app.get('/', (req, res) => {
    return res.send('This page is rendered from the App');
})

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
})