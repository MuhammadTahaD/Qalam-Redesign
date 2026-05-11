/**
 * File: backend/src/config/db.js
 * Purpose: MongoDB database connection configuration and initialization.
 */
const mongoose = require('mongoose');

const connectDB = async () => {
  await mongoose.connect(process.env.MONGO_URI);
  console.log('MongoDB connected');
};

module.exports = connectDB;
