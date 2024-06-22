const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(cors());

mongoose.connect('mongodb://localhost/todo_db', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const todoSchema = new mongoose.Schema({
  title: String,
  description: String,
  time: Date,
  deadline: Date,
  priority: String,
  completed: Boolean,
});

const Todo = mongoose.model('Todo', todoSchema);

app.post('/todos', async (req, res) => {
  try {
    const todo = new Todo({
      title: req.body.title,
      description: req.body.description,
      time: req.body.time,
      deadline: req.body.deadline,
      priority: req.body.priority,
      completed: false,
    });
    await todo.save();
    res.status(201).send(todo);
  } catch (error) {
    res.status(400).send(error);
  }
});

app.get('/todos', async (req, res) => {
  try {
    const todos = await Todo.find();
    res.status(200).send(todos);
  } catch (error) {
    res.status(500).send(error);
  }
});

app.put('/todos/:id', async (req, res) => {
  try {
    const todo = await Todo.findByIdAndUpdate(req.params.id, req.body, { new: true });
    res.status(200).send(todo);
  } catch (error) {
    res.status(400).send(error);
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
