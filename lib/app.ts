import http from 'http'
import path from 'path'

import express from 'express'

const api = express()

api.use('/', express.static(path.join(__dirname, '..', 'public')))

const server = http.createServer(api)

server.listen(3_000)