window.addEventListener('load', () => {
  const myPlaylists = async () => {
    const my = document.getElementById('my-playlists')
    const fav = document.getElementById('fav-playlists')
    fav.innerHTML = `
    <div class="loading"><svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-ear" viewBox="0 0 16 16">
      <path d="M8.5 1A4.5 4.5 0 0 0 4 5.5v7.047a2.453 2.453 0 0 0 4.75.861l.512-1.363a5.553 5.553 0 0 1 .816-1.46l2.008-2.581A4.34 4.34 0 0 0 8.66 1H8.5ZM3 5.5A5.5 5.5 0 0 1 8.5 0h.16a5.34 5.34 0 0 1 4.215 8.618l-2.008 2.581a4.555 4.555 0 0 0-.67 1.197l-.51 1.363A3.453 3.453 0 0 1 3 12.547V5.5ZM8.5 4A1.5 1.5 0 0 0 7 5.5v2.695c.112-.06.223-.123.332-.192.327-.208.577-.44.72-.727a.5.5 0 1 1 .895.448c-.256.513-.673.865-1.079 1.123A8.538 8.538 0 0 1 7 9.313V11.5a.5.5 0 0 1-1 0v-6a2.5 2.5 0 0 1 5 0V6a.5.5 0 0 1-1 0v-.5A1.5 1.5 0 0 0 8.5 4Z"/>
    </svg></div>`

    const response = await fetch('/api/playlists')
    const json = await response.json()
    if (!json.result) {
      alert('自分のプレイリスト取得失敗 (ログインしてますか?)')
    }

    my.innerHTML = json.created_playlists.map((x) => playlistToHTML(x, true)).join('\n')

    fav.innerHTML = json.favorited_playlists.map((x) => playlistToHTML(x, false)).join('\n')

    return response
  }

  const addPlaylist = async (title) => {
    const response = await fetch(`/api/playlist/add`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        name: title,
      })
    })
    const json = await response.json()
    if (!json.result) {
      alert('追加失敗 (ログインしてますか?)')
    }
    return response
  }



  const main = document.getElementById('main-app')
  main.addEventListener('refreshRequired', () => {
    myPlaylists()
  })

  const addButton = document.getElementById('add-playlist')
  addButton.addEventListener('click', async () => {
    const message = window.prompt("新しいプレイリストの名前を入力")
    if (!message) {
      // キャンセルした(null)か、空文字でOKした
      return
    }

    await addPlaylist(message)

    const event = new Event('refreshRequired')
    const elem = document.getElementById('main-app')
    elem.dispatchEvent(event)
  })

  myPlaylists()
})

