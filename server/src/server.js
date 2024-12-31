import express from "express";
import path, { dirname } from "path";
import { fileURLToPath } from "url";

const app = express();
const PORT = process.env.PORT || 5003;

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const publicDirPath = path.join(__dirname, "../public");

// ___________________________________________________________________
// MIDDLEWARE
app.use(express.json());

// Serves the HTML files from the public dir
// Tells express to serve files in public dir as static files/assets.
// Requests for the CSS files will be resolved to the public dir.
// NOTE: need this to serve correct CSS when req (GET at '/') comes
app.use(express.static(path.join(publicDirPath)));
// ___________________________________________________________________

const data = {
  users: ["name1"],
};

// serving up the HTML file from public dir
app.get("/", (req, res) => {
  // res.sendFile(path.join(__dirname, "public", "index.html")); works too, because of line 18
  res.sendFile(path.join(publicDirPath, "index.html"));
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

app.delete("/api/data", (req, res) => {
  console.log("delete req");
  data.users.pop();
  res.sendStatus(204);
});

app.listen(PORT, () => console.log(`Server has started on ${PORT}`));
