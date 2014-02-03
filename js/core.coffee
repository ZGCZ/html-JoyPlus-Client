ws = null
gameId = 0

$(document).ready ->
  that = this
  $("#connect").click ->
    console.log "trying to connect"
    ws = new WebSocket("ws://" + $("#address").val())
    gameId = parseInt($("#gameId").val())
    ws.onmessage = onMessage.bind(that)
    ws.onopen = onWSOpen.bind(that)
    ws.onclose = onWSClose.bind(that)
    ws.onerror = onWSError.bind(that)

onMessage = (message) ->
  console.log message

onWSOpen = () ->
  console.log "ws open"
  $("#status").html "Connected"
  sendMessage
    gameId: gameId
    action: "connected"


onWSError = () ->
  ws = null
  $("#status").html "Connection error"
  console.log "connection error"

onWSClose = () ->
  ws = null
  $("#status").html "Lost connection"
  console.log "connection close"

sendMessage = (msgObject) ->
  if typeof msgObject == "object"
    message = JSON.stringify(msgObject)
  else
    message = msgObject
  ws.send(message)
