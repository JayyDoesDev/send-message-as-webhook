import express from "express"
import { config } from "dotenv"
import { verifyKeyMiddleware } from "discord-interactions"
import {
  InteractionType,
  InteractionResponseType,
  ApplicationCommandType,
} from "discord-api-types/v10"
import ngrok from "ngrok"
import { Interactions } from "@antibot/interactions"
config()

PORT = process.env.PORT
PUBLIC_KEY = process.env.PUBLIC_KEY
CLIENT_ID = process.env.CLIENT_ID
GUILD_ID = process.env.GUILD_ID
BOT_TOKEN = process.env.BOT_TOKEN
NGROK = process.env.NGROK
API_URL = 'https://discord.com/api/v10'

app = express()
interact = new Interactions
                  publicKey: PUBLIC_KEY
                  botID: CLIENT_ID
                  botToken: BOT_TOKEN
                  debug: true

commands = [
  type: ApplicationCommandType.ChatInput
  name: 'ping'
  description: 'Replies with pong!'
  options: []
]

interact.overwriteGuildCommands GUILD_ID, commands...

handle_commands = (req, res) ->
    { type, data } = req.body

    switch data.name
        when 'ping'
        then res.send 
                    type: InteractionResponseType.ChannelMessageWithSource
                    data: content: "hello world"

app.get '/helloworld', (req, res) -> res.send "hello world!"

app.post '/interactions', verifyKeyMiddleware(PUBLIC_KEY), (req, res) ->
    switch req.body.type
        when InteractionType.Ping then res.send type: InteractionResponseType.Pong
        when InteractionType.ApplicationCommand then handle_commands req, res 

app.listen PORT, () -> console.log "Now listening to #{PORT}"

console.log await ngrok.connect addr: PORT, authtoken: NGROK