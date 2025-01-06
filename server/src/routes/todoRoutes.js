import express from "express";
import db from "../db.js";

const router = express.Router();

// Get all todos for logged-in user
router.get("/", (req, res) => {
  const getTodos = db.prepare("SELECT * FROM todos WHERE user_id = ?");
  const todos = getTodos.all(req.userId);
  res.json(todos);
});

// Create a new todo
router.post("/", (req, res) => {
  const { task } = req.body;
  try {
    const insertTodo = db.prepare(
      "INSERT INTO todos  (user_id, task) VALUES (?, ?)",
    );
    const insertTodoRes = insertTodo.run(req.userId, task);
    const result = { id: insertTodoRes.lastInsertRowid, task, completed: 0 };
    res.json(result);
  } catch (err) {
    console.log(err.message);
    res.sendStatus(503);
  }
});

// Update a todo
router.put("/:id", (req, res) => {});

// DELETE a todo
router.delete("/:id", (req, res) => {});

export default router;
