const express = require('express')
const app = express()
const port = 3000

app.get('/health', (req, res) => {
  res.send('How are you feeling today!')
})

app.get('/', (req, res) => {
  res.send('My third big test!')
})

app.get('/change', (req, res) => {
  res.send('New deployment test!')
})

app.listen(port, () => {
  console.log(`Example app listening is port ${port}`)
})
