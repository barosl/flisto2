window.AudioContext = window.AudioContext||window.webkitAudioContext

class PngPlayer
    play: (url) ->
        console.log("loading...")
        xhr = new XMLHttpRequest()
        xhr.open("GET", url, true)
        xhr.responseType = "arraybuffer"
        xhr.onload = =>
            data = new Uint8Array(xhr.response || xhr.mozResponseArrayBuffer)
            png = new PNG(data)
            dat = png.decodePixels()
            context = new window.AudioContext()
            source = context.createBufferSource()
            console.log("decoding...")
            context.decodeAudioData dat.buffer, (buf) ->
                source.buffer = buf
                source.loop = false
                source.connect(context.destination)
                source.start(0)
                console.log("start!")
            , (err) ->
                console.error(err)
        xhr.send(null)

window.PngPlayer = PngPlayer
