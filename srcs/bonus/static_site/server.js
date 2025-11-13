const express = require('express');
const path = require('path');
const app = express();

app.use(express.static(path.join(__dirname, 'www')));

const PORT = 2222;
app.listen(PORT, () => {
  console.log(`Static site running on port ${PORT}`);
});
