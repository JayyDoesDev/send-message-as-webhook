import { InteractionResponseType, ApplicationCommandType } from "discord-api-types/v10"
import { Interactions } from "@antibot/interactions"
import { send_content_with_webhook } from "./lib/send_content_with_webhook.js"
import { send_test_poll } from "./lib/send_test_poll.js"

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
  {
        type: ApplicationCommandType.ChatInput,
        name: 'components',
        description: 'Replies with a message with components',
        options: []
  }
  {
        type: ApplicationCommandType.ChatInput,
        name: "poll",
        description: "Create a poll",
        options: []
  }
]

handle_commands = (req, res) ->
    { type, data } = req.body

    switch data.name
        when 'ping'
          res.send 
              type: InteractionResponseType.ChannelMessageWithSource
              data: content: "Pong!"
        when 'talk' 
            await send_content_with_webhook username: 'Jasper', avatar_url: 'https://cdn.discordapp.com/avatars/846426214276923483/6db8141c019f0a1d3abe843af01ea5b2.png?size=1024', content: "SHUT UP"
            res.send 
              type: InteractionResponseType.ChannelMessageWithSource
              data: content: data.options[0].value
        when 'components'
            res.send 
              type: InteractionResponseType.ChannelMessageWithSource
              data: content: "Hello world", components: [
                  {
                      type: 1
                      components: [
                          {
                              type: 2
                              style: 1
                              label: "Button 1"
                              custom_id: "button1"
                          }
                          {
                              type: 2
                              style: 2
                              label: "Button 2"
                              custom_id: "button2"
                          }
                      ]
                  }
              ]
        when 'poll'
            await send_test_poll req.body.channel_id
            res.send 
              type: InteractionResponseType.ChannelMessageWithSource
              data: content: "Poll created!"

export { handle_commands, commands }