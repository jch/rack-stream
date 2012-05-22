# Rack::Stream Chat

This is a demo of using [Rack::Stream](https://github.com/jch/rack-stream) with Sinatra. The app uses redis for persistence and pubsub, and can understand normal HTTP, WebSockets, and EventSource. To try the live demo, [visit the heroku app]().

## Local Setup

To run this example locally, you'll need to have redis installed and running. After that, to setup the project:

```
git clone https://github.com/jch/rack-stream
cd rack-stream
bundle
bundle exec thin start
```