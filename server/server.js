const express = require("express");
const app = express();
const PORT = 8383;

const data = {
  users: ['name1']
};

app.use(express.json());

// HTML repsonse
app.get("/", (req, res) => {
  console.log("Sending HTML res");
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

// POST
app.post("/api/data", (req, res) => {
  console.log("post req");
  const newEntry = req.body;
  data.users.push(newEntry.name);
  res.sendStatus(201);
});

app.listen(PORT, () => console.log(`Server has started on ${PORT}`));
