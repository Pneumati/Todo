const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();


app.use(bodyParser.json());
app.use(cors());

mongoose.connect('mongodb://localhost:27017/todo_app', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.log(err));


const Todo = mongoose.model('Todo', new mongoose.Schema({
  title: String,
  description: String,
  time: Date,
  deadline: Date,
  priority: String,
  completed: Boolean,
}));


app.get('/todos', async (req, res) => {
  const todos = await Todo.find();
  res.json(todos);
});

app.post('/todos', async (req, res) => {
  const { title, description, time, deadline, priority } = req.body;
  const todo = new Todo({
    title,
    description,
    time,
    deadline,
    priority,
    completed: false,
  });
  await todo.save();
  res.json(todo);
});

app.put('/todos/:id', async (req, res) => {
  const { id } = req.params;
  const { completed } = req.body;
  const todo = await Todo.findByIdAndUpdate(id, { completed }, { new: true });
  res.json(todo);
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
