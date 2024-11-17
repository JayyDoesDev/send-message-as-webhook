import { InteractionResponseType, ApplicationCommandType } from "discord-api-types/v10"
import { Interactions } from "@antibot/interactions"
import { send_content_with_webhook } from "./lib/send_content_with_webhook.js"

commands = [
  {
      type: ApplicationCommandType.ChatInput
      name: 'ping'
      description: 'Replies with pong!'
      options: []
  }
  {
      type: ApplicationCommandType.ChatInput
      name: 'talk'
      description: 'Replies with the message you sent'
      options: [
          {
              type: 3
              name: 'message'
              description: 'The message you want to send'
              required: true
          }
      ]
  }
]

handle_commands = (req, res) ->
    { type, data } = req.body

    switch data.name
        when 'ping'
          res.send 
              type: InteractionResponseType.ChannelMessageWithSource
              data: content: "hello world"
        when 'talk' 
            await send_content_with_webhook username: 'Jasper', avatar_url: 'https://cdn.discordapp.com/avatars/846426214276923483/6db8141c019f0a1d3abe843af01ea5b2.png?size=1024', content: "SHUT UP"
            res.send 
              type: InteractionResponseType.ChannelMessageWithSource
              data: content: data.options[0].value

export { handle_commands, commands }