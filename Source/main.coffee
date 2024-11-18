import express from "express"
import { config } from "dotenv"
import { verifyKeyMiddleware } from "discord-interactions"
import {
  InteractionType,
  InteractionResponseType,
  ApplicationCommandType,
} from "discord-api-types/v10"
import ngrok from "ngrok"
import { handle_commands, commands } from "./handle_commands.js"
import { handle_message_components } from "./handle_message_components.js"
import { Interactions } from "@antibot/interactions"
config()

PORT = process.env.PORT
PUBLIC_KEY = process.env.PUBLIC_KEY
CLIENT_ID = process.env.CLIENT_ID
GUILD_ID = process.env.GUILD_ID
BOT_TOKEN = process.env.BOT_TOKEN
NGROK = process.env.NGROK
WEBHOOK_ID = process.env.WEBHOOK_ID

app = express()

interact = new Interactions
                  publicKey: PUBLIC_KEY
                  botID: CLIENT_ID
                  botToken: BOT_TOKEN
                  debug: true


interact.overwriteGuildCommands GUILD_ID, commands...

send_test_poll = () -> console.log "test poll"

app.get '/helloworld', (req, res) -> res.send "hello world!"

app.post '/interactions', verifyKeyMiddleware(PUBLIC_KEY), (req, res) ->
    switch req.body.type
        when InteractionType.Ping then res.send type: InteractionResponseType.Pong
        when InteractionType.ApplicationCommand then await handle_commands req, res
        when InteractionType.MessageComponent then await handle_message_components req, res 

app.listen PORT, () -> console.log "Now listening to #{PORT}"

console.log await ngrok.connect addr: PORT, authtoken: NGROK