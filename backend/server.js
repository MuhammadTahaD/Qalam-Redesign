require('dotenv').config();

const app = require('./src/app');
const connectDB = require('./src/config/db');

const port = process.env.PORT || 5000;

(async () => {
  try {
    await connectDB();
    app.listen(port, () => {
      console.log(`Server running on http://localhost:${port}`);
    });
  } catch (error) {
    console.error('Failed to start server:', error.message);
    process.exit(1);
  }
})();
