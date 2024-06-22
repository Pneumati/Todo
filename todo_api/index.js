const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');

// Initialize Express app
const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());
app.use(cors());

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/todo', { useNewUrlParser: true, useUnifiedTopology: true });

// Todo Schema
const todoSchema = new mongoose.Schema({
    title: String,
    description: String,
    time: Date,
    completed: Boolean
});

const Todo = mongoose.model('Todo', todoSchema);

// Endpoints
app.post('/todos', async (req, res) => {
    const todo = new Todo({
        title: req.body.title,
        description: req.body.description,
        time: req.body.time,
        completed: false
    });
    await todo.save();
    res.send(todo);
});

app.get('/todos', async (req, res) => {
    const todos = await Todo.find();
    res.send(todos);
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
