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

  $("#button-click").on("mousedown", ->
    sendMessage(
      event: 'keydown'
      key: 'click'
    )
  )
  $("#button-click").on("mouseup", ->
    sendMessage(
      event: 'keyup'
      key: 'click'
    )
  )

  $("#button-right").on("mousedown", ->
    sendMessage(
      event: 'keydown'
      key: 'right'
    )
  )
  $("#button-right").on("mouseup", ->
    sendMessage(
      event: 'keyup'
      key: 'right'
    )
  )

  $("#button-up").on("mousedown", ->
    sendMessage(
      event: 'keydown'
      key: 'up'
    )
  )
  $("#button-down").on("mouseup", ->
    sendMessage(
      event: 'keyup'
      key: 'down'
    )
  )

  $("#button-down").on("mousedown", ->
    sendMessage(
      event: 'keydown'
      key: 'down'
    )
  )
  $("#button-up").on("mouseup", ->
    sendMessage(
      event: 'keyup'
      key: 'up'
    )
  )

  $("#button-left").on("mousedown", ->
    sendMessage(
      event: 'keydown'
      key: 'left'
    )
  )
  $("#button-left").on("mouseup", ->
    sendMessage(
      event: 'keyup'
      key: 'left'
    )
  )

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
