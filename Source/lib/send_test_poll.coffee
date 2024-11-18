import { v9 } from "./api.js"

send_test_poll = (channel_id) ->
    BOT_TOKEN = process.env.BOT_TOKEN
    url = v9 "/channels/#{channel_id}/messages"
    super_build = client_build_number: 277953
    json_to_string = JSON.stringify super_build
    encoded_string = new TextEncoder().encode json_to_string
    super_value = btoa String.fromCharCode.apply null, encoded_string
    poll = 
        flags: 0
        poll:
            question: text: "This is a test poll!"
            answers: [{poll_media: text: "something"}, {poll_media: text: "something"}]
            allow_multiselect: false
            duration: 60
            layout_type: 1
    response = await fetch url, 
        method: 'POST'
        headers: 
            'Authorization': "Bot #{BOT_TOKEN}"
            'X-Super-Properties': super_value
            'Content-Type': 'application/json'
        body: JSON.stringify poll

export { send_test_poll }