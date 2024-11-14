import express from "express"
import { config } from "dotenv"
import { verifyKeyMiddware } from "discord-interactions"
import {
  APIChatInputApplicationCommandInteraction,
  APIApplicationCommand,
  APIContextMenuInteraction,
  InteractionType,
  InteractionResponseType,
} from "discord-api-types/v10"

config()

app = express()

PORT = process.env.PORT
PUBLIC_KEY = process.env.PUBLIC_KEY

handle_commands = (req, res) ->
    { type, data } = req.body

    switch data.name
        when 'ping'
        then res.send 

app.get '/helloworld', (req, res) -> res.send "hello world!"

app.post '/interactions', verifyKeyMiddware(PUBLIC_KEY), (req, res) ->
    switch type
        when InteractionType.Ping then res.send type: InteractionResponseType.Pong
        when InteractionType.ApplicationCommand then handle_commands req, res 

app.listen PORT, () -> console.log "Now listening to #{PORT}"