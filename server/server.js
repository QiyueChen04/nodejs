const express = require("express");
const app = express();
const PORT = 8383;

const data = {
  name: "data",
};

// HTML repsonse
app.get("/", (req, res) => {
  console.log('Sending HTML res')
  res.send(`
	<body style="">
	  <h1>Data: </h1>
	  <p>${JSON.stringify(data)}</p>
	</body>
  `);
});

// DATA response
app.get("/api/data", (req, res) => {
  console.log("get method for returning data");
  res.send(data);
});

app.listen(PORT, () => console.log(`Server has started on ${PORT}`));
